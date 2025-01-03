import os
import subprocess
import tempfile
import utils


def run(config: utils.ProjFig = utils.ProjFig()) -> None:
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as pwdf:
        pwdf_name = pwdf.name
        pwdf.write(config.get_password(32))
    
    commands = (
        'gcloud secrets create database_user_password --replication-policy="automatic"',
        f'gcloud secrets versions add database_user_password --data-file="{pwdf_name}"',
        f'gcloud secrets add-iam-policy-binding database_user_password --member="serviceAccount:{config.full_service_account_name}" --role="roles/secretmanager.secretAccessor"'
    )

    for command in commands:
        subprocess.run(command, shell=True, check=True)

    os.remove(pwdf_name)

if __name__ == '__main__':
    run()