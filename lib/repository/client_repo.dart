import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/datamodels/diet_model.dart';
import 'package:fitnessapp/datamodels/recommended_model.dart';
import 'package:fitnessapp/datamodels/user_model.dart';
import 'package:fitnessapp/datamodels/workout_model.dart';
import 'package:fitnessapp/repository/base_repo.dart';

class ClientRepository extends BaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  ClientRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<ChallengesModel>> getAllChallenges() {
    return _firebaseFirestore
        .collection("challenges")
        .where('popular', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChallengesModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<ChallengesModel>> getAllWorkOuts() {
    return _firebaseFirestore
        .collection("challenges")
        .where('popular', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChallengesModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<DietModel>> getAllDiets() {
    return _firebaseFirestore.collection("diets").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => DietModel.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<RecommendedModel>> getAllRecommended() {
    return _firebaseFirestore
        .collection("recommended")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => RecommendedModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<WorkoutModel>> getWorkoutData(String title) {
    return _firebaseFirestore
        .collection("challenges")
        .doc(title)
        .collection("data")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => WorkoutModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<UserModel> getUserData(email) {
    return _firebaseFirestore
        .collection("users")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).single;
    });
  }

  @override
  Future<void> addWorkoutQty(String email) async {
    CollectionReference s = _firebaseFirestore.collection("users");
    Query query = s.where("email", isEqualTo: email);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.update({
        'started': FieldValue.increment(1),
      });
    });
  }

  @override
  Future<void> addWorkoutSuccessQty(String email, int burnt) async {
    CollectionReference s = _firebaseFirestore.collection("users");
    Query query = s.where("email", isEqualTo: email);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.update({
        'completed': FieldValue.increment(1),
        'caloriesBurnt': burnt,
        'weightLoss': FieldValue.increment(1),
      });
    });
  }

  @override
  Future<void> addUserGoal(String email, String goal) async {
    CollectionReference s = _firebaseFirestore.collection("users");
    Query query = s.where("email", isEqualTo: email);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.update({'goal': goal});
    });
  }

  @override
  Future<void> resetAchievements(String email) async {
    CollectionReference s = _firebaseFirestore.collection("users");
    Query query = s.where("email", isEqualTo: email);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.update({
        'completed': 0,
        'caloriesBurnt': 0,
        'weightLoss': 0,
        'started': 0,
      });
    });
  }

  @override
  Future<void> singUpUser(String name, String email) {
    return _firebaseFirestore.collection("users").add({
      "fullName": name,
      "email": email,
      "caloriesBurnt": 0,
      "completed": 0,
      "started": 0,
      "weightLoss": 0,
      "goal": ""
    });
  }

  @override
  Stream<List<ChallengesModel>> getUserWorkOut(String title) {
    return _firebaseFirestore
        .collection("challenges")
        .where('type', isEqualTo: title)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChallengesModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<DietModel>> getUserDiet(String title) {
    return _firebaseFirestore
        .collection("diets")
        .where('type', isEqualTo: title)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => DietModel.fromSnapshot(doc)).toList();
    });
  }
}
