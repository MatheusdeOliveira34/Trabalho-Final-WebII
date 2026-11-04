@echo off
cd /d "%~dp0Front"
echo Iniciando o front em http://localhost:5173
call npm run dev
