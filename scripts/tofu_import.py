import os
import subprocess
import sys
import utils


def run(res_name: str, res_id: str, config: utils.Config = utils.Config()) -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source={config.tofu_dir},target=/srv/workspace'
        f' --mount type=bind,source={config.config_file},target=/srv/config/config.yml'
        f' --mount type=bind,source={config.secrets_file},target=/srv/config/secrets.yml'
        f' --mount type=bind,source={config.token_file},target=/srv/config/{config.token_filename}'
        ' --rm'
        ' ghcr.io/opentofu/opentofu:latest'
        f' import {res_name} {res_id}'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("You need to provide both RES_NAME and RES_ID, in this order.", file=sys.stderr)
    
    res_name = sys.argv[1]
    res_id = sys.argv[2]

    run(res_name, res_id)
