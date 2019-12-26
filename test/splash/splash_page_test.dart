import 'package:flutter/material.dart';
import 'package:flutter_cac/splash/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display 5 times when splash page displayed',
      (WidgetTester tester) async {
    // Given
    await tester.pumpWidget(
      MaterialApp(
        home: SplashPage(),
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );

    // When
    Finder skipButton5 = find.text('跳过5');
    // Then
    expect(skipButton5, findsOneWidget);
    // When
    await tester.pump(Duration(seconds: 1));
    Finder skipButton4 = find.text('跳过4');
    // Then
    expect(skipButton4, findsOneWidget);
    // When
    await tester.pump(Duration(seconds: 1));
    Finder skipButton3 = find.text('跳过3');
    // Then
    expect(skipButton3, findsOneWidget);
    // When
    await tester.pump(Duration(seconds: 1));
    Finder skipButton2 = find.text('跳过2');
    // Then
    expect(skipButton2, findsOneWidget);
    // When
    Finder skipButton1 = find.text('跳过1');
    await tester.pump(Duration(seconds: 1));
    // Then
    expect(skipButton1, findsOneWidget);
    // When
    await tester.pump(Duration(seconds: 1));
    Finder skipButton = find.text('跳过');
    // Then
    expect(skipButton, findsOneWidget);
  });
}
