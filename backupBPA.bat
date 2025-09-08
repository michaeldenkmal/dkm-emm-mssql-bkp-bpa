set osql="osql.exe"
set BKPDRV=d
set BKPDIR=d:\backup\backupmssql\bpa
set sql_server=EMMS7\bpa

set dbs=bpa bpa-test

call %~dp0local_config.bat

for %%a in ( %dbs% ) do call :backup_exec %%a

goto :EOF


:backup_exec
set db=%1
set DMPFILE=%BKPDIR%\expdat%db%4.dmp
set tsql=%TEMP%\backupmssql%db%4.bat
set tlog=%TEMP%\backupmssql%db%4.log
set alllog=%BKPDIR%\alllog%db%4.txt"


rem ################ ende der Variablen section

echo use master >%tsql%
echo GO >>%tsql%
echo EXEC sp_addumpdevice 'disk', 'diskbackup%db%','%DMPFILE%'>>%tsql%
echo GO >>%tsql%
echo BACKUP DATABASE [%DB%] TO [diskbackup%db%] >>%tsql%
echo GO >>%tsql%

%BKPDRV%:
cd %BKPDIR%


if not exist expdat%db%4.dmp goto nomove
del expdat%db%1.dmp
move expdat%db%2.dmp expdat%db%1.dmp
move expdat%db%3.dmp expdat%db%2.dmp
move expdat%db%4.dmp expdat%db%3.dmp
:nomove
%osql% -U %DB_USER% -P %DB_PWD% -i %tsql% -o %tlog% -S %sql_server%
type %tlog% >>%alllog%


goto :EOF


:pause
