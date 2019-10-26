@echo off

:Main
setlocal
    python -m pip install --upgrade pip
    python -m pip install pipenv

    exit /b
endlocal
