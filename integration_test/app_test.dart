import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sportly/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('basic flow', () {
    testWidgets('signs in', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(find.text('Sign in with Google'), findsOneWidget);
      final Finder signInButton = find.byKey(const Key('sign-in-button'));
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      expect(find.text('Teams'), findsOneWidget);
      expect(find.text('Join a team'), findsOneWidget);
      expect(find.text('Create a team'), findsOneWidget);

      final Finder profileButton = find.byIcon(Icons.account_circle);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign out'), findsOneWidget);

      await tester.pumpAndSettle();

      final Finder chatButton = find.byIcon(Icons.chat);
      await tester.tap(chatButton);
      await tester.pumpAndSettle();

      expect(find.text('Chat'), findsOneWidget);

      await tester.pumpAndSettle();

      final Finder scheduleButton = find.byIcon(Icons.calendar_month_rounded);
      await tester.tap(scheduleButton);
      await tester.pumpAndSettle();

      expect(find.text('Schedule'), findsOneWidget);

      await tester.pumpAndSettle();

      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Sign out'), findsOneWidget);

      await tester.pumpAndSettle();

      final Finder signOutButton = find.byKey(const Key('sign-out-button'));
      await tester.tap(signOutButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign in with Google'), findsOneWidget);
    });
  });
}
