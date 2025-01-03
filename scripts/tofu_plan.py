import subprocess
import utils



def run(config: utils.TofuFig = utils.TofuFig()) -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source={config.tofu_dir},target=/srv/workspace'
        f' --mount type=bind,source={config.config_file},target=/srv/config/config.yml'
        f' --mount type=bind,source={config.token_file},target=/srv/config/{config.token_filename}'
        ' --rm'
        ' ghcr.io/opentofu/opentofu:latest'
        ' plan -out=main.plan'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
