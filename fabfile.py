from fabric.api import task, local


@task
def update_vim():
    """ Update all vim bundles. """
    # `|| :` skips on error instead of terminating
    cmd = "git submodule foreach 'git pull origin master || :'"
    local(cmd)
