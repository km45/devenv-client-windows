#!/usr/bin/env python3
import os
import subprocess
from logging import Logger

import yaml

import log

DEFAULT_LOGGER: Logger = log.create_default_logger()


def is_installed(extension: str, *, logger: Logger = DEFAULT_LOGGER) -> bool:
    command = ["code", "--list-extensions"]
    logger.debug(f"Execute command: {command}")

    external_process = subprocess.run(command, stdout=subprocess.PIPE, shell=True)
    external_process.check_returncode()

    installed_extensions = external_process.stdout.decode().rstrip("\n")
    logger.debug(f"Extensions already installed:\n{installed_extensions}")

    return extension in installed_extensions


def install(extension: str, *, logger: Logger = DEFAULT_LOGGER):
    command = ["code", "--install-extension", extension]
    logger.debug(f"Execute command: {command}")

    external_process = subprocess.run(command, shell=True)
    external_process.check_returncode()


def main():
    logger = DEFAULT_LOGGER
    extension_list_file = os.sys.argv[1]
    with open(extension_list_file) as f:
        data = yaml.safe_load(f)
        KEY = "vscode_plugins"
        logger.debug("Extensions to install:\n{}".format("\n".join(data[KEY])))

        for extension in data[KEY]:
            if is_installed(extension):
                logger.info(f"Already installed {extension}")
                continue

            logger.info(f"Install {extension}")
            install(extension)


if __name__ == "__main__":
    main()
