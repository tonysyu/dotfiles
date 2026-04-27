package ops

import (
	"fmt"
	"os"
)

// EnsureDirectory creates path (and any parents) if it does not exist.
// Returns OK if already present, Changed if it was created.
func EnsureDirectory(path string) (Result, error) {
	path = expandHome(path)
	if _, err := os.Stat(path); err == nil {
		return ResultOK, nil
	}
	if err := os.MkdirAll(path, 0o755); err != nil {
		return ResultChanged, fmt.Errorf("mkdir %s: %w", path, err)
	}
	return ResultChanged, nil
}
