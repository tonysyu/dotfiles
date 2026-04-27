package ops

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// LineInFile ensures that line appears in filePath.
// If the file does not exist it is created. Returns OK if the line was already
// present, Changed if it was appended.
func LineInFile(filePath, line string) (Result, error) {
	filePath = expandHome(filePath)

	existing := []string{}
	if f, err := os.Open(filePath); err == nil {
		scanner := bufio.NewScanner(f)
		for scanner.Scan() {
			existing = append(existing, scanner.Text())
		}
		f.Close()
		if scanner.Err() != nil {
			return ResultChanged, fmt.Errorf("read %s: %w", filePath, scanner.Err())
		}
	}

	for _, l := range existing {
		if strings.TrimSpace(l) == strings.TrimSpace(line) {
			return ResultOK, nil
		}
	}

	f, err := os.OpenFile(filePath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0o644)
	if err != nil {
		return ResultChanged, fmt.Errorf("open %s: %w", filePath, err)
	}
	defer f.Close()

	if _, err := fmt.Fprintln(f, line); err != nil {
		return ResultChanged, fmt.Errorf("write %s: %w", filePath, err)
	}
	return ResultChanged, nil
}
