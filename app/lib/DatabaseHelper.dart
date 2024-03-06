// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Exercise {
  final int id;
  final String name;
  final String description;
  final String muscle_name;

  Exercise(
      {required this.id,
      required this.name,
      required this.description,
      required this.muscle_name});

  factory Exercise.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Exercise(
      id: data['exerciseId'] as int,
      name: data['exerciseName'] as String,
      description: data['exerciseDescription'] as String,
      muscle_name: data['muscleName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'muscle_name': muscle_name,
    };
  }

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, description: $description, muscle_name: $muscle_name}';
  }
}

class DatabaseHelper {
  static const _databaseName = "exercises.db";
  static const _databaseVersion = 5;

  static const table = 'exercises';
  static const favoritesTable = 'favorites';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDescription = 'description';
  static const columnMuscleName = 'muscle_name';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDescription TEXT, $columnMuscleName TEXT)',
      );
      await db.execute(
        'CREATE TABLE $favoritesTable($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnDescription TEXT, $columnMuscleName TEXT)',
      );
    });
  }

  Future<void> removeDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    await deleteDatabase(path);
  }

  Future<int> insertExercise(Exercise exercise) async {
    final db = await instance.database;
    return await db.insert(
      table,
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addFavoriteExercise(Exercise exercise) async {
    final db = await instance.database;
    return await db.insert(
      favoritesTable,
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeFavoriteExercise(int exerciseId) async {
    final db = await instance.database;
    return await db.delete(favoritesTable,
        where: 'Id = ?', whereArgs: [exerciseId]);
  }

  Future<bool> getFavoriteExerciseById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      favoritesTable,
      where: "id = ?",
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<List<Exercise>> getFavoriteExercises() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(favoritesTable);
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i][columnId],
        name: maps[i][columnName],
        description: maps[i][columnDescription],
        muscle_name: maps[i][columnMuscleName],
      );
    });
  }

  Future<List<Exercise>> getAllExercises() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i][columnId],
        name: maps[i][columnName],
        description: maps[i][columnDescription],
        muscle_name: maps[i][columnMuscleName],
      );
    });
  }

  Future<List<Map<String, Object?>>> getExercisesByMuscle(
      String muscleName) async {
    Database db;
    try {
      db = await instance.database;
      print('Database opened successfully!');
    } catch (e) {
      print('Error opening database: $e');
      return [];
    }
    final result = await db.query(
      'exercises',
      where: 'muscle_name = ?',
      whereArgs: [muscleName],
    );
    return result;
  }

  Future<void> deleteData() async {
    final db = await database;
    await db.delete(table);
  }

  Future<void> insertSampleData() async {
    await insertExercise(Exercise(
        id: 11,
        name: 'Bench-Press',
        description:
            'Lay flat on your back and press weights away from your chest',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 12,
        name: 'Incline Bench Press',
        description:
            'Lay on a bench with an incline and press weights away from your chest',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 13,
        name: 'Dumbbell Flyes',
        description:
            'Bring weights down to your sides, then up and in front of your chest',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 14,
        name: 'Chest Dips',
        description:
            'Lower and raise your body between parallel bars while leaning forward',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 15,
        name: 'Cable Crossovers',
        description:
            'Pull cable handles across your chest while standing in a staggered stance',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 16,
        name: 'Pec Deck Flyes',
        description:
            'Sit in a machine with padded arms and bring them together in front of your chest',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 17,
        name: 'Push-Up Variations',
        description:
            'Perform push-ups with variations such as wide grip, close grip, or single arm',
        muscle_name: 'Chest'));
    await insertExercise(Exercise(
        id: 18,
        name: 'Chest Press Machine',
        description: 'Sit in a machine and press weights away from your chest',
        muscle_name: 'Chest'));

    await insertExercise(Exercise(
        id: 21,
        name: 'Lat Pulldowns',
        description:
            'Sit at a cable machine and pull the bar down towards your chest',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 22,
        name: 'Bent-Over Rows',
        description:
            'Bend over and pull weights towards your chest with your arms',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 23,
        name: 'Single-Arm DB Rows',
        description: 'Hold a weight in one hand and pull it towards your chest',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 24,
        name: 'T-Bar Rows',
        description:
            'Stand with a barbell between your legs and pull it towards your chest',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 25,
        name: 'Seated Cable Rows',
        description:
            'Sit at a cable machine and pull the handles towards your chest while seated',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 26,
        name: 'Pull-Ups',
        description:
            'Hold a pull-up bar with your arms and pull your body up, until your chin passes the bar. Optionally, you can use resistance bands to aid the movement',
        muscle_name: 'Back'));
    await insertExercise(Exercise(
        id: 27,
        name: 'Barbell Shrugs',
        description:
            'Hold a barbell with weights and shrug your shoulders up towards your ears',
        muscle_name: 'Back'));

    await insertExercise(Exercise(
        id: 31,
        name: 'Squats with Barbell',
        description:
            'Lower your body down while holding a barbell on your shoulders',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 32,
        name: 'Deadlift',
        description: 'Load the barbell and, with proper form, pick the weight up',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 33,
        name: 'Leg Press Machine',
        description: 'Sit in a machine and press weights away from your legs',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 34,
        name: 'Lunges with Dumbbells',
        description:
            'Step forward and lower your body down while holding dumbbells',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 35,
        name: 'Leg Extensions',
        description: 'Sit in a machine and lift weights with your legs',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 36,
        name: 'Calf Raises',
        description: 'Lift weights with your calves. Go all the way down, and all the way up',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 37,
        name: 'Step-Ups with Dumbbells',
        description: 'Step up onto a platform while holdinzg dumbbells',
        muscle_name: 'Legs'));
    await insertExercise(Exercise(
        id: 38,
        name: 'Leg curl',
        description:
            'Sit, stand, or lie, on the machine and curl your legs, lifting the weight',
        muscle_name: 'Legs'));

    await insertExercise(Exercise(
        id: 41,
        name: 'Dumbbell Curl',
        description:
            'Curl dumbbells towards your shoulders with palms facing up',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 42,
        name: 'Barbell Curl',
        description: 'Curl barbell towards your shoulders with palms facing up',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 43,
        name: 'Hammer Curl',
        description:
            'Curl dumbbells towards your shoulders with palms facing each other',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 44,
        name: 'Curl Machine',
        description:
            'Sit on the machine and curl the weight up',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 45,
        name: 'Preacher Curl',
        description: 'Curl barbell while resting your arms on a bench',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 46,
        name: 'Cable Curl',
        description:
            'Hold on to the handle, or bar, and curl your arm up',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 47,
        name: 'Spider Curl',
        description:
            'Rest your chest on an incline bench and curl the weight up infront of you',
        muscle_name: 'Biceps'));
    await insertExercise(Exercise(
        id: 48,
        name: '21s',
        description:
            'Perform partial reps of a curl in three different ranges of motion, doing 7 reps in each range.',
        muscle_name: 'Biceps'));

    await insertExercise(Exercise(
        id: 51,
        name: 'Triceps Pushdowns',
        description: 'Attach a rope to a high pulley and push it down',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 52,
        name: 'Triceps Dips',
        description:
            'Lower your body down by bending your elbows, then push back up',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 53,
        name: 'Close-Grip Bench Press',
        description:
            'Lay flat on a bench and press weights up with hands close together',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 54,
        name: 'Triceps Press Machine',
        description:
            'Hold the handles with each hand and push the weight down, extending the arm',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 55,
        name: 'Overhead Extensions',
        description:
            'Hold a weight above your head with both hands, then lower it behind your head (with 1 or both hands)',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 56,
        name: 'Triceps Rope Extensions',
        description:
            'Attach a rope to a low pulley and extend your arms straight down',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 57,
        name: 'Skullcrushers',
        description:
            'Lay flat on a bench and lower weights towards your forehead, then extend arms back up',
        muscle_name: 'Triceps'));
    await insertExercise(Exercise(
        id: 58,
        name: 'Diamond Push-Ups',
        description:
            'Place hands close together in a diamond shape and do push-ups',
        muscle_name: 'Triceps'));

    await insertExercise(Exercise(
        id: 61,
        name: 'Shoulder Press',
        description: 'Press weights above your head while sitting or standing (dumbbells or barbell)',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 62,
        name: 'Upright Row',
        description:
            'Pull weights up towards your chin until your elbows are at shoulder level, while standing up straight (dumbbells or barbell)',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 63,
        name: 'Lateral Raise',
        description: 'Lift weights to the side with straight arms (dumbbells or cables)',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 64,
        name: 'Reverse Flyes with DB',
        description:
            'Bend forward and lift weights to the side with straight arms',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 65,
        name: 'Shoulder Press Machine',
        description: 'Sit in a machine and press weights above your head',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 66,
        name: 'Front Raise',
        description: 'Lift weights in front of you with straight arms (dumbbells or barbell)',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 67,
        name: 'Arnold Press with DB',
        description:
            'Press weights up above your head while rotating your arms',
        muscle_name: 'Shoulders'));
    await insertExercise(Exercise(
        id: 68,
        name: 'Face Pulls',
        description: 'Attach a rope to the cable machine and pull it towards your face while standing',
        muscle_name: 'Shoulders'));

    await insertExercise(Exercise(
        id: 71,
        name: 'Crunches',
        description:
            'Lay on your back, bring your knees up, and crunch your upper body towards your knees',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 72,
        name: 'Russian Twists',
        description:
            'Sit on the ground, hold a weight, and twist your torso side to side',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 73,
        name: 'Plank',
        description:
            'Hold a straight body position off the ground, with your forearms and toes on the ground',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 74,
        name: 'Bicycle Crunches',
        description:
            'Lay on your back, bring your knees up, and touch your elbow to the opposite knee while extending the other leg',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 75,
        name: 'Leg Raises',
        description:
            'Lay on your back, keep your legs straight, and lift them up towards the ceiling',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 76,
        name: 'Side Plank',
        description:
            'Hold a straight body position off the ground, with your forearms and toes on the ground',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 77,
        name: 'Sit-Ups',
        description:
            'Lay on your back, bring your upper body towards your knees while keeping your feet on the ground',
        muscle_name: 'Abs'));
    await insertExercise(Exercise(
        id: 78,
        name: 'Mountain Climbers',
        description:
            'Start in a plank position and bring one knee towards your chest, alternating legs quickly',
        muscle_name: 'Abs'));
  }
}
