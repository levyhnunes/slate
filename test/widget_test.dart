import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slate/main.dart';
import 'package:slate/widgets/login/login_button.dart';

/// Loads the app's real fonts: the default test font is much wider and
/// overflows rows that fit on a phone.
Future<void> _loadAppFonts() async {
  final manifest =
      json.decode(await rootBundle.loadString('FontManifest.json')) as List;
  for (final family in manifest) {
    final loader = FontLoader(family['family'] as String);
    for (final font in family['fonts'] as List) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}

void main() {
  setUpAll(_loadAppFonts);

  testWidgets('splash shows brand and then navigates to login', (tester) async {
    await tester.pumpWidget(const SlateApp());
    expect(find.text('SLATE'), findsOneWidget);
    expect(find.text('All your cards in one place'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2800));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsNWidgets(2));
    expect(find.text('Welcome back! Log in to continue.'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });

  testWidgets('logging in loads and then opens the home screen', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const SlateApp());
    await tester.pump(const Duration(milliseconds: 2800));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'me@slate.app');
    await tester.enterText(find.byType(TextFormField).last, 'secret');
    await tester.tap(find.byType(LoginButton));
    await tester.pump();
    // Request + flood + hold on black.
    await tester.pump(const Duration(milliseconds: 1450));
    await tester.pump(const Duration(milliseconds: 420));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.text('Hello DailyFlutterUI'), findsOneWidget);
    expect(find.text(r'$22,000'), findsOneWidget);
    expect(find.text('Recent transactions'), findsOneWidget);
  });
}
