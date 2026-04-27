package ops

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// LineInFile ensures that line appears in filePath.
// If the file does not exist, it is created. The line is appended only if not
// already present (exact string match on trimmed lines).
func LineInFile(filePath, line string) error {
	filePath = expandHome(filePath)

	// Read existing content if file exists.
	existing := []string{}
	if f, err := os.Open(filePath); err == nil {
		scanner := bufio.NewScanner(f)
		for scanner.Scan() {
			existing = append(existing, scanner.Text())
		}
		f.Close()
		if scanner.Err() != nil {
			return fmt.Errorf("read %s: %w", filePath, scanner.Err())
		}
	}

	// Check if the line is already present.
	for _, l := range existing {
		if strings.TrimSpace(l) == strings.TrimSpace(line) {
			return nil
		}
	}

	// Append the line.
	f, err := os.OpenFile(filePath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0o644)
	if err != nil {
		return fmt.Errorf("open %s: %w", filePath, err)
	}
	defer f.Close()

	if _, err := fmt.Fprintln(f, line); err != nil {
		return fmt.Errorf("write %s: %w", filePath, err)
	}
	return nil
}
