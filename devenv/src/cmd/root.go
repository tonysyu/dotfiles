package cmd

import (
	"devenv/config"
	"devenv/groups"
	"fmt"
	"os"
	"path/filepath"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "devenv",
	Short: "Configure the development environment from YAML setup files",
}

func Execute() error {
	return rootCmd.Execute()
}

func init() {
	rootCmd.AddCommand(applyCmd())
	rootCmd.AddCommand(checkCmd())
}

func applyCmd() *cobra.Command {
	var skipBrew, skipCasks bool

	cmd := &cobra.Command{
		Use:   "apply [group...]",
		Short: "Apply one or more setup groups (default: all groups in order)",
		RunE: func(cmd *cobra.Command, args []string) error {
			setupDir, err := resolveSetupDir()
			if err != nil {
				return err
			}
			opts := groups.Options{
				SkipBrew:  skipBrew,
				SkipCasks: skipCasks,
			}
			return runGroups(setupDir, args, opts)
		},
	}
	cmd.Flags().BoolVar(&skipBrew, "skip-brew", false, "Skip all Homebrew package installations")
	cmd.Flags().BoolVar(&skipCasks, "skip-casks", false, "Skip Homebrew cask installations")
	return cmd
}

func checkCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "check [group...]",
		Short: "Dry-run: print what apply would do without making changes",
		RunE: func(cmd *cobra.Command, args []string) error {
			setupDir, err := resolveSetupDir()
			if err != nil {
				return err
			}
			opts := groups.Options{DryRun: true}
			return checkGroups(setupDir, args, opts)
		},
	}
}

// resolveSetupDir locates devenv/setup/ relative to the binary.
// When running via `go run`, it falls back to a cwd-relative path.
func resolveSetupDir() (string, error) {
	exe, err := os.Executable()
	if err != nil {
		return "", fmt.Errorf("resolve executable: %w", err)
	}
	candidate := filepath.Join(filepath.Dir(exe), "..", "setup")
	if fi, err := os.Stat(candidate); err == nil && fi.IsDir() {
		abs, _ := filepath.Abs(candidate)
		return abs, nil
	}
	wd, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("getwd: %w", err)
	}
	candidate = filepath.Join(wd, "..", "setup")
	if fi, err := os.Stat(candidate); err == nil && fi.IsDir() {
		abs, _ := filepath.Abs(candidate)
		return abs, nil
	}
	return "", fmt.Errorf("cannot locate setup/ directory (tried relative to binary and cwd)")
}

func runGroups(setupDir string, names []string, opts groups.Options) error {
	selected, err := selectGroups(setupDir, names)
	if err != nil {
		return err
	}
	for _, g := range selected {
		fmt.Printf("==> applying group: %s\n", g.Name())
		if err := g.Apply(opts); err != nil {
			return fmt.Errorf("[%s] %w", g.Name(), err)
		}
		fmt.Printf("    done: %s\n", g.Name())
	}
	return nil
}

func checkGroups(setupDir string, names []string, opts groups.Options) error {
	selected, err := selectGroups(setupDir, names)
	if err != nil {
		return err
	}
	for _, g := range selected {
		printPlan(g.Name(), g.Config(), opts)
	}
	return nil
}

func selectGroups(setupDir string, names []string) ([]groups.Group, error) {
	if len(names) == 0 {
		return groups.All(setupDir)
	}
	var selected []groups.Group
	for _, name := range names {
		g, err := groups.ByName(setupDir, name)
		if err != nil {
			return nil, err
		}
		selected = append(selected, g)
	}
	return selected, nil
}

func printPlan(name string, cfg config.GroupConfig, opts groups.Options) {
	fmt.Printf("\n==> group: %s\n", name)
	for _, repo := range cfg.GitSubmodules {
		fmt.Printf("    git submodule update: %s\n", repo)
	}
	if !opts.SkipBrew {
		if len(cfg.Homebrew.Taps) > 0 {
			fmt.Printf("    brew tap: %v\n", cfg.Homebrew.Taps)
		}
		if len(cfg.Homebrew.Packages) > 0 {
			fmt.Printf("    brew install: %v\n", cfg.Homebrew.Packages)
		}
		if !opts.SkipCasks && len(cfg.Homebrew.Casks) > 0 {
			fmt.Printf("    brew install --cask: %v\n", cfg.Homebrew.Casks)
		}
	}
	for _, d := range cfg.Directories {
		fmt.Printf("    mkdir -p: %s\n", d)
	}
	for _, s := range cfg.Symlinks {
		fmt.Printf("    symlink: %s -> %s\n", s.Dst, s.Src)
	}
	for _, line := range cfg.ShellSources {
		fmt.Printf("    lineinfile ~/.zshrc: %q\n", line)
	}
	if v := cfg.PythonVenv; v != nil {
		fmt.Printf("    python venv: %s (via %s)\n", v.Root, v.Executable)
		fmt.Printf("    pip install: %v\n", v.Packages)
	}
	if n := cfg.Npm; n != nil {
		fmt.Printf("    npm install -g: %v\n", n.GlobalPackages)
	}
}
