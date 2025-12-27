import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_buddy/main.dart'; // 👈 make sure this matches your actual package name

void main() {
  testWidgets('Splash screen loads correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const StudyBuddyApp());

    // Verify that the splash screen shows "Study Buddy"
    expect(find.text('Study Buddy'), findsOneWidget);
  });

  testWidgets('Login screen has email and password fields', (WidgetTester tester) async {
    // Navigate directly to LoginScreen by pushing the route
    await tester.pumpWidget(const StudyBuddyApp());
    await tester.pumpAndSettle();

    // Since SplashScreen redirects, we wait for navigation
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Home screen shows task list and buttons', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const StudyBuddyApp());

    // Navigate to HomeScreen manually
    await tester.pumpAndSettle();

    // Verify that the HomeScreen has expected UI elements
    expect(find.text('Study Buddy'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget); // Floating Action Button
    expect(find.byIcon(Icons.timer), findsOneWidget); // Focus Timer button
    expect(find.byIcon(Icons.book), findsOneWidget); // Dictionary button
  });
}
