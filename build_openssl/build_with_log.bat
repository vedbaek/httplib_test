@echo off
set start_time=%time%
set h=%start_time:~0,2%
set m=%start_time:~3,2%
set s=%start_time:~6,2%

set start_date=%date%
set YY=%start_date:~0,4%
set MM=%start_date:~5,2%
set DD=%start_date:~8,2%

call build.bat | tee "build_%YY%-%MM%-%DD% %h%'%m%'%s%.log"


