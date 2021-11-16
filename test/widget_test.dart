// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dentistry_app/screens/registration/registration_screen_view_model.dart';
import 'package:dentistry_app/screens/startScreen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dentistry_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Тестирование стартового окна', (WidgetTester tester) async {

    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      await tester.pumpWidget(
          const MaterialApp(
            home: Material(
              child: StartScreen(),
            ),
          ));

      expect(find.text('Главная'), findsNWidgets(2));
    });
  });

  test('Counter value should be incremented', () {

    final RegistrationScreenViewModel testViewModel = RegistrationScreenViewModel();

    testViewModel.emailController.text = "q@gmail.com";
    testViewModel.passwordController.text = "123456";
    testViewModel.confirmPasswordController.text = "123456";

    testViewModel.validationRegistUnitTest();

    expect(testViewModel.isErrorValidation, false);
  });

}
