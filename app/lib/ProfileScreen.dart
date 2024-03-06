import 'package:fit_friend/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_friend/ProfileEditor.dart';
import 'package:fit_friend/Nutrition_page.dart';
import 'customAppBar.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _userId;
  late String _name = '';
  late String _gender = '';
  late String _age = '';
  late String _height = '';
  late String _email = '';
  late String _initialWeight = '';
  late String _currentWeight = '';
  late String _goalWeight = '';
  late String _weeklyGoalWeight = '';
  late String _activityLevel = '';
  double _calculatedCalories = 0.0;



  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }


  Future<void> _getCurrentUser() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      setState(() {
        _userId = user.uid;
        _email = user.email!;
      });

      await _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(_userId).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _name = userData['name'] ?? '';
          _gender = userData['gender'] ?? '';
          _age = userData['age'] ?? '';
          _height = userData['height'] ?? '';
          _initialWeight = userData['initialWeight'] ?? '';
          _currentWeight = userData['currentWeight'] ?? '';
          _goalWeight = userData['goalWeight'] ?? '';
          _weeklyGoalWeight = userData['weeklyGoalWeight'] ?? '';
          _activityLevel = userData['activityLevel'] ?? '';
        });

        _calculateCalories(); // Recalculate calories after fetching user data
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _calculateCalories() {
    double bmr = 0;
    double activityvar = 0;

    try {
      if (_activityLevel == 'Sedentary')
        activityvar = 1.2;
      else if (_activityLevel == 'Lightly Active')
        activityvar = 1.375;
      else if (_activityLevel == 'Moderate')
        activityvar = 1.55;
      else if (_activityLevel == 'Very Active') activityvar = 1.725;

      double currentWeight =
          double.tryParse(_currentWeight.replaceAll(',', '.')) ?? 0.0;
      double height = double.tryParse(_height.replaceAll(',', '.')) ?? 0.0;
      double age = double.tryParse(_age.replaceAll(',', '.')) ?? 0.0;
      double weeklyGoalWeight =
          double.tryParse(_weeklyGoalWeight.replaceAll(',', '.')) ?? 0.0;

      if (_gender == 'Male') {
        bmr = 88.362 +
            (13.397 * currentWeight) +
            (4.799 * height) -
            (5.677 * age);
      } else {
        bmr = 447.593 +
            (9.247 * currentWeight) +
            (3.098 * height) -
            (4.330 * age);
      }

      double calories = bmr * activityvar;
      double weightGoalCalories = weeklyGoalWeight * 7700 / 7;
      _calculatedCalories = calories + weightGoalCalories;

      setState(() {});
    } catch (e) {
      print('Error calculating calories: $e');
      _calculatedCalories = 0.0; // Assign a default value
    }
  }


  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileEditor(
          userId: _userId,
          name: _name,
          gender: _gender,
          age: _age,
          height: _height,
          initialWeight: _initialWeight,
          currentWeight: _currentWeight,
          goalWeight: _goalWeight,
          weeklyGoalWeight: _weeklyGoalWeight,
          activityLevel: _activityLevel,
        ),
      ),
    ).then((_) {
      // Refresh user data after editing
      _fetchUserData();
      _calculateCalories(); // Recalculate calories after editing
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFE2E2E2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 10.0, // Add a non-zero value for the bottom margin
                  left: 15.0,
                  right: 15.0,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Profile Details',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              ProfileListItem(
                icon: Icons.person,
                text: 'Name: $_name',
              ),
              ProfileListItem(
                icon: Icons.email,
                text: 'Email: $_email',
              ),
              ProfileListItem(
                icon: Icons.transgender,
                text: 'Gender: $_gender',
              ),
              ProfileListItem(
                icon: Icons.calendar_today,
                text: 'Age (years): $_age',
              ),
              ProfileListItem(
                icon: Icons.height,
                text: 'Height (cm): $_height',
              ),
              ProfileListItem(
                icon: Icons.line_weight,
                text: 'Initial Weight (kg): $_initialWeight',
              ),
              ProfileListItem(
                icon: Icons.line_weight_outlined,
                text: 'Current Weight (kg): $_currentWeight',
              ),
              ProfileListItem(
                icon: Icons.flag_outlined,
                text: 'Goal Weight (kg): $_goalWeight',
              ),
              ProfileListItem(
                icon: Icons.trending_up_outlined,
                text: 'Weekly Goal Weight (kg): $_weeklyGoalWeight',
              ),
              ProfileListItem(
                icon: Icons.directions_run,
                text: 'Activity Level: $_activityLevel',
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10)
                    .copyWith(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300,
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _editProfile,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFF54242),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Display calculated calories
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Center(
                  child: Text(
                    'Daily Calories: ${_calculatedCalories.toInt()} kcal',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 25,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
    );
  }

  final kTitleTextStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
}


