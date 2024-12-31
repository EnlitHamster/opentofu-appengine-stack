import subprocess
import utils



def run(config: utils.Config = utils.Config()) -> None:
    print(config.config_file)
    print(config.secrets_file)
    print(config.token_file)

    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source={config.tofu_dir},target=/srv/workspace'
        f' --mount type=bind,source={config.config_file},target=/srv/config/config.yml'
        f' --mount type=bind,source={config.secrets_file},target=/srv/config/secrets.yml'
        f' --mount type=bind,source={config.token_file},target=/srv/config/{config.token_filename}'
        ' ghcr.io/opentofu/opentofu:latest'
        ' plan -out=main.plan'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
