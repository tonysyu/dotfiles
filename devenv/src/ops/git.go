package ops

import (
	"fmt"
	"os/exec"
	"strings"
)

// GitUpdateSubmodules runs `git submodule update --init --recursive` in repoPath.
// Returns Changed if the output indicates any submodules were updated, OK otherwise.
func GitUpdateSubmodules(repoPath string) (Result, error) {
	repoPath = expandHome(repoPath)
	cmd := exec.Command("git", "-C", repoPath, "submodule", "update", "--init", "--recursive")
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("git submodule update in %s: %s\n%s", repoPath, err, out)
	}
	if strings.TrimSpace(string(out)) != "" {
		return ResultChanged, nil
	}
	return ResultOK, nil
}
