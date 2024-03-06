import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'customAppBar.dart';

class ProfileEditor extends StatefulWidget {
  final String userId;
  final String name;
  final String gender;
  final String age;
  final String height;
  final String initialWeight;
  final String currentWeight;
  final String goalWeight;
  final String weeklyGoalWeight;
  final String activityLevel;

  const ProfileEditor({
    super.key,
    required this.userId,
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.initialWeight,
    required this.currentWeight,
    required this.goalWeight,
    required this.weeklyGoalWeight,
    required this.activityLevel,
  });

  @override
  _ProfileEditorState createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _initialWeightController;
  late TextEditingController _currentWeightController;
  late TextEditingController _goalWeightController;
  late TextEditingController _weeklyGoalWeightController;
  late TextEditingController _activityLevelController;

  get child => null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _heightController = TextEditingController(text: widget.height);
    _genderController = TextEditingController(text: widget.gender);
    _ageController = TextEditingController(text: widget.age);
    _initialWeightController =
        TextEditingController(text: widget.initialWeight);
    _currentWeightController =
        TextEditingController(text: widget.currentWeight);
    _goalWeightController = TextEditingController(text: widget.goalWeight);
    _weeklyGoalWeightController =
        TextEditingController(text: widget.weeklyGoalWeight);
    _activityLevelController =
        TextEditingController(text: widget.activityLevel);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _initialWeightController.dispose();
    _currentWeightController.dispose();
    _goalWeightController.dispose();
    _weeklyGoalWeightController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    usersCollection.doc(widget.userId).update({
      'name': _nameController.text,
      'gender': _genderController.text,
      'age': _ageController.text,
      'height': _heightController.text,
      'initialWeight': _initialWeightController.text,
      'currentWeight': _currentWeightController.text,
      'goalWeight': _goalWeightController.text,
      'weeklyGoalWeight': _weeklyGoalWeightController.text,
      'activityLevel': _activityLevelController.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile updated successfully!'),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to update profile.'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFFE2E2E2),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
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
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.person, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.transgender, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField<String>(
                        value: _genderController.text.isNotEmpty
                            ? _genderController.text
                            : 'Male',
                        decoration: const InputDecoration(
                          hintText: 'Select your gender',
                          border: InputBorder.none,
                        ),
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _genderController.text = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your age',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        maxLength: 3,
                        buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused,}) => Container(), // Remove the character count indicator
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.height, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your height',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.line_weight, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _initialWeightController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your initial weight',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.line_weight, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _currentWeightController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your current weight',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.flag_outlined, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _goalWeightController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your goal weight',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.trending_up_outlined, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _weeklyGoalWeightController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your weekly goal weight',
                          border: InputBorder.none,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*[,.]?\d*$')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(Icons.directions_run, size: 20),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField<String>(
                        value: _activityLevelController.text.isNotEmpty
                            ? _activityLevelController.text
                            : 'Sedentary',
                        decoration: const InputDecoration(
                          hintText: 'Select your activity level',
                          border: InputBorder.none,
                        ),
                        items: <String>[
                          'Sedentary',
                          'Lightly Active',
                          'Moderately Active',
                          'Very Active'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _activityLevelController.text = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade300,
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _updateProfile,
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
                          'Save changes',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
