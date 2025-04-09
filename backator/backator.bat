@echo off
:: dont forget do edit the source folder
set "SOURCE_FOLDER=C:\FOLDER\TO\BACKUP"
set "DESTINATION=C:\FOLDER\TO\SAVE\TO\"

:: set up zip name
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "DATESTAMP=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%"
set "ZIP_FILE=%DESTINATION%\backup_%DATESTAMP%.zip"

powershell -command "& {Compress-Archive -Path '%SOURCE_FOLDER%\*' -DestinationPath '%ZIP_FILE%' -Force}"

echo Backup completed: %ZIP_FILE%
pause