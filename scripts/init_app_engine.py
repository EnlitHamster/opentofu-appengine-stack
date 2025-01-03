import subprocess
import utils


def run(config: utils.ProjFig = utils.ProjFig()) -> None:
    command = f"gcloud app create --region {config.app_engine_region}"
    subprocess.run(command, shell=True, check=True)
    

if __name__ == '__main__':
    run()
