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

func (g Group) Name() string               { return g.name }
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
	id := func(s string) string { return s }

	// Git submodules
	if err := ops.RunItems(name, "Update git submodules", cfg.GitSubmodules, ops.GitUpdateSubmodules, id); err != nil {
		return err
	}

	// Homebrew
	if opts.SkipBrew {
		if len(cfg.Homebrew.Taps)+len(cfg.Homebrew.Packages)+len(cfg.Homebrew.Casks) > 0 {
			ops.PrintTask(name, "Install homebrew packages")
			ops.PrintResult(ops.ResultSkipped, "")
			fmt.Println()
		}
	} else {
		if err := ops.RunItems(name, "Add homebrew taps", cfg.Homebrew.Taps, ops.BrewAddTap, id); err != nil {
			return err
		}
		if err := ops.RunItems(name, "Install homebrew packages", cfg.Homebrew.Packages, ops.BrewInstallPkg, id); err != nil {
			return err
		}
		if len(cfg.Homebrew.Casks) > 0 {
			ops.PrintTask(name, "Install homebrew cask apps")
			if opts.SkipCasks {
				ops.PrintResult(ops.ResultSkipped, "")
				fmt.Println()
			} else {
				for _, cask := range cfg.Homebrew.Casks {
					r, err := ops.BrewInstallCaskApp(cask)
					if err != nil {
						return ops.PrintTaskError(fmt.Errorf("[%s] brew install --cask %s: %w", name, cask, err))
					}
					ops.PrintResult(r, cask)
				}
				fmt.Println()
			}
		}
	}

	// Directories
	if err := ops.RunItems(name, "Ensure directories exist", cfg.Directories, ops.EnsureDirectory, id); err != nil {
		return err
	}

	// Symlinks
	if err := ops.RunItems(name, "Link configs", cfg.Symlinks,
		func(s config.SymlinkSpec) (ops.Result, error) { return ops.Symlink(s.Src, s.Dst) },
		func(s config.SymlinkSpec) string { return fmt.Sprintf("{src: %s, dest: %s}", s.Src, s.Dst) },
	); err != nil {
		return err
	}

	// Shell sources
	if err := ops.RunItems(name, "Ensure shell sources", cfg.ShellSources,
		func(line string) (ops.Result, error) { return ops.LineInFile("~/.zshrc", line) }, id,
	); err != nil {
		return err
	}

	// Python venv
	if v := cfg.PythonVenv; v != nil {
		if err := ops.RunOne(name, "Create python venv",
			func() (ops.Result, error) { return ops.PythonCreateVenv(v.Root, v.Executable) }, v.Root,
		); err != nil {
			return err
		}
		if len(v.Packages) > 0 {
			if err := ops.RunOne(name, "Install pip packages",
				func() (ops.Result, error) { return ops.PipInstall(v.Root, v.Packages) }, "",
			); err != nil {
				return err
			}
		}
	}

	// npm
	if n := cfg.Npm; n != nil && len(n.GlobalPackages) > 0 {
		installed := ops.NpmGlobalInstalled()
		if err := ops.RunItems(name, "Install npm global packages", n.GlobalPackages,
			func(pkg string) (ops.Result, error) { return ops.NpmInstallGlobalPkg(installed, pkg) }, id,
		); err != nil {
			return err
		}
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
