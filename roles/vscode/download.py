#!/usr/bin/env python3
from logging import Logger
import os
import requests
import log


DEFAULT_LOGGER: Logger = log.create_default_logger()


def main():
    logger = DEFAULT_LOGGER

    remote_url = os.sys.argv[1]
    local_file = os.sys.argv[2]

    logger.info(f"Download {remote_url}")

    responce = requests.get(remote_url)

    with open(local_file, "wb") as f:
        logger.info(f"Save responce as {local_file}")
        f.write(responce.content)


if __name__ == "__main__":
    main()
