// ignore_for_file: depend_on_referenced_packages

import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  static const routeName = '/FAQ';

  const FAQPage({super.key});

  @override
  ExpandableQuestionsPageState createState() =>
      ExpandableQuestionsPageState();
}

class ExpandableQuestionsPageState extends State<FAQPage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("FAQ Page"),
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 12.0),
              child: Text(
                'Frequently Asked Questions (FAQ)',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            buildQuestion(0, 'What does this gym app do?',
                'This app shows you exercises categorized by muscle group, tracks your nutrition, calculates your estimated daily calorie needs, and allows you to create a favorite list for exercises.'),
            buildQuestion(1, 'How do I add an exercise to my favorite list?',
                'To add an exercise to your favorite list you simply click on the star corresponding to the exercise you want to add.'),
            buildQuestion(
                2,
                'Does the app have instructional images for exercises?',
                'Yes, the app has instructional images for exercises to help you perform them correctly and avoid injury.'),
            buildQuestion(3, 'How does the app track nutrition?',
                'The app has a feature where you can input the food you have eaten, and it will calculate the calories and nutritional information for you.'),
            buildQuestion(4, 'Can I edit my profile information?',
                'Yes, you can edit your profile information by navigating to the "Profile" tab and clicking the "Edit Profile" button. From there, you can update your personal information such as your age, height, weight, and fitness goals.'),
            buildQuestion(
                5,
                'How does the app calculate estimated daily calorie needs?',
                'The app takes into account your age, gender, weight, height, and activity level to calculate your estimated daily calorie needs.')
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(int index, String question, String answer) {
    bool isExpanded = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _selectedIndex = -1;
          } else {
            _selectedIndex = index;
          }
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Container(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 3.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18.0),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                firstChild: Container(),
                secondChild: Padding(
                  key: const Key("faq_answer"),
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    answer,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int get selectedIndex => _selectedIndex;
}
