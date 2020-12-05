import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_faking_server_data/ui_keys.dart';
import 'package:test/test.dart';

void main() {
  group('Basic UI Tests', () {
    FlutterDriver _driver;

    setUpAll(() async {
      _driver = await FlutterDriver.connect();
      await _driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (_driver != null) {
        await _driver.close();
      }
    });

    test('verifies app bar title text', () async {
      await _driver.waitFor(find.byValueKey(UIKeys.appBar));

      final appBarTitleText = await _driver.getText(find.descendant(
        of: find.byValueKey(UIKeys.appBar),
        matching: find.byType('Text'),
        firstMatchOnly: true,
      ));

      expect(appBarTitleText, 'Faking Server Data');
    });

    test('verifies headlines list is shown and first item text is correct', () async {
      await _driver.waitFor(find.byValueKey(UIKeys.homeHeadlinesList));

      final firstListTileTextWidget = find.descendant(
        of: find.byValueKey(UIKeys.homeHeadlinesList),
        matching: find.byType('Text'),
        firstMatchOnly: true,
      );
      final firstListTileText = await _driver.getText(firstListTileTextWidget);

      expect(firstListTileText, startsWith('US attorney general finds'));
    });
  });
}
