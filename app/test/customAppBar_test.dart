import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/muscle_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBar widget tests', () {
    testWidgets('AppBar style and proportions are correct',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MuscleExercisePage()));
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, const Color(0xFFE2E2E2));
      expect(appBar.toolbarHeight, 80.0);
      expect(appBar.centerTitle, true);
    });

    testWidgets(
        'AppBar contains Fit and Friend text spans, with correct styles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MuscleExercisePage())
      );

      List<TextSpan> textSpans = [];
      final richTextFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.byType(RichText),
      );

      RichText richText = tester.widget(richTextFinder.last);
      richText.text.visitChildren((InlineSpan span) {
        if (span is TextSpan && (span.text == "Fit" || span.text == "Friend")) {
          textSpans.add(span);
        }
        return true;
      });

      expect(textSpans.length, equals(2));

      final fitStyle = textSpans[0].style;
      expect(fitStyle?.fontFamily, 'Jost');
      expect(fitStyle?.fontSize, 30);
      expect(fitStyle?.color, Colors.white);

      final friendStyle = textSpans[1].style;
      expect(friendStyle?.fontFamily, 'Jost');
      expect(friendStyle?.fontSize, 30);
      expect(friendStyle?.color, const Color(0xFFF54242));
    });


    testWidgets('AppBar drawer icon opens drawer', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MuscleExercisePage()));
      final drawerIconFinder = find.byIcon(Icons.menu);
      await tester.tap(drawerIconFinder);
      await tester.pumpAndSettle();
      expect(find.text('Menu'), findsOneWidget); // Replace with your expected drawer contents widget
    });

    testWidgets('AppBar icon theme is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(
              home: MuscleExercisePage()
          )
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      final iconTheme = appBar.iconTheme;
      expect(iconTheme?.color, Colors.black);
    });

    testWidgets('AppBar should return correct preferred size', (WidgetTester tester) async {
      const customAppBar = CustomAppBar();
      expect(customAppBar.preferredSize, const Size.fromHeight(80.0));
    });

    testWidgets('AppBar child should throw unimplemented error', (WidgetTester tester) async {
      const customAppBar =  CustomAppBar();
      expect(() => customAppBar.child, throwsUnimplementedError);
    });

  });
}
