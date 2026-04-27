package ops

import (
	"fmt"
	"os/exec"
	"strings"
)

// NpmGlobalInstalled returns the set of globally installed npm package names.
func NpmGlobalInstalled() map[string]bool {
	out, err := exec.Command("npm", "list", "-g", "--depth=0", "--parseable").Output()
	if err != nil {
		return map[string]bool{}
	}
	result := map[string]bool{}
	for _, line := range strings.Split(string(out), "\n") {
		parts := strings.Split(strings.TrimSpace(line), "/")
		if len(parts) > 0 {
			name := strings.SplitN(parts[len(parts)-1], "@", 2)[0]
			if name != "" {
				result[name] = true
			}
		}
	}
	return result
}

// NpmInstallGlobalPkg installs a single npm package globally.
// installed is the pre-fetched set from NpmGlobalInstalled.
// Returns OK if already installed, Changed if installed now.
func NpmInstallGlobalPkg(installed map[string]bool, pkg string) (Result, error) {
	name := strings.SplitN(pkg, "@", 2)[0]
	if installed[name] {
		return ResultOK, nil
	}
	cmd := exec.Command("npm", "install", "-g", pkg)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("npm install -g %s: %s\n%s", pkg, err, out)
	}
	return ResultChanged, nil
}
