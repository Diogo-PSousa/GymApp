import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric WhenUserClicksFavoriteButton() {
  return when2<String, String, FlutterWorld>(
      'they click the {string} on the exercise {string}',
      (button, exercise, context) async {
    final exercisesFinder = find.byValueKey(exercise);

    final favoritesButtonFinder =
        find.descendant(of: exercisesFinder, matching: find.byValueKey(button));
    await FlutterDriverUtils.tap(context.world.driver, favoritesButtonFinder);
  });
}

StepDefinitionGeneric ThenExerciseBecomesFavorite() {
  return then2<String, String, FlutterWorld>(
      'the {string} should appear beneath the {string} in the Favorite Exercises page',
      (exercise, muscle, context) async {
    final pageBack = find.pageBack();
    await FlutterDriverUtils.tap(context.world.driver, pageBack);

    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final favoriteExercises = find.byValueKey("Favorite_Exercises");

    await FlutterDriverUtils.tap(context.world.driver, favoriteExercises);

    final muscleFinder = find.text(muscle);

    final scrollableFinder = find.byValueKey('scrollable');
    await context.world.driver?.scrollUntilVisible(
      scrollableFinder,
      muscleFinder,
      dyScroll: -100.0,
      timeout: const Duration(seconds: 5),
    );

    final exercisesFinder = find.text(exercise);
    await FlutterDriverUtils.isPresent(context.world.driver, muscleFinder);

    await FlutterDriverUtils.isPresent(context.world.driver, exercisesFinder);
  });
}
