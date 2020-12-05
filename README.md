# flutter_faking_server_data

A demo Flutter app showing how to use [fake_http_client](https://pub.dev/packages/fake_http_client) and [http_archive](https://pub.dev/packages/http_archive) packages to fake server-side data.

You may be interested to use this approach in different scenarios:
  - it's useful for integration (UI) tests;
  - it is helpful during app development with unstable back-end.

## News API

The app uses [News API](https://newsapi.org). An api key has to be used in the requests. My free key is already in the sources, you can run the app with it or you can get and apply yours. If you got your key, you can set it in the environment variable with 'NEWS_API_KEY' name.

## Running UI tests

You can run them with just with

``flutter drive --target=test_driver/app.dart``

or the following command if you'd like to apply your key form the environment variable

``flutter drive --target=test_driver/app.dart --dart-define=NEWS_API_KEY=$NEWS_API_KEY``

Please note that actual HTTP calls will not be made in UI tests. The key that is passed there is needed only for the urls of the requests to be identical, i.e. the matching response from the cache is being fetched by the corresponding request's url (which has the key in the query string).