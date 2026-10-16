@echo off
TITLE AI Resume Builder - Auto Setup & Runner
COLOR 0A

echo ========================================================
echo    AI RESUME BUILDER - 1-CLICK AUTOMATION RUNNER
echo ========================================================
echo.

:: Check Node.js
where node >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b
)

echo [1/3] Starting Local Form Server on http://localhost:3000 ...
start /B "Web Server" node server.js > server_output.log 2>&1
timeout /t 2 /nobreak >nul

echo [2/3] Opening Web Form in your browser...
start http://localhost:3000

echo [3/3] Starting n8n Automation Engine on http://localhost:5678 ...
echo (This may take a minute on first launch to download n8n)
echo.
echo ========================================================
echo   Web Form: http://localhost:3000/
echo   n8n Engine: http://localhost:5678/
echo   Workflow file: n8n_workflow_ai_resume_builder.json
echo ========================================================
echo.
echo Press Ctrl + C anytime in this window to stop n8n.
echo.

npx -y n8n
