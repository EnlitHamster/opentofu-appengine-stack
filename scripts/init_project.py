import subprocess
import utils


def run(config: utils.ProjFig = utils.ProjFig()) -> None:
    commands = (
        f"gcloud projects create {config.project_id} --name {config.project_name}",
        f"gcloud config set project {config.project_id}",
        "gcloud services enable cloudresourcemanager.googleapis.com",
        "gcloud services enable iam.googleapis.com",
    )
    
    for command in commands:
        subprocess.run(command, shell=True, check=True)


if __name__ == '__main__':
    run()
