import 'dart:async';
import 'package:gherkin/gherkin.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/addFavoriteExercise.dart';
import 'steps/addFood.dart';
import 'steps/removeFavoriteExercise.dart';
import 'steps/checkFAQpage.dart';
import 'steps/clickOnMuscle.dart';
import 'steps/generalSteps.dart';
import 'steps/loginSteps.dart';
import 'steps/logsOut.dart';
import 'steps/zeroFavoriteExercise.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..targetAppPath = 'test_driver/app.dart'
    ..features = [Glob('test_driver/features/**.feature')]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
    ..order = ExecutionOrder.alphabetical
    ..stepDefinitions = [
      GivenUserIsLoggedIn(),
      ThenRedirectsTo(),

      WhenUserLogsOut(),

      GivenUserEntersEmail(),
      GivenUserEntersPassword(),
      WhenUserLogsIn(),

      ThenShowsLogInWarning(),

      WhenUserGoesToFaq(),
      AndTheUserAnswersTheirQuestion(),

      GivenUserIsOnMusclesPageStep(),
      WhenUserClicksOnMuscleStep(),
      ThenOnlySpecificExercisesShowStep(),

      WhenUserClicksFavoriteButton(),
      ThenExerciseBecomesFavorite(),

      GivenUserGoesToFavorites(),
      WhenClicksOnRemove(),
      ThenExerciseDisappears(),

      WhenUserHasNoFavorites(),
      ThenNoFavTextAppears(),


      GivenUserIsOnNutritionPage(),
      WhenUserClicksOnMeal(),
      WhenUserAddsFood(),
      ThenCaloriesUpdate()
    ];

  return GherkinRunner().execute(config);
}
