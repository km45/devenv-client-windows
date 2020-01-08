@echo off

:Main
setlocal
    python -m pip install --upgrade pip
    python -m pip install poetry

    exit /b
endlocal
