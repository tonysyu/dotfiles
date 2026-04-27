package ops

import (
	"fmt"
	"strings"
)

const taskLineWidth = 100

func PrintTask(group, description string) {
	header := fmt.Sprintf("TASK [%s : %s] ", group, description)
	stars := taskLineWidth - len(header)
	if stars > 0 {
		header += strings.Repeat("*", stars)
	}
	fmt.Println(header)
}

func PrintResult(r Result, item string) {
	if item != "" {
		fmt.Printf("%s: %s\n", r, item)
	} else {
		fmt.Printf("%s\n", r)
	}
}

// PrintTaskError prints a fatal result line then returns the error unchanged,
// so callers can write: return ops.PrintTaskError(err)
func PrintTaskError(err error) error {
	fmt.Printf("fatal: FAILED! => %v\n", err)
	return err
}
