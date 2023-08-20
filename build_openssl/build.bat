@echo off

REM 记录开始时间
set start_time=%time%

@REM ~~~~~~~~~~~~~~~~~~~~~~~~~
SET SSL_ROOT=%CD%\openssl
@SET PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build

SET REL=--release
SET ARCH=VC-WIN64A
SET BUILD_ROOT=%SSL_ROOT%\build
SET PRE_OpenSSL=%BUILD_ROOT%\OpenSSL
SET PRE_SSL=%BUILD_ROOT%\SSL

@REM Directory given with --prefix MUST be absolute
SET CONFIG=%ARCH% %REL% --prefix=%PRE_OpenSSL% --openssldir=%PRE_SSL%
SET CONFIG=%CONFIG% --api=3.0 no-deprecated no-ssl no-err no-asm --release

cd /d %SSL_ROOT%
call vcvarsall.bat amd64
perl Configure %CONFIG%

@REM nmake clean
nmake
nmake test 
nmake install

@REM ~~~~~~~~~~~~~~~~~~~~~~~~~
REM 记录结束时间
set end_time=%time%

REM 输出开始和结束时间戳
set /a start_h=%start_time:~0,2%
set /a start_m=1%start_time:~3,2%-100
set /a start_s=1%start_time:~6,2%-100

set /a end_h=%end_time:~0,2%
set /a end_m=1%end_time:~3,2%-100
set /a end_s=1%end_time:~6,2%-100

set /a total=(%end_h%-%start_h%)*3600+(%end_m%-%start_m%)*60+(%end_s%-%start_s%)
set /a h=%total%/3600
set /a m=(%total%-%h%*3600)/60
set /a s=%total%-%h%*3600-%m%*60

echo Start Time: %start_time%
echo End Time: %end_time%
echo Elapsed: %h%:%m%:%s%

cd %~dp0
pause