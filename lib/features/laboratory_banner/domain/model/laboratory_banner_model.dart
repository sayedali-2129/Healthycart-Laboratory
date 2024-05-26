import 'package:cloud_firestore/cloud_firestore.dart';

class LaboratoryBannerModel {
  String? id;
  final String? image;
  final Timestamp? isCreated;
  final String hospitalId;
  LaboratoryBannerModel({
    this.id,
    this.image,
    this.isCreated,
    required this.hospitalId,
  });

  LaboratoryBannerModel copyWith({
    String? id,
    String? image,
    Timestamp? isCreated,
    String? hospitalId,
  }) {
    return LaboratoryBannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      isCreated: isCreated ?? this.isCreated,
      hospitalId: hospitalId ?? this.hospitalId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'isCreated': isCreated,
      'hospitalId': hospitalId,
    };
  }

  factory LaboratoryBannerModel.fromMap(Map<String, dynamic> map) {
    return LaboratoryBannerModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      isCreated:
          map['isCreated'] != null ? map['isCreated'] as Timestamp : null,
      hospitalId: map['hospitalId'] as String,
    );
  }
}
