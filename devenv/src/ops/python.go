package ops

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

// PythonCreateVenv creates a virtual environment at root using uv with the
// given Python version specifier (e.g. "3.13"). Returns OK if a healthy venv
// already exists, Changed if it was created.
func PythonCreateVenv(root, pythonVersion string) (Result, error) {
	root = expandHome(root)
	if _, err := os.Stat(filepath.Join(root, "bin", "pip")); err == nil {
		return ResultOK, nil
	}

	cmd := exec.Command("uv", "venv", "--python", pythonVersion, "--seed", root)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("uv venv %s: %s\n%s", root, err, out)
	}
	return ResultChanged, nil
}

// PipInstall installs packages into the venv at venvRoot using uv.
// Always returns Changed since pip manages its own idempotency.
func PipInstall(venvRoot string, packages []string) (Result, error) {
	venvRoot = expandHome(venvRoot)
	args := append([]string{"pip", "install", "--python", venvRoot}, packages...)
	cmd := exec.Command("uv", args...)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return ResultChanged, fmt.Errorf("uv pip install in %s: %s\n%s", venvRoot, err, out)
	}
	return ResultChanged, nil
}
