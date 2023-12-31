@echo off

SET SSL_ROOT=%CD%\..\openssl
@SET PATH=%PATH%;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build

SET REL=--release
SET ARCH=VC-WIN64A
SET BUILD_ROOT=%SSL_ROOT%\build
SET PRE_OpenSSL=%BUILD_ROOT%\OpenSSL
SET PRE_SSL=%BUILD_ROOT%\SSL

@REM Directory given with --prefix MUST be absolute
SET CONFIG=%ARCH% %REL% --prefix=%PRE_OpenSSL% --openssldir=%PRE_SSL%
SET CONFIG=%CONFIG% --release --api=3.0 no-deprecated no-ssl no-tls1 no-tls1_1 no-dtls1 no-ssl3-method no-tls1-method no-tls1_1-method

cd /d %SSL_ROOT%
call vcvarsall.bat amd64
perl Configure %CONFIG%

@REM nmake clean
nmake
@REM nmake test 
nmake install

cd %~dp0