import json
import os


def get_first_existing_path(paths):
    for path in paths:
        if __salt__["file.file_exists"](path):
            return path
    return None

def get_first_existing_cmd(paths):
    for path in paths:
        if __salt__["cmd.has_exec"](path.split(' ')[0]):
            return path
    return None
