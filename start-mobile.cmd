@echo off
rem Starts the Karachi Mart mobile app (Expo).
rem Make sure the backend is already running (start-backend.cmd).
setlocal
set "NODE_DIR=%USERPROFILE%\.local\apps\nodejs\node-v26.13.0-win-x64"
if exist "%NODE_DIR%\node.exe" ( set "PATH=%NODE_DIR%;%PATH%" )

cd /d "%~dp0mobile"
if not exist node_modules (
  echo Installing mobile dependencies...
  call npm.cmd install --no-audit --no-fund
)
echo Starting Expo...
echo   Press 'a' for Android emulator, 'i' for iOS, 'w' for web.
call npx.cmd expo start
endlocal
