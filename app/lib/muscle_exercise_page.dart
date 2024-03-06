// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:fit_friend/DatabaseHelper.dart';
import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:fit_friend/exercise_list_screen.dart';
import 'package:fit_friend/fireStoreHelper.dart';
import 'package:flutter/material.dart';


class MuscleExercisePage extends StatefulWidget {
  static const routeName = '/muscleExercisePage';

  const MuscleExercisePage({Key? key}) : super(key: key);

  @override
  _MuscleExercisePageState createState() => _MuscleExercisePageState();
}

class _MuscleExercisePageState extends State<MuscleExercisePage> {
  final List<String> muscleExercises = [
    'Chest',
    'Back',
    'Legs',
    'Biceps',
    'Triceps',
    'Shoulders',
    'Abs'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              bottom: 3.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Text(
              'Exercises',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 0.0,
              bottom: 3.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Text(
              'What do you want to train today?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              key: const Key("scrollable"),
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 15.0,
              ),
              itemCount: muscleExercises.length,
              itemBuilder: (BuildContext context, int index) {
                final String muscleName = muscleExercises[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        key: Key(muscleName),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseListScreen(
                                muscleName: muscleName,
                                databaseHelper: DatabaseHelper.instance,
                                firestoreHelper: FireStoreHelper.instance,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 100.0,
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/${muscleName.toLowerCase()}.png',
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                const SizedBox(width: 16.0),
                                Text(
                                  muscleName,
                                  style: const TextStyle(fontSize: 24.0),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
