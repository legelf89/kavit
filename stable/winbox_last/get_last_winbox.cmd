@echo off
cls
setlocal enabledelayedexpansion
for /f "tokens=1,2,3,4,5 delims=/. " %%a in ('date/T') do set CDate=%%a%%d-%%b-%%c
for /f "tokens=1,2 delims=:. " %%a in ('time/T') do set CTime=%%a:%%b
set CurrentDateTime=[%CDate% %CTime%]
rem Получить текущий путь к скрипту
set "script_path=%~dp0"
rem Получить текущую директорию
set "current_directory=%cd%"
::
set ScriptVersion=1.0
set ScriptRevision=1
set ScriptVersionFull=%ScriptVersion%.%ScriptRevision%
set localLog=%current_directory%\update.log
set winbox_url="https://mikrotik.com/download/winbox.exe"
set winbox_last="./winbox.exe"
::


call :logmsg "%ScriptVersionFull%" 0

::
::if exist "curl.exe" (
::    call :logmsg "EXE: curl -o %winbox_last% %winbox_url%" 0
::) else (
::    call :logmsg "Not found CURL" 404
::	call :logmsg "Check paths, see help or try install https://curl.se/download.html" 404
::    exit /b 1
::)
call :logmsg "Try kill winbox" 0
taskkill /f /im winbox.exe

call :logmsg "Try curl last winbox from %winbox_url%" 0
::call :logmsg "EXE: curl -O %winbox_url% -L"  0
curl -O %winbox_url% -L





rem Проверить, содержится ли текущая директория в переменной PATH
echo :logmsg !PATH! | find /i "%current_directory%" > nul

rem Если текущая директория не найдена в PATH, добавить ее
if errorlevel 1 (
    call :logmsg "Add to PATH %current_directory%" 0
    ::setx PATH "%PATH%;%current_directory%" -m
    call :logmsg "Add successful to PATH" 200
) else (
    call :logmsg "Current folder alredy in PATH" 0
)


call :logmsg "Log >> %localLog%" 0
::
:logmsg
echo [%date% %time%][%ScriptVersion%][%2] %1 >> "%localLog%"
echo [%date% %time%][%ScriptVersion%][%2] %1
exit /b
