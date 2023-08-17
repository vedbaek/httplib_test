
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