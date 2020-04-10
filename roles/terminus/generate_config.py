#!/usr/bin/env python3
import os
from logging import Logger

from jinja2 import Template

import log

DEFAULT_LOGGER: Logger = log.create_default_logger()


def main():
    logger = DEFAULT_LOGGER

    with open('config.yaml.j2') as j2_file:
        userprofile = os.environ['USERPROFILE']
        logger.debug(f"userprofile = {userprofile}")

        j2_content = j2_file.read()
        logger.debug(j2_content)

        template = Template(j2_content)
        rendered = template.render(userprofile=userprofile)
        logger.debug(rendered)

        with open('config.yaml', 'w') as output:
            output.write(rendered)


if __name__ == "__main__":
    main()
