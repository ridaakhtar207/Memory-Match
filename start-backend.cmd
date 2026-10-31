@echo off
rem Starts the Karachi Mart backend (Next.js API) on http://localhost:3000
setlocal
set "NODE_DIR=%USERPROFILE%\.local\apps\nodejs\node-v26.13.0-win-x64"
if exist "%NODE_DIR%\node.exe" ( set "PATH=%NODE_DIR%;%PATH%" )

cd /d "%~dp0backend"
if not exist node_modules (
  echo Installing backend dependencies...
  call npm.cmd install --no-audit --no-fund
)
echo Starting backend on http://localhost:3000 ...
call npm.cmd run dev
endlocal
