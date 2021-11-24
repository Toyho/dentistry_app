// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dentistry_app/screens/login/login_screen.dart';
import 'package:dentistry_app/screens/registration/registration_screen.dart';
import 'package:dentistry_app/screens/registration/registration_screen_view_model.dart';
import 'package:dentistry_app/screens/startScreen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dentistry_app/main.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: StartScreen(uid: "w0u31TcoRKccOITstudD1kg03sI2"),
        ),
      ));

      expect(find.text('Главная'), findsNWidgets(2));
    });
  });

  test('Тестирование функции валидации при регистрации', () {
    final RegistrationScreenViewModel testViewModel =
        RegistrationScreenViewModel();

    testViewModel.emailController.text = "q@gmail.com";
    testViewModel.passwordController.text = "123456";
    testViewModel.confirmPasswordController.text = "123456";

    testViewModel.validationRegistUnitTest();

    expect(testViewModel.isErrorValidation, false);
  });

  group("Тестирование навигации между авторизацией и регистрацией", () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const LoginScreen(),
        onGenerateRoute: (routeSettings) {
          var path = routeSettings.name!.split('/');

          switch (path[1]) {
            case "registration_screen":
              {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RegistrationScreen(),
                  settings: routeSettings,
                );
              }
          }
        },
        navigatorObservers: [mockObserver],
      ));

      // verify(mockObserver.didPush(captureAny, any)).captured.single;
    }

    Future<void> _navigateToRegistrationPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('navigateToRegistration')));
      await tester.pumpAndSettle();
    }

    testWidgets("Переход на новую страницу после нажатия кнопки",
        (WidgetTester tester) async {
      await _buildMainPage(tester);
      expect(find.text('Авторизироваться'), findsOneWidget);
      await _navigateToRegistrationPage(tester);

      // verify(mockObserver.didPush(any!, any));

      expect(find.byType(RegistrationScreen), findsOneWidget);

      expect(find.text('Зарегистрироваться'), findsOneWidget);
      expect(find.text('Повторите пароль'), findsOneWidget);
      expect(find.text('Авторизироваться'), findsNothing);
    });
  });
}
