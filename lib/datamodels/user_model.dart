import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int caloriesBurnt;
  final int weightLoss;
  final int started;
  final int completed;
  final String email;
  final String fullName;
  final String goal;

  const UserModel({
    required this.caloriesBurnt,
    required this.weightLoss,
    required this.started,
    required this.completed,
    required this.email,
    required this.fullName,
    required this.goal,
  });

  @override
  List<Object?> get props => [email, fullName];

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    UserModel userModel = UserModel(
      caloriesBurnt: snap['caloriesBurnt'],
      weightLoss: snap['weightLoss'],
      started: snap['started'],
      completed: snap['completed'],
      email: snap['email'],
      fullName: snap['fullName'],
      goal: snap['goal'],
    );
    return userModel;
  }
}
