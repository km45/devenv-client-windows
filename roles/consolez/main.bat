@echo off

:Main
setlocal
    set WORKDIR=%~dp0

    set COPY_FROM=%WORKDIR%\console.xml
    set COPY_TO=%APPDATA%\Console

    mkdir %COPY_TO%
    copy %COPY_FROM% %COPY_TO%

    exit /b
endlocal
