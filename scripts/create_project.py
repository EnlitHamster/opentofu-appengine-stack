import yaml
import subprocess


with open('../config.yml') as config_file:
    config = yaml.safe_load(config_file.read())

project_name = config['project_name']
project_id = config['project_id']
location_id = config['location_id']
service_account_name = config['service_account_name']
service_account_key_file = config['service_account_key_file']

full_service_account_name = f'{service_account_name}@{project_id}.iam.gserviceaccount.com'

commands = f'''gcloud projects create {project_id} --name "{project_name}"
gcloud config set project {project_id}
gcloud services enable cloudresourcemanager.googleapis.com
gcloud iam service-accounts create {service_account_name}
gcloud iam service-accounts keys create {service_account_key_file} --iam-account="{full_service_account_name}"'''

for command in commands.splitlines():
    subprocess.run(command, shell=True, check=True)
