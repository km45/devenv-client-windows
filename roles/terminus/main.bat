@echo off

:Main
setlocal
    set WORKDIR=%~dp0
    cd /d %WORKDIR%

    REM generate config from jinja2 template
    python -m poetry install
    python -m poetry run python generate_config.py

    set COPY_FROM=%WORKDIR%\config.yaml
    set COPY_TO=%APPDATA%\terminus

    mkdir %COPY_TO%
    copy %COPY_FROM% %COPY_TO%

    exit /b
endlocal
