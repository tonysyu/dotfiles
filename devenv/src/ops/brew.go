package ops

import (
	"fmt"
	"os/exec"
	"strings"
)

// BrewInstall installs Homebrew packages. Already-installed packages are skipped.
func BrewInstall(packages []string) error {
	for _, pkg := range packages {
		if err := brewRun("install", pkg); err != nil {
			return fmt.Errorf("brew install %s: %w", pkg, err)
		}
	}
	return nil
}

// BrewInstallCask installs Homebrew cask applications. Already-installed casks are skipped.
func BrewInstallCask(casks []string) error {
	for _, cask := range casks {
		if err := brewRun("install", "--cask", cask); err != nil {
			return fmt.Errorf("brew install --cask %s: %w", cask, err)
		}
	}
	return nil
}

// BrewTap adds a Homebrew tap. Already-added taps are no-ops.
func BrewTap(taps []string) error {
	for _, tap := range taps {
		if err := brewRun("tap", tap); err != nil {
			return fmt.Errorf("brew tap %s: %w", tap, err)
		}
	}
	return nil
}

func brewRun(args ...string) error {
	cmd := exec.Command("brew", args...)
	out, err := cmd.CombinedOutput()
	if err != nil {
		// brew returns non-zero for already-installed if using older versions;
		// newer brew is idempotent, but guard against output containing "already installed"
		if strings.Contains(string(out), "already installed") {
			return nil
		}
		return fmt.Errorf("%s\n%s", err, out)
	}
	return nil
}
