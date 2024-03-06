import 'package:fit_friend/FAQ_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("FAQ Page tests", () {
    testWidgets('FAQPage should build without throwing any exceptions',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FAQPage()));
      expect(tester.takeException(), isNull);
    });

    testWidgets('FAQPage should display all questions',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FAQPage()));
      expect(find.byType(AnimatedCrossFade), findsNWidgets(6));
    });

    testWidgets('FAQPage should correct title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FAQPage()));
      final titleFinder = find.text('Frequently Asked Questions (FAQ)');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('All questions present', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: FAQPage()));

      final firstQuestion = find.text('What does this gym app do?');
      expect(firstQuestion, findsOneWidget);

      final firstAnswer = find.text(
          'This app shows you exercises categorized by muscle group, tracks your nutrition, calculates your estimated daily calorie needs, and allows you to create a favorite list for exercises.');
      expect(firstAnswer, findsOneWidget);

      final secondQuestion =
          find.text('How do I add an exercise to my favorite list?');
      expect(secondQuestion, findsOneWidget);
      await tester.tap(secondQuestion);
      await tester.pumpAndSettle();

      final secondAnswer = find.text(
          'To add an exercise to your favorite list you simply click on the star corresponding to the exercise you want to add.');
      expect(secondAnswer, findsOneWidget);

      final thirdQuestion =
          find.text('Does the app have instructional images for exercises?');
      expect(thirdQuestion, findsOneWidget);
      await tester.tap(thirdQuestion);
      await tester.pumpAndSettle();

      final thirdAnswer = find.text(
          'Yes, the app has instructional images for exercises to help you perform them correctly and avoid injury.');

      expect(thirdAnswer, findsOneWidget);

      final fourthQuestion = find.text('How does the app track nutrition?');
      expect(fourthQuestion, findsOneWidget);
      await tester.tap(fourthQuestion);
      await tester.pumpAndSettle();

      final fourthAnswer = find.text(
          'The app has a feature where you can input the food you have eaten, and it will calculate the calories and nutritional information for you.');

      expect(fourthAnswer, findsOneWidget);

      final fifthQuestion = find.text('Can I edit my profile information?');
      expect(fifthQuestion, findsOneWidget);
      await tester.tap(fifthQuestion);
      await tester.pumpAndSettle();

      final fifthAnswer = find.text(
          'Yes, you can edit your profile information by navigating to the "Profile" tab and clicking the "Edit Profile" button. From there, you can update your personal information such as your age, height, weight, and fitness goals.');

      expect(fifthAnswer, findsOneWidget);

      final sixthQuestion = find
          .text('How does the app calculate estimated daily calorie needs?');
      expect(sixthQuestion, findsOneWidget);
      await tester.tap(sixthQuestion);
      await tester.pumpAndSettle();

      final sixthAnswer = find.text(
          'The app takes into account your age, gender, weight, height, and activity level to calculate your estimated daily calorie needs.');

      expect(sixthAnswer, findsOneWidget);
    });

    testWidgets('buildQuestion displays question and answer',
        (WidgetTester tester) async {
      // Define the parameters to be used in the test
      const int index = 0;
      const String question = 'What is the capital of France?';
      const String answer = 'The capital of France is Paris.';

      // Create an instance of the class/mixin that defines the buildQuestion method
      final Builder widgetBuilder = Builder(
        builder: (BuildContext context) {
          return ExpandableQuestionsPageState()
              .buildQuestion(index, question, answer);
        },
      );

      // Pump the widget tree and wait for it to settle
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widgetBuilder)));
      await tester.pumpAndSettle();

      // Verify that the question and answer are displayed
      expect(find.text(question), findsOneWidget);
      expect(find.text(answer), findsOneWidget);

      //Verify that there's a question card
      final cardFind = tester.widget<Card>(find.byType(Card));
      expect(find.byType(Card), findsOneWidget);

      //Verify shape of card
      expect(cardFind.shape,
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)));
      expect(cardFind.margin,
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0));

      //Verify existence of container
      final containerFind =
          tester.widget<Container>(find.byType(Container).at(1));
      expect(
          containerFind.padding,
          const EdgeInsets.only(
            top: 16.0,
            bottom: 3.0,
            left: 16.0,
            right: 16.0,
          ));

      //Verify existence of column
      final columnFinder = find.descendant(
          of: find.byType(Container), matching: find.byType(Column));
      expect(columnFinder, findsOneWidget);

      //Check crossAxisAlignment of column
      expect(tester.widget<Column>(columnFinder).crossAxisAlignment,
          CrossAxisAlignment.start);

      //Verify existence of SizedBox
      final sizedBoxFinder =
          find.descendant(of: columnFinder, matching: find.byType(SizedBox));
      expect(sizedBoxFinder, findsOneWidget);

      //Check height of SizedBox
      expect(tester.widget<SizedBox>(sizedBoxFinder).height, 18.0);
    });

    testWidgets('buildQuestion onTap sets state', (WidgetTester tester) async {
      // Define the parameters to be used in the test
      const int index = 1;
      const String question = 'How do I add an exercise to my favorite list?';
      const String answer =
          'To add an exercise to your favorite list you simply click on the star corresponding to the exercise you want to add.';
      // Create a setup method that will initialize the state
      await tester.pumpWidget(const MaterialApp(home: FAQPage()));
      await tester.pumpAndSettle();
      final faqPageElement = find.byType(FAQPage).first;

      // Obtain a reference to the widget instance
      final state = tester.state<ExpandableQuestionsPageState>(faqPageElement);

      // Verify that the initial state is as expected
      expect(state.selectedIndex, -1);

      expect(find.text(question), findsOneWidget);
      expect(
          find.ancestor(
              of: find.text(question), matching: find.byType(GestureDetector)),
          findsOneWidget);
      // Tap the question to expand it
      await tester.tap(find.ancestor(
          of: find.text(question), matching: find.byType(GestureDetector)));
      await tester.pumpAndSettle();

      // Verify that the state was updated correctly
      expect(state.selectedIndex, index);

      // Tap the question again to collapse it
      await tester.tap(find.text(question));
      await tester.pumpAndSettle();

      // Verify that the state was updated correctly
      expect(state.selectedIndex, -1);
    });
  });
}
