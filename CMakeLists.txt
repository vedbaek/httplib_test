project(HelloHttplib)

set(SSL_ROOT D:/git/build_openssl/openssl/build/OpenSSL)
set(SSL_INCLUDE_DIR ${SSL_ROOT}/include)
set(SSL_LIB_DIR ${SSL_ROOT}/lib)

include_directories(${SSL_INCLUDE_DIR})

aux_source_directory(./ SRC)
add_definitions(-DCPPHTTPLIB_OPENSSL_SUPPORT)

link_libraries(libssl.lib libcrypto.lib)
link_directories(${SSL_LIB_DIR})

add_executable(a ${SRC})