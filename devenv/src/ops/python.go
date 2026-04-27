package ops

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

// PythonCreateVenv creates a virtual environment at root using the given Python
// executable. If root already exists, the operation is skipped.
func PythonCreateVenv(root, executable string) error {
	root = expandHome(root)
	if _, err := os.Stat(root); err == nil {
		// venv already exists
		return nil
	}

	if err := os.MkdirAll(filepath.Dir(root), 0o755); err != nil {
		return fmt.Errorf("mkdir parent of venv %s: %w", root, err)
	}

	cmd := exec.Command(executable, "-m", "venv", root)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("create venv %s: %s\n%s", root, err, out)
	}
	return nil
}

// PipInstall installs packages into the venv located at venvRoot.
func PipInstall(venvRoot string, packages []string) error {
	venvRoot = expandHome(venvRoot)
	pip := filepath.Join(venvRoot, "bin", "pip")

	args := append([]string{"install"}, packages...)
	cmd := exec.Command(pip, args...)
	out, err := cmd.CombinedOutput()
	if err != nil {
		return fmt.Errorf("pip install in %s: %s\n%s", venvRoot, err, out)
	}
	return nil
}
