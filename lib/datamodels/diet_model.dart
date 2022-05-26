import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DietModel extends Equatable {
  final String type;
  final String image;
  final String title;

  const DietModel({
    required this.type,
    required this.image,
    required this.title,
  });

  @override
  List<Object?> get props => [type];

  static DietModel fromSnapshot(DocumentSnapshot snap) {
    DietModel categoryModel = DietModel(
      type: snap['type'],
      image: snap['image'],
      title: snap['title'],
    );
    return categoryModel;
  }
}
