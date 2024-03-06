import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenUserIsOnNutritionPage() {
  return given<FlutterWorld>('the user is on the nutrition page',
      (context) async {
    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    // Open the drawer

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final nutritionPage = find.byValueKey("Nutrition page");
    await FlutterDriverUtils.tap(context.world.driver, nutritionPage);
  });
}

StepDefinitionGeneric WhenUserClicksOnMeal() {
  return when1<String, FlutterWorld>(
      'they click add in the {string} section',
      (meal, context) async {

    await FlutterDriverUtils.tap(context.world.driver, find.byValueKey(meal));
  });
}

StepDefinitionGeneric WhenUserAddsFood() {
  return when2<String, String, FlutterWorld>(
      'they search for the food {string} and add {string} grams of it',
      (food, quantity, context) async {
    final searchFinder = find.byValueKey("search food");

    await FlutterDriverUtils.enterText(
        context.world.driver, searchFinder, food);

    await FlutterDriverUtils.tap(
        context.world.driver, find.byValueKey("choose food"));

    await FlutterDriverUtils.enterText(
        context.world.driver, find.byValueKey("enter food quantity"), quantity);

    await FlutterDriverUtils.tap(
        context.world.driver, find.byValueKey("Ok button"));
  });
}

StepDefinitionGeneric ThenCaloriesUpdate() {
  return then1<String, FlutterWorld>('the total calories should be {string}',
      (calories, context) async {
    final textFinder = find.text('Total Calories: $calories');
    final test = await FlutterDriverUtils.isPresent(context.world.driver, textFinder, timeout: const Duration(milliseconds: 500));
    context.expect(test, true);

  });
}
