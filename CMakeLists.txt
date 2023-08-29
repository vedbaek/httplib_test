project(HelloHttplib)

set(SSL_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/third/OpenSSL/build/OpenSSL)
set(SSL_INCLUDE_DIR ${SSL_ROOT}/include)
set(SSL_LIB_DIR ${SSL_ROOT}/lib)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third/cpp-httplib)

add_definitions(-DCPPHTTPLIB_OPENSSL_SUPPORT)
include_directories(${SSL_INCLUDE_DIR})
link_libraries(libssl.lib libcrypto.lib)
link_directories(${SSL_LIB_DIR})

aux_source_directory(./ SRC)
add_executable(a ${SRC})