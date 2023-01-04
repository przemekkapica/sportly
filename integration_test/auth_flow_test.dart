import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:sportly/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('authentication flow', () {
    testWidgets('signs in and out', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(find.text('Sign in with Google'), findsOneWidget);
      final Finder signInButton = find.byKey(const Key('sign-in-button'));
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      expect(find.text('Join a team'), findsOneWidget);
      final Finder profileButton = find.byIcon(Icons.account_circle);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign out'), findsOneWidget);
      final Finder signOutButton = find.byKey(const Key('sign-out-button'));
      await tester.tap(signOutButton);
      await tester.pumpAndSettle();

      expect(find.text('Sign in with Google'), findsOneWidget);
    });
  });
}
