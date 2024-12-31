import subprocess
import utils


def run(config: utils.Config = utils.Config()) -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source={config.tofu_dir},target=/srv/workspace'
        ' ghcr.io/opentofu/opentofu:latest'
        ' init'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
