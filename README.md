
# submodule
```
# push
git submodule add git@github.com:yhirose/cpp-httplib.git third/cpp-httplib
cd cpp-httplib
git checkout v0.14.0

git submodule add git@github.com:openssl/openssl.git third/openssl
cd openssl
git checkout openssl-3.1.2

# pull
git pull
git submodule update --init
```


# httplib::Client with https
```
httplib::Client cli("https://www.baidu.com");
```

```
#ifdef CPPHTTPLIB_OPENSSL_SUPPORT
      // TODO: refactoring
      if (is_ssl()) {
        auto &scli = static_cast<SSLClient &>(*this);
        if (!proxy_host_.empty() && proxy_port_ != -1) {
          auto success = false;
          if (!scli.connect_with_proxy(socket_, res, success, error)) {
            return success;
          }
        }

        if (!scli.initialize_ssl(socket_, error)) { return false; }
      }
#endif
```

# Client with https
```
a.exe!httplib::SSLClient::initialize_ssl(httplib::ClientImpl::Socket & socket, httplib::Error & error) 行 8522	C++
a.exe!httplib::ClientImpl::send_(httplib::Request & req, httplib::Response & res, httplib::Error & error) 行 6800	C++
a.exe!httplib::ClientImpl::send(httplib::Request & req, httplib::Response & res, httplib::Error & error) 行 6755	C++
a.exe!httplib::ClientImpl::send_(httplib::Request && req) 行 6860	C++
a.exe!httplib::ClientImpl::Get(const std::string & path, const std::multimap<std::string,std::string,httplib::detail::ci,std::allocator<std::pair<std::string const ,std::string>>> & headers, std::function<bool __cdecl(unsigned __int64,unsigned __int64)> progress) 行 7395	C++
a.exe!httplib::ClientImpl::Get(const std::string & path) 行 7376	C++
a.exe!httplib::Client::Get(const std::string & path) 行 8805	C++
a.exe!main() 行 20	C++

```

# SSLClient
```
a.exe!httplib::SSLClient::initialize_ssl(httplib::ClientImpl::Socket & socket, httplib::Error & error) 行 8522	C++
a.exe!httplib::ClientImpl::send_(httplib::Request & req, httplib::Response & res, httplib::Error & error) 行 6800	C++
a.exe!httplib::ClientImpl::send(httplib::Request & req, httplib::Response & res, httplib::Error & error) 行 6755	C++
a.exe!httplib::ClientImpl::send_(httplib::Request && req) 行 6860	C++
a.exe!httplib::ClientImpl::Get(const std::string & path, const std::multimap<std::string,std::string,httplib::detail::ci,std::allocator<std::pair<std::string const ,std::string>>> & headers, std::function<bool __cdecl(unsigned __int64,unsigned __int64)> progress) 行 7395	C++
a.exe!httplib::ClientImpl::Get(const std::string & path) 行 7376	C++
a.exe!main() 行 20	C++
```

# tls_version_table
```
/* Must be in order high to low */
static const version_info tls_version_table[] = {
#ifndef OPENSSL_NO_TLS1_3
    {TLS1_3_VERSION, tlsv1_3_client_method, tlsv1_3_server_method},
#else
    {TLS1_3_VERSION, NULL, NULL},
#endif
#ifndef OPENSSL_NO_TLS1_2
    {TLS1_2_VERSION, tlsv1_2_client_method, tlsv1_2_server_method},
#else
    {TLS1_2_VERSION, NULL, NULL},
#endif
#ifndef OPENSSL_NO_TLS1_1
    {TLS1_1_VERSION, tlsv1_1_client_method, tlsv1_1_server_method},
#else
    {TLS1_1_VERSION, NULL, NULL},
#endif
#ifndef OPENSSL_NO_TLS1
    {TLS1_VERSION, tlsv1_client_method, tlsv1_server_method},
#else
    {TLS1_VERSION, NULL, NULL},
#endif
#ifndef OPENSSL_NO_SSL3
    {SSL3_VERSION, sslv3_client_method, sslv3_server_method},
#else
    {SSL3_VERSION, NULL, NULL},
#endif
    {0, NULL, NULL},
};
```