from logging import INFO, Formatter, Logger, StreamHandler, getLogger


def create_default_logger() -> Logger:
    LOG_LEVEL = INFO
    LOG_FORMAT = "[%(asctime)s] [%(levelname)s] (%(filename)s:%(lineno)d) %(message)s"

    handler = StreamHandler()
    handler.setLevel(LOG_LEVEL)
    handler.setFormatter(Formatter(LOG_FORMAT))

    logger = getLogger(__name__)
    logger.setLevel(LOG_LEVEL)
    logger.addHandler(handler)

    return logger
