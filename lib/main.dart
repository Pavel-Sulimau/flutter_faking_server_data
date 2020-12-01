import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_faking_server_data/app.dart';
import 'package:flutter_faking_server_data/config.dart';

void main() {
  if (networkProxy.isNotEmpty) {
    HttpOverrides.global = _ProxySettingHttpOverrides();
  }

  runApp(App());
}

class _ProxySettingHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    final httpClient = super.createHttpClient(context);

    httpClient.badCertificateCallback = (cert, host, port) => true;
    httpClient.findProxy = (uri) => 'PROXY $networkProxy;';

    return httpClient;
  }
}
