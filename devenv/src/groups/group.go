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

func (g Group) Name() string            { return g.name }
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

	for _, repo := range cfg.GitSubmodules {
		if err := ops.GitUpdateSubmodules(repo); err != nil {
			return err
		}
	}

	if !opts.SkipBrew {
		if err := ops.BrewTap(cfg.Homebrew.Taps); err != nil {
			return err
		}
		if err := ops.BrewInstall(cfg.Homebrew.Packages); err != nil {
			return err
		}
		if !opts.SkipCasks {
			if err := ops.BrewInstallCask(cfg.Homebrew.Casks); err != nil {
				return err
			}
		}
	}

	if err := ops.EnsureDirectories(cfg.Directories); err != nil {
		return err
	}

	for _, s := range cfg.Symlinks {
		if err := ops.Symlink(s.Src, s.Dst); err != nil {
			return err
		}
	}

	for _, line := range cfg.ShellSources {
		if err := ops.LineInFile("~/.zshrc", line); err != nil {
			return err
		}
	}

	if v := cfg.PythonVenv; v != nil {
		if err := ops.PythonCreateVenv(v.Root, v.Executable); err != nil {
			return err
		}
		if err := ops.PipInstall(v.Root, v.Packages); err != nil {
			return err
		}
	}

	if n := cfg.Npm; n != nil {
		if err := ops.NpmInstallGlobal(n.GlobalPackages); err != nil {
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
