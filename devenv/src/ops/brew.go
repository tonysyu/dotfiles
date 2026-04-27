package ops

import (
	"fmt"
	"os/exec"
	"strings"
)

// BrewInstallPkg installs a single Homebrew formula.
// Returns OK if the package is already installed, Changed if it was installed.
func BrewInstallPkg(pkg string) (Result, error) {
	if isBrewFormulaInstalled(pkg) {
		return ResultOK, nil
	}
	if err := brewRun("install", pkg); err != nil {
		return ResultChanged, fmt.Errorf("brew install %s: %w", pkg, err)
	}
	return ResultChanged, nil
}

// BrewInstallCaskApp installs a single Homebrew cask.
// Returns OK if already installed, Changed if it was installed.
func BrewInstallCaskApp(cask string) (Result, error) {
	if isBrewCaskInstalled(cask) {
		return ResultOK, nil
	}
	if err := brewRun("install", "--cask", cask); err != nil {
		return ResultChanged, fmt.Errorf("brew install --cask %s: %w", cask, err)
	}
	return ResultChanged, nil
}

// BrewAddTap adds a single Homebrew tap.
// Returns OK if already tapped, Changed if it was added.
func BrewAddTap(tap string) (Result, error) {
	if isBrewTapped(tap) {
		return ResultOK, nil
	}
	if err := brewRun("tap", tap); err != nil {
		return ResultChanged, fmt.Errorf("brew tap %s: %w", tap, err)
	}
	return ResultChanged, nil
}

func isBrewFormulaInstalled(pkg string) bool {
	return exec.Command("brew", "list", "--formula", pkg).Run() == nil
}

func isBrewCaskInstalled(cask string) bool {
	return exec.Command("brew", "list", "--cask", cask).Run() == nil
}

func isBrewTapped(tap string) bool {
	out, err := exec.Command("brew", "tap").Output()
	if err != nil {
		return false
	}
	for _, line := range strings.Split(string(out), "\n") {
		if strings.TrimSpace(line) == tap {
			return true
		}
	}
	return false
}

func brewRun(args ...string) error {
	cmd := exec.Command("brew", args...)
	out, err := cmd.CombinedOutput()
	if err != nil {
		if strings.Contains(string(out), "already installed") {
			return nil
		}
		return fmt.Errorf("%s\n%s", err, out)
	}
	return nil
}
