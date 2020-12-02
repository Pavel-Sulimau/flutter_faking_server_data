import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:fake_http_client/fake_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_faking_server_data/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_archive/http_archive.dart';

Future<void> main() async {
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();

  await _setHttpOverridesToUseHarCache();

  runApp(App());
}

Future<void> _setHttpOverridesToUseHarCache() async {
  HttpOverrides.global = _ProxySettingHttpOverrides(
    harRoot: await _createHarRootFromBundledFile(
      'test_resources/top_articles_on_bbc_news.har.json',
    ),
  );
}

Future<HarRoot> _createHarRootFromBundledFile(
    String bundledFileRelativePath) async {
  final jsonHarString = await rootBundle.loadString(bundledFileRelativePath);
  return HarRoot.fromJson(
    json.decode(jsonHarString) as Map<String, dynamic>,
  );
}

class _ProxySettingHttpOverrides extends HttpOverrides {
  _ProxySettingHttpOverrides({@required HarRoot harRoot})
      : _harRequestResponseMap = HashMap.fromEntries(
          harRoot.log.entries.map((e) => MapEntry(e.request, e.response)),
        );

  final HashMap<HarRequest, HarResponse> _harRequestResponseMap;

  @override
  HttpClient createHttpClient(SecurityContext context) {
    return FakeHttpClient((request, client) {
      final requestUrl = request.uri.toString();

      int fakeHttpResponseStatus;
      dynamic fakeResponseBody;
      final matchingFakeResponse = _harRequestResponseMap[HarRequest(
        url: requestUrl,
        method: request.method,
      )];

      if (matchingFakeResponse == null) {
        fakeResponseBody = 'No response faked for this url: $requestUrl';
        fakeHttpResponseStatus = HttpStatus.badRequest;
      } else {
        fakeResponseBody = _decodeBody(matchingFakeResponse.content);
        fakeHttpResponseStatus = HttpStatus.ok;
      }

      return FakeHttpResponse(
        body: fakeResponseBody,
        statusCode: fakeHttpResponseStatus,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
  }
}

dynamic _decodeBody(HarResponseContent responseContent) {
  final content = responseContent?.text;

  if (content.isNotEmpty == true) {
    if (responseContent.mimeType.startsWith('application/json')) {
      return utf8.decode(base64.decode(content));
    } else if (responseContent.mimeType.startsWith('image')) {
      return base64.decode(content);
    } else {
      return content;
    }
  } else {
    return '';
  }
}
