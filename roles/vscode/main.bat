@echo off

:Main
setlocal
    set WORKDIR=%~dp0
    cd /d %WORKDIR%

    python -m poetry install
    python -m poetry run python install_extensions.py vscode_extensions.yml
    python -m poetry run python change_user_settings.py vscode_extensions.yml

    exit /b
endlocal
