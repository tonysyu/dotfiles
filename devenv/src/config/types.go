package config

// GroupConfig is the schema for each devenv/setup/*.yml file.
type GroupConfig struct {
	Homebrew     HomebrewConfig  `yaml:"homebrew"`
	Directories  []string        `yaml:"directories"`
	Symlinks     []SymlinkSpec   `yaml:"symlinks"`
	ShellSources []string        `yaml:"shell_sources"`
	PythonVenv   *PythonVenv     `yaml:"python_venv,omitempty"`
	Npm          *NpmConfig      `yaml:"npm,omitempty"`
	GitSubmodules []string       `yaml:"git_submodules"`
}

type HomebrewConfig struct {
	Taps     []string `yaml:"taps"`
	Packages []string `yaml:"packages"`
	Casks    []string `yaml:"casks"`
}

type SymlinkSpec struct {
	Src string `yaml:"src"`
	Dst string `yaml:"dst"`
}

type PythonVenv struct {
	Root       string   `yaml:"root"`
	Executable string   `yaml:"executable"`
	Packages   []string `yaml:"packages"`
}

type NpmConfig struct {
	GlobalPackages []string `yaml:"global_packages"`
}
