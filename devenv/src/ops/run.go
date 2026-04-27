package ops

import "fmt"

// RunItems calls fn for each item, printing task progress. No-ops if items is empty.
func RunItems[T any](name, desc string, items []T, fn func(T) (Result, error), label func(T) string) error {
	if len(items) == 0 {
		return nil
	}
	PrintTask(name, desc)
	for _, item := range items {
		r, err := fn(item)
		if err != nil {
			return PrintTaskError(err)
		}
		PrintResult(r, label(item))
	}
	fmt.Println()
	return nil
}

// RunOne calls fn once, printing task progress.
func RunOne(name, desc string, fn func() (Result, error), label string) error {
	PrintTask(name, desc)
	r, err := fn()
	if err != nil {
		return PrintTaskError(err)
	}
	PrintResult(r, label)
	fmt.Println()
	return nil
}
