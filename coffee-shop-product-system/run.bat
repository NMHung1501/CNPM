@echo off
setlocal

set APPDIR=%~dp0

cd /d "%APPDIR%"

echo [1/4] npm install
npm install

echo [2/4] copy .env if missing
if not exist .env (
  copy .env.example .env
)

echo [3/4] user reminder: import database schema_mssql.sql into SQL Server
echo Bạn hãy import file: database\schema_mssql.sql vào SQL Server trước khi chạy.
echo DB name: %DB_NAME%

echo [4/4] start server on port %PORT%
npm start
endlocal


