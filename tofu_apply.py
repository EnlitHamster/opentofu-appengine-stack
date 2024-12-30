import subprocess


command = (
    'docker run'
    ' --workdir=/srv/workspace'
    ' --mount type=bind,source=.,target=/srv/workspace'
    ' ghcr.io/opentofu/opentofu:latest'
    ' apply "/srv/workspace/main.plan"'
)

subprocess.run(command, shell=True, check=True)
