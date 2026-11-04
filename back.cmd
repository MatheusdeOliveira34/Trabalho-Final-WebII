@echo off
cd /d "%~dp0Back"
echo Iniciando o back em http://localhost:8080
call mvnw.cmd spring-boot:run
