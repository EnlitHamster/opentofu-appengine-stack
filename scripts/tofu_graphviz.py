import subprocess


def run() -> None:
    command = f'dot -Tsvg graph.dot > graph.svg'
    subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()