import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenUserIsOnMusclesPageStep() {
  return given<FlutterWorld>('the user is on the muscle exercises page',
      (context) async {
    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    // Open the drawer

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final muscleExercises = find.byValueKey("Muscle_Exercises");
    await FlutterDriverUtils.tap(context.world.driver, muscleExercises);
  });
}

StepDefinitionGeneric WhenUserClicksOnMuscleStep() {
  return when1<String, FlutterWorld>('they select the {string}',
      (string, context) async {
    final scrollableFinder = find.byValueKey('scrollable');
    final muscleGroupFinder = find.text(string);

    await context.world.driver?.scrollUntilVisible(
      scrollableFinder,
      muscleGroupFinder,
      dyScroll: -100.0,
      timeout: const Duration(seconds: 5),
    );
    final locator = find.byValueKey(string);
    await FlutterDriverUtils.tap(context.world.driver, locator);
  });
}

StepDefinitionGeneric ThenOnlySpecificExercisesShowStep() {
  return then1<String, FlutterWorld>(
      'the exercise {string} group should appear', (string, context) async {
    final chestExercisesFinder = find.text(string);
    await FlutterDriverUtils.isPresent(
        context.world.driver, chestExercisesFinder);
    context.expect(await FlutterDriverUtils.isPresent(
        context.world.driver, chestExercisesFinder), true);
  });
}
