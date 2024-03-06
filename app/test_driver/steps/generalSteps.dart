import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenUserIsLoggedIn() {
  return given<FlutterWorld>('the user is logged-in', (context) async {
    final emailFinder = find.byValueKey("email_input");
    final passwordFinder = find.byValueKey("password_input");

    await FlutterDriverUtils.tap(context.world.driver, emailFinder);
    await context.world.driver?.enterText("up202005334@g.uporto.pt");

    await FlutterDriverUtils.tap(context.world.driver, passwordFinder);
    await context.world.driver?.enterText("lmao123");

    final loginFinder = find.byValueKey("login_button");
    await FlutterDriverUtils.tap(context.world.driver, loginFinder);
  });
}

StepDefinitionGeneric ThenRedirectsTo() {
  return then1<String, FlutterWorld>('they are redirected to the {string}',
      (key, context) async {
    final loginPageFinder = find.byValueKey(key);
    final loginTest = await FlutterDriverUtils.isPresent(context.world.driver, loginPageFinder);
    context.expect(loginTest,true);
  });
}
