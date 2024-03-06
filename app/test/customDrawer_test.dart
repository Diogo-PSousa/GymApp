import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:fit_friend/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_friend/FAQ_page.dart';
import 'package:fit_friend/favorites_list_screen.dart';
import 'package:fit_friend/muscle_exercise_page.dart';


void main() {
  group('Drawer widget tests', () {
    testWidgets('Drawer navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            drawer: CustomDrawer(),
            appBar: CustomAppBar(),
          ),
          routes: {
            '/home': (BuildContext context) => const HomePage(),
            '/muscleExercisePage': (BuildContext context) => const MuscleExercisePage(),
            '/FAQ': (BuildContext context) => const FAQPage(),
            '/favoritesScreen': (BuildContext context) => const FavoritesScreen(),
          },
        ),
      );

      // Tap the hamburger icon to open the drawer
      final drawerIcon = find.byIcon(Icons.menu);
      expect(drawerIcon, findsOneWidget);
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      // Tap the "Muscle Exercises" button
      final muscleExercisesButton = find.text('Muscle Exercises');
      expect(muscleExercisesButton, findsOneWidget);
      await tester.tap(muscleExercisesButton);
      await tester.pumpAndSettle();

      // Verify that the MuscleExercisePage is visible
      final muscleExercisePage = find.byType(MuscleExercisePage);
      expect(muscleExercisePage, findsOneWidget);

      // Tap the hamburger icon to open the drawer again
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      // Tap the "FAQ" button
      final faqButton = find.text('FAQ');
      expect(faqButton, findsOneWidget);
      await tester.tap(faqButton);
      await tester.pumpAndSettle();

      // Verify that the FAQPage is visible
      final faqPage = find.byType(FAQPage);
      expect(faqPage, findsOneWidget);

      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

    });

    testWidgets('Drawer contains a header with text "Menu"',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(),
            drawer: CustomDrawer(),
          ),
        ),
      );

      final drawerIcon = find.byIcon(Icons.menu);
      expect(drawerIcon, findsOneWidget);
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      expect(find.text('Menu'), findsOneWidget);
    });

    testWidgets('Drawer contains a logout button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(),
            drawer: CustomDrawer(),
          ),
        ),
      );
      final drawerIcon = find.byIcon(Icons.menu);
      expect(drawerIcon, findsOneWidget);
      await tester.tap(drawerIcon);
      await tester.pumpAndSettle();

      expect(find.text("Log out"), findsOneWidget);

    });
  });
}
