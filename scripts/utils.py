import os
from pathlib import Path


def get_tofu_dir() -> str:
    """Returns the path to the tofu configuration."""
    root_dir = Path(os.getcwd()).absolute()
    tofu_dir = root_dir / 'tofu'
    return tofu_dir.as_posix()