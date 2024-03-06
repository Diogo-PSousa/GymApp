import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric WhenUserHasNoFavorites() {
  return when1<String, FlutterWorld>(
      'the user has not added any favorite exercises to his {string}',
          (list, context) async {
        final favListFinder = find.byValueKey(list);
        FlutterDriverUtils.isAbsent(context.world.driver, favListFinder);
      });
}

StepDefinitionGeneric ThenNoFavTextAppears() {
  return then1<String, FlutterWorld>(
      "the page should say {string}",
          (text, context) async {
        final textFinder = find.text(text);
        context.expect(await FlutterDriverUtils.isPresent(context.world.driver, textFinder), true);
      });
}

