#!/usr/bin/env python3
import subprocess
from logging import Logger

import log
from jinja2 import Template

DEFAULT_LOGGER: Logger = log.create_default_logger()


def main():
    logger = DEFAULT_LOGGER

    result=subprocess.check_output('powershell -Command "[Guid]::NewGuid()"')
    guid_gitbash=result.decode().splitlines()[3]
    logger.debug(f"guid_gitbash = {guid_gitbash}")

    with open('settings.jsonc.j2') as j2_file:
        j2_content = j2_file.read()
        logger.debug(j2_content)

        template = Template(j2_content)
        rendered = template.render(guid_gitbash=guid_gitbash)
        logger.debug(rendered)

        with open('settings.json', 'w') as output:
            output.write(rendered)

    pass

if __name__ == "__main__":
    main()
