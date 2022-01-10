// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocked_navigation_test/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'navigator_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      as: #MockNavigatorObserver,
      returnNullOnMissingStub: true,
    ),
  ],
)
void main() {
  final navigatorObserver = MockNavigatorObserver();

  testWidgets('First page push test', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        //onGenerateRoute: Routes.onGenerateRoute,
        navigatorObservers: [navigatorObserver],
        routes: Routes.namedRoutes(context),
        initialRoute: '/',
      );
    }));

    expect(
      verify(
        navigatorObserver.didPush(captureAny, any),
      ).captured.single,
      (Route r) => r.settings.name == '/',
    );
  });

  testWidgets('Second page push test', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        navigatorObservers: [navigatorObserver],
        routes: Routes.namedRoutes(context),
        initialRoute: '/',
      );
    }));

    await tester.tap(find.text('PUSH'));

    expect(
      verify(
        navigatorObserver.didPush(captureAny, any),
      ).captured[1],
      (Route r) => r.settings.name == '/second',
    );
  });

  testWidgets('Second page pop test', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        navigatorObservers: [navigatorObserver],
        routes: Routes.namedRoutes(context),
        initialRoute: '/',
      );
    }));

    await tester.tap(find.text('PUSH'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('POP'));

    expect(
      verify(
        navigatorObserver.didPop(captureAny, any),
      ).captured.single,
      (Route r) => r.settings.name == '/second',
    );
  });

  testWidgets('Second page replace test', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        navigatorObservers: [navigatorObserver],
        routes: Routes.namedRoutes(context),
        initialRoute: '/',
      );
    }));

    await tester.tap(find.text('REPLACE'));

    expect(
      verify(
        navigatorObserver.didReplace(
          newRoute: captureAnyNamed('newRoute'),
          oldRoute: anyNamed('oldRoute'),
        ),
      ).captured.single,
      (Route r) => r.settings.name == '/second',
    );
  });
}
