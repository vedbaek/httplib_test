set INSTALL_DIR=%CD%\out3

set VCVAR="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"

cd .\openssl
call %VCVAR% amd64
perl Configure VC-WIN64A --prefix=%INSTALL_DIR% --no-ssl --no-tls1 --no-tls1_1 --no-tls1_2
nmake clean
nmake
nmake install

cd %~dp0
pause