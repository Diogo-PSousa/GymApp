import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenUserEntersEmail() {
  return given1<String, FlutterWorld>('the user enters their email {string}',
      (email, context) async {
    final emailFinder = find.byValueKey("email_input");

    await FlutterDriverUtils.tap(context.world.driver, emailFinder);
    await context.world.driver?.enterText(email);
  });
}

StepDefinitionGeneric GivenUserEntersPassword() {
  return given1<String, FlutterWorld>('they enter their password {string}',
      (password, context) async {
    final passwordInput = find.byValueKey("password_input");

    await FlutterDriverUtils.tap(context.world.driver, passwordInput);
    await context.world.driver?.enterText(password);
  });
}

StepDefinitionGeneric WhenUserLogsIn() {
  return when1<String, FlutterWorld>('they press the {string}',
      (key, context) async {
    final loginFinder = find.byValueKey(key);
    await FlutterDriverUtils.tap(context.world.driver, loginFinder);
  });
}

StepDefinitionGeneric ThenShowsLogInWarning() {
  return then1<String, FlutterWorld>('they are shown the text {string}',
      (key, context) async {
    final snackBarfinder = find.byValueKey(key);
    final textFinder = find.text(key);
    context.expect(await FlutterDriverUtils.isPresent(context.world.driver, snackBarfinder), true);
    context.expect(await FlutterDriverUtils.isPresent(context.world.driver, textFinder), true);


  });
}
