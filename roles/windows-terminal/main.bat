@echo off

:Main
setlocal
    set WORKDIR=%~dp0
    cd /d %WORKDIR%

    REM generate config from jinja2 template
    python -m poetry install
    python -m poetry run python generate.py

    set COPY_FROM=%WORKDIR%\settings.json
    set COPY_TO="%HOMEDRIVE%%HOMEPATH%\scoop\apps\windows-terminal\current\settings"

    mkdir %COPY_TO%
    copy %COPY_FROM% %COPY_TO%

    exit /b
endlocal
