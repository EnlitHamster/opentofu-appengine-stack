import subprocess


def run() -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        ' --mount type=bind,source=.,target=/srv/workspace'
        ' ghcr.io/opentofu/opentofu:latest'
        ' init'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
