@echo off
set start_time=%time%
set h=%start_time:~0,2%
set m=%start_time:~3,2%
set s=%start_time:~6,2%

set start_date=%date%
set YY=%start_date:~0,4%
set MM=%start_date:~5,2%
set DD=%start_date:~8,2%

set TARGET=%1
if "%TARGET%" == "" (
    set TARGET=build.bat
)

set LOG_FILE="%TARGET%_%YY%-%MM%-%DD% %h%'%m%'%s%.log"

call %TARGET% | tee %LOG_FILE%
set end_time=%time%

REM =========================== delta time
set /a delta_hours=1%end_time:~0,2%-1%start_time:~0,2%
set /a delta_minutes=1%end_time:~3,2%-1%start_time:~3,2%
set /a delta_seconds=1%end_time:~6,2%-1%start_time:~6,2%

if %delta_seconds% lss 0 (
    set /a delta_seconds+=60
    set /a delta_minutes-=1
)

if %delta_minutes% lss 0 (
    set /a delta_minutes+=60
    set /a delta_hours-=1
)

REM =========================== summary
echo Start Time: %start_date% %start_time% | tee -a %LOG_FILE%
echo End Time: %date% %end_time% | tee -a %LOG_FILE%
echo Time elapsed: %delta_hours%:%delta_minutes%:%delta_seconds% | tee -a %LOG_FILE%
