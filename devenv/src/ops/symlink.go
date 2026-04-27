package ops

import (
	"fmt"
	"os"
	"path/filepath"
)

// Symlink force-creates a symlink at dst pointing to src.
// Both paths have ~ expanded. Parent directories of dst are created as needed.
func Symlink(src, dst string) error {
	src = expandHome(src)
	dst = expandHome(dst)

	if err := os.MkdirAll(filepath.Dir(dst), 0o755); err != nil {
		return fmt.Errorf("mkdir parent of %s: %w", dst, err)
	}

	// Remove existing file/symlink/dir at dst so we can force-create.
	if _, err := os.Lstat(dst); err == nil {
		if err := os.Remove(dst); err != nil {
			return fmt.Errorf("remove existing %s: %w", dst, err)
		}
	}

	if err := os.Symlink(src, dst); err != nil {
		return fmt.Errorf("symlink %s -> %s: %w", dst, src, err)
	}
	return nil
}
