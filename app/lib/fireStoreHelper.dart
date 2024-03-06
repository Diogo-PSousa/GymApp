import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_friend/DatabaseHelper.dart';

class FireStoreHelper {
  // singleton instance
  static final FireStoreHelper instance = FireStoreHelper._privateConstructor();

  // private constructor
  FireStoreHelper._privateConstructor();

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestore collection name for users
  final String _usersCollection = 'users';
  final String _favoritesCollection = 'favoriteExercises';

  // method to check if user exists in Firestore and add if not
  Future<void> checkAndAddUser() async {
    final authUser = FirebaseAuth.instance.currentUser;
    // check if user exists in Firestore
    final DocumentSnapshot userDoc =
        await _firestore.collection(_usersCollection).doc(authUser!.uid).get();
    if (!userDoc.exists) {
      // user does not exist, add new user doc
      await _firestore.collection(_usersCollection).doc(authUser.uid).set({
        'id': authUser.uid,
        'email': authUser.email
        // add more fields if needed
      });
      // Create a new subcollection for favorite exercises
    }
  }

  Future<void> addFavoriteExerciseOnline(int exerciseId, String exerciseName,
      String exerciseDescription, String exerciseMuscleName) async {
    final authUser = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection(_usersCollection)
        .doc(authUser!.uid)
        .collection(_favoritesCollection)
        .doc(exerciseId.toString())
        .set({
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'exerciseDescription': exerciseDescription,
      'muscleName': exerciseMuscleName
    });
  }

  Future<void> removeFavoriteExerciseOnline(int exerciseId) async {
    final authUser = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection(_usersCollection)
        .doc(authUser!.uid)
        .collection(_favoritesCollection)
        .doc(exerciseId.toString())
        .delete();
  }

  Future<bool> getFavoriteExerciseByIdOnline(int exerciseId) async {
    final authUser = FirebaseAuth.instance.currentUser;
    final documentReference = _firestore
        .collection(_usersCollection)
        .doc(authUser!.uid)
        .collection(_favoritesCollection)
        .doc(exerciseId.toString());
    final snapshot = await documentReference.get();
    return snapshot.exists;
  }

  Future<List<Exercise>> getFavoriteExercisesOnline() async {
    final authUser = FirebaseAuth.instance.currentUser;
    final documentReference = _firestore
        .collection(_usersCollection)
        .doc(authUser!.uid)
        .collection(_favoritesCollection);
    final snapshot = await documentReference.get();
    final exerciseList =
        snapshot.docs.map((doc) => Exercise.fromFirestore(doc)).toList();
    return exerciseList;
  }

  Future<bool> getUserByIdOnline() async {
    final authUser = FirebaseAuth.instance.currentUser;
    final documentReference =
        _firestore.collection(_usersCollection).doc(authUser!.uid);
    final snapshot = await documentReference.get();
    return snapshot.exists;
  }
}
