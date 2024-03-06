import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenUserGoesToFavorites() {
  return given<FlutterWorld>('the user is on the favorites exercises page',
      (context) async {
    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    // Open the drawer

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final favPage = find.byValueKey("Favorite_Exercises");
    await FlutterDriverUtils.tap(context.world.driver, favPage);
  });
}

StepDefinitionGeneric WhenClicksOnRemove() {
  return when1<String, FlutterWorld>(
      'they click on the {string} from the warning',
      (button, context) async {
    final removeButtonFinder = find.byValueKey(button);
    await FlutterDriverUtils.tap(context.world.driver, removeButtonFinder);
  });
}

StepDefinitionGeneric ThenExerciseDisappears() {
  return then1<String, FlutterWorld>(
      'the exercise {string} disappears from the favorites page',
          (exercise, context) async {

        final exercisesFinder = find.text(exercise);

        context.expect(await FlutterDriverUtils.isAbsent(context.world.driver, exercisesFinder), true);

      });
}
