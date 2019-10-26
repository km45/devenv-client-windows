@echo off

:Main
setlocal
    set WORKDIR=%~dp0

    REM "Execute the role scoop at first"
    call %WORKDIR%\roles\scoop\main.bat

    REM "Execute the role python at second"
    call %WORKDIR%\roles\python\main.bat

    REM "Execute the other roles."
    call %WORKDIR%\roles\consolez\main.bat
    call %WORKDIR%\roles\vscode\main.bat

    exit /b
endlocal
