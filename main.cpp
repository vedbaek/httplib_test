#include "httplib.h"
#include <iostream>
using namespace std;

int main() {
  //httplib::SSLClient cli("www.baidu.com", 443);
  //cli.enable_server_certificate_verification(true);
  httplib::Client cli("http://www.baidu.com");

  auto res = cli.Get("/");
  if (res) {
    cout << res->body << endl;
  } else {
    cout << res.error() << endl;
  }
  return 0;
}