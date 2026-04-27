package ops

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

// PythonCreateVenv creates a virtual environment at root using the given Python
// executable. Returns OK if the venv already exists, Changed if it was created.
func PythonCreateVenv(root, executable string) (Result, error) {
	root = expandHome(root)
	if _, err := os.Stat(root); err == nil {
		return ResultOK, nil
	}

	if err := os.MkdirAll(filepath.Dir(root), 0o755); err != nil {
		return ResultChanged, fmt.Errorf("mkdir parent of venv %s: %w", root, err)
	}

	cmd := exec.Command(executable, "-m", "venv", root)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("create venv %s: %s\n%s", root, err, out)
	}
	return ResultChanged, nil
}

// PipInstall installs packages into the venv at venvRoot.
// Always returns Changed since pip manages its own idempotency.
func PipInstall(venvRoot string, packages []string) (Result, error) {
	venvRoot = expandHome(venvRoot)
	pip := filepath.Join(venvRoot, "bin", "pip")

	args := append([]string{"install"}, packages...)
	cmd := exec.Command(pip, args...)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("pip install in %s: %s\n%s", venvRoot, err, out)
	}
	return ResultChanged, nil
}
