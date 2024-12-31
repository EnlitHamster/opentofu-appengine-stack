import subprocess


def run(source: str) -> None:
    command = (
        'docker run'
        ' --workdir=/srv/workspace'
        f' --mount type=bind,source="{source}",target=/srv/workspace'
        ' ghcr.io/opentofu/opentofu:latest'
        ' apply "/srv/workspace/main.plan"'
    )

    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    from utils import get_tofu_dir
    source = get_tofu_dir()

    print(f'Tofu directory: {source}')
    run(source)
