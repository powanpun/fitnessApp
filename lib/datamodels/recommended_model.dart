import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RecommendedModel extends Equatable {
  final String title;
  final String image;

  const RecommendedModel({
    required this.title,
    required this.image,
  });

  @override
  List<Object?> get props => [title];

  static RecommendedModel fromSnapshot(DocumentSnapshot snap) {
    RecommendedModel categoryModel = RecommendedModel(
      title: snap['title'],
      image: snap['image'],
    );
    return categoryModel;
  }
}
