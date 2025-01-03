import subprocess
import utils


def run(config: utils.TofuFig = utils.TofuFig()) -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source={config.tofu_dir},target=/srv/workspace'
        ' --rm'
        ' ghcr.io/opentofu/opentofu:latest'
        ' output'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
