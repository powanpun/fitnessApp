import 'dart:ffi';

import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/datamodels/diet_model.dart';
import 'package:fitnessapp/datamodels/recommended_model.dart';
import 'package:fitnessapp/datamodels/user_model.dart';
import 'package:fitnessapp/datamodels/workout_model.dart';

abstract class BaseRepository {
  Stream<List<ChallengesModel>> getAllChallenges();
  Stream<List<ChallengesModel>> getAllWorkOuts();
  Stream<List<DietModel>> getAllDiets();
  Stream<List<RecommendedModel>> getAllRecommended();
  Stream<List<WorkoutModel>> getWorkoutData(String title);
  Stream<UserModel> getUserData(String email);
  Future<void> addWorkoutQty(String email);
  Future<void> resetAchievements(String email);
  Future<void> addWorkoutSuccessQty(String email, int calories);
  Future<void> singUpUser(String name, String email);
  Future<void> addUserGoal(String email, String goal);
  Stream<List<ChallengesModel>> getUserWorkOut(String title);
  Stream<List<DietModel>> getUserDiet(String title);
}
