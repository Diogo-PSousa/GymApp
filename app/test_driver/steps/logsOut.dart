import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric WhenUserLogsOut() {
  return when1<String, FlutterWorld>('they press the {string} button',
      (key, context) async {
    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    // Open the drawer

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final logoutFinder = find.byValueKey(key);

    await FlutterDriverUtils.tap(context.world.driver, logoutFinder);
  });
}
