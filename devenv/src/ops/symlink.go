package ops

import (
	"fmt"
	"os"
	"path/filepath"
)

// Symlink force-creates a symlink at dst pointing to src.
// Returns OK if the symlink already points to src, Changed if it was (re)created.
func Symlink(src, dst string) (Result, error) {
	src = expandHome(src)
	dst = expandHome(dst)

	// Already correct — nothing to do.
	if existing, err := os.Readlink(dst); err == nil && existing == src {
		return ResultOK, nil
	}

	if err := os.MkdirAll(filepath.Dir(dst), 0o755); err != nil {
		return ResultChanged, fmt.Errorf("mkdir parent of %s: %w", dst, err)
	}

	// Remove existing file/symlink/dir so we can force-create.
	if _, err := os.Lstat(dst); err == nil {
		if err := os.Remove(dst); err != nil {
			return ResultChanged, fmt.Errorf("remove existing %s: %w", dst, err)
		}
	}

	if err := os.Symlink(src, dst); err != nil {
		return ResultChanged, fmt.Errorf("symlink %s -> %s: %w", dst, src, err)
	}
	return ResultChanged, nil
}
