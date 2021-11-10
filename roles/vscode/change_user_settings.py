#!/usr/bin/env python3
import json
import os
import sys
from logging import Logger

import log

DEFAULT_LOGGER: Logger = log.create_default_logger()


def main():
    logger = DEFAULT_LOGGER

    homedir = os.path.expanduser("~")
    scoopdir = os.path.join(homedir, "scoop")

    output_path = os.path.join(
        scoopdir,
        "apps",
        "vscode-portable",
        "current",
        "data",
        "user-data",
        "User",
        "settings.json",
    )

    try:
        with open(output_path, mode="w") as f:
            logger.info(f"Open user settings.json: {output_path}")

            shell_path = os.path.join(
                scoopdir, "apps", "git-with-openssh", "current", "bin", "bash.exe"
            )
            shell_args = ["--login", "-i"]

            remote_ssh_config_path = os.path.join(
                homedir, ".ssh", "config.d", "vscode-remote-ssh"
            )

            content = json.dumps(
                {
                    "terminal.integrated.shell.windows": shell_path,
                    "terminal.integrated.shellArgs.windows": shell_args,
                    "remote.SSH.configFile": remote_ssh_config_path,
                },
                ensure_ascii=False,
                indent=4,
                sort_keys=True,
            )
            logger.debug(f"Write following content as user settings.json\n{content}")
            f.write(content)
            logger.info(f"Success to write user settings.json")
    except:
        logger.error(f"Failed to open user settings.json: {output_path}")
        sys.exit(1)


if __name__ == "__main__":
    main()
