project(HelloHttplib)

set(SSL_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/third/OpenSSL/build/OpenSSL)
set(SSL_INCLUDE_DIR ${SSL_ROOT}/include)
set(SSL_LIB_DIR ${SSL_ROOT}/lib)
set(SSL_DLL_DIR ${SSL_ROOT}/bin)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/third/cpp-httplib)

add_definitions(-DCPPHTTPLIB_OPENSSL_SUPPORT)
include_directories(${SSL_INCLUDE_DIR})
link_libraries(libssl.lib libcrypto.lib)
link_directories(${SSL_LIB_DIR})

aux_source_directory(./ SRC)
add_executable(${PROJECT_NAME} ${SRC})

file(GLOB SSL_DLL ${SSL_DLL_DIR}/lib*)
message(${SSL_DLL})

# 复制依赖的dll到可执行文件所在目录
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${SSL_DLL} $<TARGET_FILE_DIR:${PROJECT_NAME}>)