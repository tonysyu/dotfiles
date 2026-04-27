package ops

// Result describes the outcome of a single operation.
type Result int

const (
	ResultOK      Result = iota // already in desired state, nothing changed
	ResultChanged               // state was modified
	ResultSkipped               // operation was not performed (disabled or empty)
)

func (r Result) String() string {
	switch r {
	case ResultOK:
		return "ok"
	case ResultChanged:
		return "changed"
	case ResultSkipped:
		return "skipping"
	default:
		return "unknown"
	}
}
