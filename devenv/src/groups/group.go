package groups

import (
	"devenv/config"
	"devenv/ops"
	"fmt"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v3"
)

// Options controls which operations are skipped during Apply.
type Options struct {
	SkipBrew  bool
	SkipCasks bool
	DryRun    bool
}

// Group is a named set of setup operations driven entirely by its GroupConfig.
// No Go code encodes per-group logic — all behaviour comes from the YAML config.
type Group struct {
	name string
	cfg  config.GroupConfig
}

func (g Group) Name() string             { return g.name }
func (g Group) Config() config.GroupConfig { return g.cfg }

// Apply executes all operations defined in the group's config in a fixed order:
//  1. git submodule updates
//  2. homebrew taps → packages → casks
//  3. directory creation
//  4. symlinks
//  5. shell line-in-file entries
//  6. python venv creation + pip installs
//  7. npm global installs
func (g Group) Apply(opts Options) error {
	cfg := g.cfg
	name := g.name

	// Git submodules
	if len(cfg.GitSubmodules) > 0 {
		ops.PrintTask(name, "Update git submodules")
		for _, repo := range cfg.GitSubmodules {
			r, err := ops.GitUpdateSubmodules(repo)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] git submodule update %s: %w", name, repo, err))
			}
			ops.PrintResult(r, repo)
		}
		fmt.Println()
	}

	// Homebrew
	if opts.SkipBrew {
		if len(cfg.Homebrew.Taps)+len(cfg.Homebrew.Packages)+len(cfg.Homebrew.Casks) > 0 {
			ops.PrintTask(name, "Install homebrew packages")
			ops.PrintResult(ops.ResultSkipped, "")
			fmt.Println()
		}
	} else {
		if len(cfg.Homebrew.Taps) > 0 {
			ops.PrintTask(name, "Add homebrew taps")
			for _, tap := range cfg.Homebrew.Taps {
				r, err := ops.BrewAddTap(tap)
				if err != nil {
					return ops.PrintTaskError(fmt.Errorf("[%s] brew tap %s: %w", name, tap, err))
				}
				ops.PrintResult(r, tap)
			}
			fmt.Println()
		}

		if len(cfg.Homebrew.Packages) > 0 {
			ops.PrintTask(name, "Install homebrew packages")
			for _, pkg := range cfg.Homebrew.Packages {
				r, err := ops.BrewInstallPkg(pkg)
				if err != nil {
					return ops.PrintTaskError(fmt.Errorf("[%s] brew install %s: %w", name, pkg, err))
				}
				ops.PrintResult(r, pkg)
			}
			fmt.Println()
		}

		if len(cfg.Homebrew.Casks) > 0 {
			ops.PrintTask(name, "Install homebrew cask apps")
			if opts.SkipCasks {
				ops.PrintResult(ops.ResultSkipped, "")
			} else {
				for _, cask := range cfg.Homebrew.Casks {
					r, err := ops.BrewInstallCaskApp(cask)
					if err != nil {
						return ops.PrintTaskError(fmt.Errorf("[%s] brew install --cask %s: %w", name, cask, err))
					}
					ops.PrintResult(r, cask)
				}
			}
			fmt.Println()
		}
	}

	// Directories
	if len(cfg.Directories) > 0 {
		ops.PrintTask(name, "Ensure directories exist")
		for _, d := range cfg.Directories {
			r, err := ops.EnsureDirectory(d)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] mkdir %s: %w", name, d, err))
			}
			ops.PrintResult(r, d)
		}
		fmt.Println()
	}

	// Symlinks
	if len(cfg.Symlinks) > 0 {
		ops.PrintTask(name, "Link configs")
		for _, s := range cfg.Symlinks {
			r, err := ops.Symlink(s.Src, s.Dst)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] symlink %s -> %s: %w", name, s.Dst, s.Src, err))
			}
			ops.PrintResult(r, fmt.Sprintf("{src: %s, dest: %s}", s.Src, s.Dst))
		}
		fmt.Println()
	}

	// Shell sources
	if len(cfg.ShellSources) > 0 {
		ops.PrintTask(name, "Ensure shell sources")
		for _, line := range cfg.ShellSources {
			r, err := ops.LineInFile("~/.zshrc", line)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] lineinfile ~/.zshrc %q: %w", name, line, err))
			}
			ops.PrintResult(r, line)
		}
		fmt.Println()
	}

	// Python venv
	if v := cfg.PythonVenv; v != nil {
		ops.PrintTask(name, "Create python venv")
		r, err := ops.PythonCreateVenv(v.Root, v.Executable)
		if err != nil {
			return ops.PrintTaskError(fmt.Errorf("[%s] python venv %s: %w", name, v.Root, err))
		}
		ops.PrintResult(r, v.Root)
		fmt.Println()

		if len(v.Packages) > 0 {
			ops.PrintTask(name, "Install pip packages")
			r, err := ops.PipInstall(v.Root, v.Packages)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] pip install: %w", name, err))
			}
			ops.PrintResult(r, "")
			fmt.Println()
		}
	}

	// npm
	if n := cfg.Npm; n != nil && len(n.GlobalPackages) > 0 {
		ops.PrintTask(name, "Install npm global packages")
		installed := ops.NpmGlobalInstalled()
		for _, pkg := range n.GlobalPackages {
			r, err := ops.NpmInstallGlobalPkg(installed, pkg)
			if err != nil {
				return ops.PrintTaskError(fmt.Errorf("[%s] npm install -g %s: %w", name, pkg, err))
			}
			ops.PrintResult(r, pkg)
		}
		fmt.Println()
	}

	return nil
}

// manifest is the schema of setup/main.yml.
type manifest struct {
	Groups []string `yaml:"groups"`
}

// All returns all groups in the order defined by setup/main.yml.
func All(setupDir string) ([]Group, error) {
	data, err := os.ReadFile(filepath.Join(setupDir, "main.yml"))
	if err != nil {
		return nil, fmt.Errorf("read groups manifest: %w", err)
	}
	var m manifest
	if err := yaml.Unmarshal(data, &m); err != nil {
		return nil, fmt.Errorf("parse groups manifest: %w", err)
	}
	result := make([]Group, 0, len(m.Groups))
	for _, name := range m.Groups {
		g, err := Load(setupDir, name)
		if err != nil {
			return nil, err
		}
		result = append(result, g)
	}
	return result, nil
}

// Load reads and parses the YAML config for a single group from setupDir.
func Load(setupDir, name string) (Group, error) {
	path := filepath.Join(setupDir, name+".yml")
	data, err := os.ReadFile(path)
	if err != nil {
		return Group{}, fmt.Errorf("read group config %s: %w", path, err)
	}
	var cfg config.GroupConfig
	if err := yaml.Unmarshal(data, &cfg); err != nil {
		return Group{}, fmt.Errorf("parse group config %s: %w", path, err)
	}
	return Group{name: name, cfg: cfg}, nil
}

// ByName loads a group by name, returning an error if the config file is missing.
func ByName(setupDir, name string) (Group, error) {
	g, err := Load(setupDir, name)
	if err != nil {
		return Group{}, fmt.Errorf("unknown group %q: %w", name, err)
	}
	return g, nil
}
