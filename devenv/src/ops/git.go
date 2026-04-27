package ops

import (
	"fmt"
	"os/exec"
)

// GitUpdateSubmodules runs `git submodule update --init --recursive` in repoPath.
func GitUpdateSubmodules(repoPath string) error {
	repoPath = expandHome(repoPath)
	cmd := exec.Command("git", "-C", repoPath, "submodule", "update", "--init", "--recursive")
	out, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("git submodule update in %s: %s\n%s", repoPath, err, out)
	}
	return nil
}
