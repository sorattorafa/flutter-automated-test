import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('verifies the list contains a specific item', () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      // Record a performance profile as the app scrolls through
      // the list of items.
      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(
          listFinder,
          itemFinder,
          dyScroll: -300.0,
        );

        expect(await driver.getText(itemFinder), 'Item 50');
      });

      // Convert the Timeline into a TimelineSummary that's easier to
      // read and understand.
      final summary = new TimelineSummary.summarize(timeline);

      // Then, save the summary to disk.
     // await summary.writeSummaryToFile('scrolling_summary', pretty: true);

      // Optionally, write the entire timeline to disk in a json format.
      // This file can be opened in the Chrome browser's tracing tools
      // found by navigating to chrome://tracing.
      await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
