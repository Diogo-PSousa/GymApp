// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:fit_friend/DatabaseHelper.dart';
import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:fit_friend/fireStoreHelper.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favoritesScreen';

  const FavoritesScreen({super.key});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Exercise> _favoriteExercises = [];
  FireStoreHelper fireStoreHelper = FireStoreHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteExercises();
  }

  void _fetchFavoriteExercises() async {
    final favoriteExercises =
        await FireStoreHelper.instance.getFavoriteExercisesOnline();
    setState(() {
      _favoriteExercises = favoriteExercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedExercises =
        groupBy(_favoriteExercises, (Exercise e) => e.muscle_name);

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: groupedExercises.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: groupedExercises.entries
                    .map((entry) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 0.0,
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              key: const Key("Favorites list"),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16.0),
                              itemCount: entry.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Exercise exercise = entry.value[index];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 120.0,
                                        padding: const EdgeInsets.all(20.0),
                                        child: LayoutBuilder(
                                          builder: (BuildContext context,
                                              BoxConstraints constraints) {
                                            final double maxWidth =
                                                constraints.maxWidth;
                                            final double imageWidth = maxWidth *
                                                0.25; // 25% of available width
                                            final double imageHeight = constraints
                                                .maxHeight; // maintain aspect ratio 2:3
                                            return Row(
                                              key: Key(exercise.name),
                                              children: [
                                                Image.asset(
                                                  'assets/images/${exercise.muscle_name}/${exercise.id}.png',
                                                  height: imageHeight,
                                                  width: imageWidth,
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: Text(
                                                    exercise.name,
                                                    style: const TextStyle(
                                                        fontSize: 24.0),
                                                  ),
                                                ),
                                                IconButton(
                                                  key: const Key(
                                                      "Favorite button"),
                                                  icon: const Icon(Icons.star,
                                                      color: Color(0xFFFFC300)),
                                                  onPressed: () async {
                                                    final shouldRemove =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          Dialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Text(
                                                                'Warning',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              const Text(
                                                                'Remove exercise from favorites?',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 30),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  ElevatedButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            false),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(7.5),
                                                                      ),
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            30,
                                                                        vertical:
                                                                            15,
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[300],
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    key: const Key(
                                                                        "Remove button"),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            true),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red[400],
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            30,
                                                                        vertical:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Remove',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                    if (shouldRemove) {
                                                      await fireStoreHelper
                                                          .removeFavoriteExerciseOnline(
                                                              exercise.id);
                                                      setState(() {
                                                        _favoriteExercises
                                                            .remove(exercise);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20.0,
                                          right: 24.0,
                                          left: 24.0,
                                        ),
                                        child: Text(
                                          exercise.description,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ))
                    .toList(),
              ),
            )
          : const Center(
              child: Text("You don't have any favorite exercises yet!"),
            ),
    );
  }
}
