import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/fireStoreHelper.dart';
import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';

class ExerciseListScreen extends StatefulWidget {
  static const routeName = '/exerciseListScreen';

  final String muscleName;
  final DatabaseHelper databaseHelper;
  final FireStoreHelper firestoreHelper;

  const ExerciseListScreen({
    super.key,
    required this.muscleName,
    required this.databaseHelper,
    required this.firestoreHelper,
  });

  @override
  _ExerciseListScreenState createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  List<Map<String, dynamic>> exerciseList = [];
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  void _fetchExercises() async {
    final exercises =
        await widget.databaseHelper.getExercisesByMuscle(widget.muscleName);
    setState(() {
      exerciseList = exercises.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      body: exerciseList != null
          ? _buildMusclesList()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _buildMusclesList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 0.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Align(
              key: Key(widget.muscleName),
              alignment: Alignment.topLeft,
              child: Text(
                widget.muscleName,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: exerciseList.length,
            itemBuilder: (BuildContext context, int index) {
              final String exerciseName = exerciseList[index]['name'];
              final int exerciseId = exerciseList[index]['id'];
              final String exerciseDescription =
                  exerciseList[index]['description'];
              final bool isExpanded = _expandedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedIndex = _expandedIndex == index ? -1 : index;
                  });
                },
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        //side: BorderSide(color: Color(0xFFF54242), width:2.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            key: Key(exerciseName),
                            height: 120.0,
                            padding: const EdgeInsets.all(20.0),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                final double maxWidth = constraints.maxWidth;
                                final double imageWidth =
                                    maxWidth * 0.25; // 25% of available width
                                final double imageHeight = constraints
                                    .maxHeight; // maintain aspect ratio 2:3
                                return Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/${widget.muscleName}/${exerciseId.toString()}.png',
                                      height: imageHeight,
                                      width: imageWidth,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Text(
                                        exerciseName,
                                        style: const TextStyle(fontSize: 24.0),
                                      ),
                                    ),
                                    IconButton(
                                      key: const Key("Favorite button"),
                                      icon: FutureBuilder<bool>(
                                        future: FireStoreHelper.instance
                                            .getFavoriteExerciseByIdOnline(
                                                exerciseId),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!) {
                                            return const Icon(Icons.star,
                                                color: Color(0xFFFFC300));
                                          } else {
                                            return const Icon(
                                                Icons.star_border);
                                          }
                                        },
                                      ),
                                      onPressed: () async {
                                        final isFavorite = await FireStoreHelper
                                            .instance
                                            .getFavoriteExerciseByIdOnline(
                                                exerciseId);
                                        if (isFavorite) {
                                          // Remove the exercise from the favoriteExercises collection
                                          await FireStoreHelper.instance
                                              .removeFavoriteExerciseOnline(
                                                  exerciseId);
                                        } else {
                                          // Add the exercise to the favoriteExercises collection
                                          await FireStoreHelper.instance
                                              .addFavoriteExerciseOnline(
                                                  exerciseId,
                                                  exerciseName,
                                                  exerciseDescription,
                                                  widget.muscleName);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, right: 24.0, left: 24.0),
                              child: Text(
                                exerciseDescription,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6.0), // space between the containers
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
