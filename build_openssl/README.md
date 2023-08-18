

# x64 Native Tools Command Prompt for VS 2022
```
> where perl
D:\app\strawberry-perl-5.32.1.1-64bit-portable\perl\bin\perl.exe

> where nasm
D:\app\nasm-2.16.01-win64\nasm-2.16.01\nasm.exe
```

# build
```
perl Configure VC-WIN64A --prefix=%CD%/out
nmake
nmake install

# 清理
nmake clean
```

### no-{protocol}

    no-{ssl|ssl3|tls|tls1|tls1_1|tls1_2|tls1_3|dtls|dtls1|dtls1_2}

Don't build support for negotiating the specified SSL/TLS protocol.

If `no-tls` is selected then all of `tls1`, `tls1_1`, `tls1_2` and `tls1_3`
are disabled.
Similarly `no-dtls` will disable `dtls1` and `dtls1_2`.  The `no-ssl` option is
synonymous with `no-ssl3`.  Note this only affects version negotiation.
OpenSSL will still provide the methods for applications to explicitly select
the individual protocol versions.

# build
```
# /k 在执行完程序之后，cmd.exe 依然会继续运行
set vcvar="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
%comspec% /k %vcvar% amd64

# --api=1.3.0 no-deprecated 指定编译版本，will remove support for all APIs that were deprecated in OpenSSL version 1.1.0 or below.  
# --debug                   Build OpenSSL with debugging symbols and zero optimization level.
# --release                 Build OpenSSL without debugging symbols.  This is the default.
# --prefix                  安装路径，指定了之后还是会自动尝试往C:\Program Files\OpenSSL写

# no-asm
This should be viewed as debugging/troubleshooting option rather than for
production use.  On some platforms a small amount of assembler code may still
be used even with this option.

set vcvar="C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"
%comspec% /k %vcvar% amd64 && perl Configure VC-WIN64A --prefix=%CD%/out2 --api=1.3.0 no-deprecated && nmake && nmake install
%comspec% /k %vcvar% amd64 && perl Configure VC-WIN64A --prefix=%CD%/out3 no-ssl && nmake && nmake install

perl Configure VC-WIN64A --prefix=%CD%/out2 --api=3.0 --no-deprecated --no-asm
nmake
nmake install

perl Configure VC-WIN64A --prefix=%CD%/out3 no-ssl && nmake && nmake install

nmake clean
perl Configure VC-WIN64A --prefix=%CD%/out3 no-ssl && nmake && nmake install

```

# 参考
https://github.com/openssl/openssl/blob/master/INSTALL.md
https://github.com/openssl/openssl/blob/master/README.md
https://github.com/openssl/openssl
https://wiki.swoole.com/wiki/page/437.html#entry_h2_8