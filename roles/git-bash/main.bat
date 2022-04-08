@echo off

:Main
setlocal
    set WORKDIR=%~dp0
    cd /d %WORKDIR%

    set COPY_FROM=%WORKDIR%\.bash_profile
    set COPY_TO="%USERPROFILE%"

    copy %COPY_FROM% %COPY_TO%

    exit /b
endlocal
