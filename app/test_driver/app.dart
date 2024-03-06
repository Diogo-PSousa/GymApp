import 'package:flutter_driver/driver_extension.dart';
import 'package:fit_friend/main.dart' as real;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  enableFlutterDriverExtension();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false);
  real.main();
}