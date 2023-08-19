

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

perl Configure VC-WIN64A --prefix=%CD%/out2 --api=3.0 no-deprecated --no-asm
nmake
nmake install

perl Configure VC-WIN64A --prefix=%CD%/out3 no-ssl && nmake && nmake install

nmake clean
perl Configure VC-WIN64A --prefix=%CD%/out3 no-ssl && nmake && nmake install

```


------------------------------------------------------------------------------------------------
Build Type
----------

    --debug

Build OpenSSL with debugging symbols and zero optimization level.

    --release

Build OpenSSL without debugging symbols.  This is the default.


Installation directories
------------------------

The default installation directories are derived from environment
variables.

For VC-WIN32, the following defaults are use:

    PREFIX:      %ProgramFiles(x86)%\OpenSSL
    OPENSSLDIR:  %CommonProgramFiles(x86)%\SSL

For VC-WIN64, the following defaults are use:

    PREFIX:      %ProgramW6432%\OpenSSL
    OPENSSLDIR:  %CommonProgramW6432%\SSL

Should those environment variables not exist (on a pure Win32
installation for examples), these fallbacks are used:

    PREFIX:      %ProgramFiles%\OpenSSL
    OPENSSLDIR:  %CommonProgramFiles%\SSL

ALSO NOTE that those directories are usually write protected, even if
your account is in the Administrators group.  To work around that,
start the command prompt by right-clicking on it and choosing "Run as
Administrator" before running `nmake install`.  The other solution
is, of course, to choose a different set of directories by using
`--prefix` and `--openssldir` when configuring.


Configuration Options
=====================

There are several options to `./Configure` to customize the build (note that
for Windows, the defaults for `--prefix` and `--openssldir` depend on what
configuration is used and what Windows implementation OpenSSL is built on.
For more information, see the [Notes for Windows platforms](NOTES-WINDOWS.md).

API Level
---------

    --api=x.y[.z]

Build the OpenSSL libraries to support the API for the specified version.
If [no-deprecated](#no-deprecated) is also given, don't build with support
for deprecated APIs in or below the specified version number.  For example,
adding

    --api=1.1.0 no-deprecated

will remove support for all APIs that were deprecated in OpenSSL version
1.1.0 or below.  This is a rather specialized option for developers.
If you just intend to remove all deprecated APIs up to the current version
entirely, just specify [no-deprecated](#no-deprecated).
If `--api` isn't given, it defaults to the current (minor) OpenSSL version.

```shell
# --api         One of 0.9.8, 1.0.0, 1.0.1, 1.0.2, 1.1.0, 1.1.1, or 3.0
#               Define the public APIs as they were for that version
#               including patch releases.  If 'no-deprecated' is also
#               given, do not compile support for interfaces deprecated
#               up to and including the specified OpenSSL version.
```

Enable and Disable Features
---------------------------

Feature options always come in pairs, an option to enable feature
`xxxx`, and an option to disable it:

    [ enable-xxxx | no-xxxx ]

Whether a feature is enabled or disabled by default, depends on the feature.
In the following list, always the non-default variant is documented: if
feature `xxxx` is disabled by default then `enable-xxxx` is documented and
if feature `xxxx` is enabled by default then `no-xxxx` is documented.

### no-asm

Do not use assembler code.

This should be viewed as debugging/troubleshooting option rather than for
production use.  On some platforms a small amount of assembler code may still
be used even with this option.


### no-deprecated

Don't build with support for deprecated APIs up until and including the version
given with `--api` (or the current version, if `--api` wasn't specified).


### no-err

Don't compile in any error strings.

### no-{protocol}

    no-{ssl|ssl3|tls|tls1|tls1_1|tls1_2|tls1_3|dtls|dtls1|dtls1_2}

Don't build support for negotiating the specified SSL/TLS protocol.

If `no-tls` is selected then all of `tls1`, `tls1_1`, `tls1_2` and `tls1_3`
are disabled.
Similarly `no-dtls` will disable `dtls1` and `dtls1_2`.  The `no-ssl` option is
synonymous with `no-ssl3`.  Note this only affects version negotiation.
OpenSSL will still provide the methods for applications to explicitly select
the individual protocol versions.

### no-{protocol}-method

    no-{ssl3|tls1|tls1_1|tls1_2|dtls1|dtls1_2}-method

Analogous to `no-{protocol}` but in addition do not build the methods for
applications to explicitly select individual protocol versions.  Note that there
is no `no-tls1_3-method` option because there is no application method for
TLSv1.3.

Using individual protocol methods directly is deprecated.  Applications should
use `TLS_method()` instead.


### no-{protocol}-method

    no-{ssl3|tls1|tls1_1|tls1_2|dtls1|dtls1_2}-method

Analogous to `no-{protocol}` but in addition do not build the methods for
applications to explicitly select individual protocol versions.  Note that there
is no `no-tls1_3-method` option because there is no application method for
TLSv1.3.

Using individual protocol methods directly is deprecated.  Applications should
use `TLS_method()` instead.

### enable-{algorithm}

    enable-{md2|rc5}

Build with support for the specified algorithm.

### no-{algorithm}

    no-{aria|bf|blake2|camellia|cast|chacha|cmac|
        des|dh|dsa|ecdh|ecdsa|idea|md4|mdc2|ocb|
        poly1305|rc2|rc4|rmd160|scrypt|seed|
        siphash|siv|sm2|sm3|sm4|whirlpool}

Build without support for the specified algorithm.

The `ripemd` algorithm is deprecated and if used is synonymous with `rmd160`.


Build OpenSSL
-------------

Build OpenSSL by running:

    $ make                                           # Unix
    $ mms                                            ! (or mmk) OpenVMS
    $ nmake                                          # Windows

This will build the OpenSSL libraries (`libcrypto.a` and `libssl.a` on
Unix, corresponding on other platforms) and the OpenSSL binary
(`openssl`).  The libraries will be built in the top-level directory,
and the binary will be in the `apps/` subdirectory.

If the build fails, take a look at the [Build Failures](#build-failures)
subsection of the [Troubleshooting](#troubleshooting) section.

Test OpenSSL
------------

After a successful build, and before installing, the libraries should
be tested.  Run:

    $ make test                                      # Unix
    $ mms test                                       ! OpenVMS
    $ nmake test                                     # Windows

**Warning:** you MUST run the tests from an unprivileged account (or disable
your privileges temporarily if your platform allows it).

See [test/README.md](test/README.md) for further details how run tests.

See [test/README-dev.md](test/README-dev.md) for guidelines on adding tests.

Install OpenSSL
---------------

If everything tests ok, install OpenSSL with

    $ make install                                   # Unix
    $ mms install                                    ! OpenVMS
    $ nmake install                                  # Windows

Note that in order to perform the install step above you need to have
appropriate permissions to write to the installation directory.

The above commands will install all the software components in this
directory tree under `<PREFIX>` (the directory given with `--prefix` or
its default):


# 参考
https://github.com/openssl/openssl/blob/master/INSTALL.md
https://github.com/openssl/openssl/blob/master/README.md
https://github.com/openssl/openssl
https://wiki.swoole.com/wiki/page/437.html#entry_h2_8