from pathlib import Path

import yaml
import string
import secrets


def _get_root_dir() -> Path:
    root_dir = Path(__file__).parent.parent.absolute()
    return root_dir


# Tofu configuration
class TofuFig:
    _root_dir: Path

    def __init__(self) -> None:
        self._root_dir = _get_root_dir()

    @property
    def tofu_dir(self) -> str:
        return self.get_mount_path(self._root_dir / 'tofu')
    
    @property
    def config_file(self) -> str:
        return self.get_mount_path(self._root_dir / 'config.yml')
    
    @property
    def token_filename(self) -> str:
        with open(self._root_dir / 'config.yml') as config_file:
            cfg_data = yaml.safe_load(config_file.read())

        return cfg_data['service_account_key_filename']
    
    @property
    def token_file(self) -> str:
        return self.get_mount_path(self._root_dir / self.token_filename)
    
    @staticmethod
    def get_mount_path(path: Path) -> str:
        return f'"{str(path)}"'


# Project creation and management configuration
class ProjFig:
    def __init__(self) -> None:
        with open(_get_root_dir() / 'config.yml') as config_file:
            config = yaml.safe_load(config_file.read())

        self.project_name = config['project_name']
        self.project_id = config['project_id']
        self.location_id = config['location_id']
        self.service_account_name = config['service_account_name']
        self.service_account_key_file = config['service_account_key_filename']
        self.app_engine_region = config['app_engine_location_id']

    @property
    def full_service_account_name(self) -> str:
        return self.get_full_service_account_name(self.service_account_name)

    def get_full_service_account_name(self, name: str) -> str:
        return f'{name}@{self.project_id}.iam.gserviceaccount.com'
    
    @staticmethod
    def get_password(length: int) -> str:
        """Based on: https://stackoverflow.com/a/63160092"""
        specials = string.punctuation
        alphabet = string.ascii_letters + string.digits + specials
        while True:
            password = ''.join(secrets.choice(alphabet) for i in range(length))
            if (sum(c.islower() for c in password) >=4
                    and sum(c.isupper() for c in password) >=4
                    and sum(c.isdigit() for c in password) >=4
                    and sum(c in specials for c in password) >= 4):
                break
        
        return password
        

if __name__ == '__main__':
    print(str(_get_root_dir()))
