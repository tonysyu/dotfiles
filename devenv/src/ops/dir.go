package ops

import (
	"fmt"
	"os"
)

// EnsureDirectories creates each path (and any parents) if it does not exist.
// Tilde in paths is expanded.
func EnsureDirectories(paths []string) error {
	for _, p := range paths {
		p = expandHome(p)
		if err := os.MkdirAll(p, 0o755); err != nil {
			return fmt.Errorf("mkdir %s: %w", p, err)
		}
	}
	return nil
}
