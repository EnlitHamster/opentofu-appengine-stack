import os
from pathlib import Path

import yaml


def _get_root_dir() -> Path:
    root_dir = Path(os.getcwd()).absolute()
    return root_dir


def _get_mount_path(path: Path) -> str:
    return f'"{str(path)}"'


class Config:
    _root_dir: Path

    def __init__(self) -> None:
        self._root_dir = _get_root_dir()

    @property
    def tofu_dir(self) -> str:
        return _get_mount_path(self._root_dir / 'tofu')
    
    @property
    def config_file(self) -> str:
        return _get_mount_path(self._root_dir / 'config.yml')
    
    @property
    def secrets_file(self) -> str:
        return _get_mount_path(self._root_dir / 'secrets.yml')
    

    @property
    def token_filename(self) -> str:
        with open(self._root_dir / 'config.yml') as config_file:
            cfg_data = yaml.safe_load(config_file.read())

        return cfg_data['service_account_key_filename']
    
    @property
    def token_file(self) -> str:
        return _get_mount_path(self._root_dir / self.token_filename)
