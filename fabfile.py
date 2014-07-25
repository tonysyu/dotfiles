from fabric.api import task, local


@task
def update_vim():
    # `|| :` skips on error instead of terminating
    cmd = "git submodule foreach 'git pull origin master || :'"
    local(cmd)
