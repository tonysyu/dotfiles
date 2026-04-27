package ops

import (
	"fmt"
	"os/exec"
	"strings"
)

// NpmInstallGlobal installs npm packages globally.
// Already-installed packages are skipped by checking `npm list -g`.
func NpmInstallGlobal(packages []string) error {
	installed, err := installedNpmGlobalPackages()
	if err != nil {
		// If we can't list, attempt installs anyway.
		installed = map[string]bool{}
	}

	for _, pkg := range packages {
		// Strip version specifier for the existence check.
		name := strings.SplitN(pkg, "@", 2)[0]
		if installed[name] {
			continue
		}
		cmd := exec.Command("npm", "install", "-g", pkg)
		out, err := cmd.CombinedOutput()
		if err != nil {
			return fmt.Errorf("npm install -g %s: %s\n%s", pkg, err, out)
		}
	}
	return nil
}

func installedNpmGlobalPackages() (map[string]bool, error) {
	out, err := exec.Command("npm", "list", "-g", "--depth=0", "--parseable").Output()
	if err != nil {
		return nil, err
	}
	result := map[string]bool{}
	for _, line := range strings.Split(string(out), "\n") {
		parts := strings.Split(strings.TrimSpace(line), "/")
		if len(parts) > 0 {
			name := parts[len(parts)-1]
			// Strip version suffix (e.g. "prettier@3.2.5" → "prettier")
			name = strings.SplitN(name, "@", 2)[0]
			if name != "" {
				result[name] = true
			}
		}
	}
	return result, nil
}
