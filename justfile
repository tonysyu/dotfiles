# List available commands
default:
    @echo 'Usage: just [OPTIONS] [ARGUMENTS]...'
    @just -l

[working-directory: 'devenv/src']
setup:
    go run ./main.go apply
