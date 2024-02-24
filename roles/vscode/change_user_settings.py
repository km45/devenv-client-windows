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
        "vscode",
        "current",
        "data",
        "user-data",
        "User",
        "settings.json",
    )

    try:
        with open(output_path, mode="w") as f:
            logger.info(f"Open user settings.json: {output_path}")

            content = json.dumps(
                {
                    "editor.guides.bracketPairs": True,
                    "editor.stickyScroll.enabled": True,
                    "editor.tabSize": 8,
                    "files.eol": "\n",
                    "markdownlint.config": {
                        "MD007": {
                            "indent": 4
                        },
                        "MD024": {
                            "allow_different_nesting": True
                        },
                    },
                    "terminal.integrated.allowChords": False,
                    "terminal.integrated.defaultProfile.windows": "Git Bash",
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
