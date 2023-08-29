#include "httplib.h"
#include <iostream>
using namespace std;

int main() {
  // 这里只能用host初始化，不带https前缀或者path后缀
  // httplib::SSLClient cli("www.baidu.com");
  httplib::SSLClient cli("jsonplaceholder.typicode.com");
  // ok
  cli.enable_server_certificate_verification(true);

  // // 使用ssl
  // httplib::Client cli("https://www.baidu.com");
  // // ok
  // cli.enable_server_certificate_verification(true);

  // // 不使用ssl
  // httplib::Client cli("http://www.baidu.com");
  // // unknown certificate verification error
  // cli.enable_server_certificate_verification(true);

  // 这里可以只写path，也可以写完整请求url
  // auto res = cli.Get("/posts?_limit=5");
  auto res = cli.Get("https://jsonplaceholder.typicode.com/posts?_limit=1");
  auto result = cli.get_openssl_verify_result();
  cout << X509_verify_cert_error_string(result) << endl;

  if (res) {
    cout << res->body << endl << endl;
  } else {
    cout << res.error() << endl << endl;
  }

  return 0;
}