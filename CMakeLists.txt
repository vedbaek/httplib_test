project(HelloHttplib)

include_directories(D:/git/openssl/output/include)

aux_source_directory(./ SRC)
add_definitions(-DCPPHTTPLIB_OPENSSL_SUPPORT)

link_libraries(libssl.lib libcrypto.lib)
link_directories(D:/git/openssl/output/lib)

add_executable(a ${SRC})