@echo off

:Main
setlocal
    set WORKDIR=%~dp0
    cd /d %WORKDIR%

    python -m pipenv sync
    python -m pipenv run -- python download.py "https://raw.githubusercontent.com/km45/linux-devenv/master/src/playbooks/roles/vscode/vars/main.yml" vscode_extensions.yml
    python -m pipenv run -- python install_extensions.py vscode_extensions.yml
    python -m pipenv run -- python change_user_settings.py

    exit /b
endlocal
