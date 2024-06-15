import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  String? id;
  String? labId;
  String? testName;
  String? testImage;
  num? testPrice;
  num? offerPrice;
  Timestamp? createdAt;
  bool? isDoorstepAvailable;
  bool? prescriptionNeeded;
  TestModel({
    this.id,
    this.labId,
    this.testName,
    this.testImage,
    this.testPrice,
    this.offerPrice,
    this.createdAt,
    this.isDoorstepAvailable,
    this.prescriptionNeeded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'labId': labId,
      'testName': testName,
      'testImage': testImage,
      'testPrice': testPrice,
      'offerPrice': offerPrice,
      'createdAt': createdAt,
      'isDoorstepAvailable': isDoorstepAvailable,
      'prescriptionNeeded': prescriptionNeeded,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id'] != null ? map['id'] as String : null,
      labId: map['labId'] != null ? map['labId'] as String : null,
      testName: map['testName'] != null ? map['testName'] as String : null,
      testImage: map['testImage'] != null ? map['testImage'] as String : null,
      testPrice: map['testPrice'] != null ? map['testPrice'] as num : null,
      offerPrice: map['offerPrice'] != null ? map['offerPrice'] as num : null,
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as Timestamp : null,
      isDoorstepAvailable: map['isDoorstepAvailable'] != null
          ? map['isDoorstepAvailable'] as bool
          : null,
      prescriptionNeeded: map['prescriptionNeeded'] != null
          ? map['prescriptionNeeded'] as bool
          : null,
    );
  }

  TestModel copyWith({
    String? id,
    String? labId,
    String? testName,
    String? testImage,
    num? testPrice,
    num? offerPrice,
    Timestamp? createdAt,
    bool? isDoorstepAvailable,
    bool? prescriptionNeeded,
  }) {
    return TestModel(
      id: id ?? this.id,
      labId: labId ?? this.labId,
      testName: testName ?? this.testName,
      testImage: testImage ?? this.testImage,
      testPrice: testPrice ?? this.testPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      createdAt: createdAt ?? this.createdAt,
      isDoorstepAvailable: isDoorstepAvailable ?? this.isDoorstepAvailable,
      prescriptionNeeded: prescriptionNeeded ?? this.prescriptionNeeded,
    );
  }
}
