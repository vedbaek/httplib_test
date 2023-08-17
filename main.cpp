#include "httplib.h"
#include <iostream>
using namespace std;

int main() {
  httplib::SSLClient cli("www.baidu.com");
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

  auto res = cli.Get("/");
  auto result = cli.get_openssl_verify_result();
  cout << X509_verify_cert_error_string(result) << endl;

  if (res) {
    cout << res->body << endl << endl;
  } else {
    cout << res.error() << endl << endl;
  }

  return 0;
}