import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric WhenUserGoesToFaq() {
  return when<FlutterWorld>('they click the FAQ tab', (context) async {
    final SerializableFinder locateDrawer =
        find.byTooltip('Open navigation menu');

    // Open the drawer

    await FlutterDriverUtils.tap(context.world.driver, locateDrawer);
    final faqPage = find.byValueKey("FAQ_page");
    await FlutterDriverUtils.tap(context.world.driver, faqPage);
  });
}

StepDefinitionGeneric AndTheUserAnswersTheirQuestion() {
  return then1<String, FlutterWorld>(
      'they can get the answer to their question: {string}',
      (string, context) async {
    final questionFinder = find.text(string);
    await FlutterDriverUtils.isPresent(context.world.driver, questionFinder);

    await FlutterDriverUtils.tap(context.world.driver, questionFinder);

    await FlutterDriverUtils.isPresent(
        context.world.driver, find.byValueKey("faq_answer"));

    context.expect(await FlutterDriverUtils.isPresent(
        context.world.driver, find.byValueKey("faq_answer")), true);
  });

}
