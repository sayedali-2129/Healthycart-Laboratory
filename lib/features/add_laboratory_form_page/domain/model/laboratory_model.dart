import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:healthy_cart_laboratory/features/location_picker/domain/model/location_model.dart';

class LaboratoryModel {
  String? id;
  PlaceMark? placemark;
  String? phoneNo;
  String? laboratoryName;
  String? address;
  String? ownerName;
  String? uploadLicense;
  String? image;
  bool? isActive;
  Timestamp? createdAt;
  bool? isLabotaroryOn;
  int? requested;
  String? rejectionReason;
  List<String>? keywords;
  LaboratoryModel({
    this.id,
    this.placemark,
    this.phoneNo,
    this.laboratoryName,
    this.address,
    this.ownerName,
    this.uploadLicense,
    this.image,
    this.isActive,
    this.createdAt,
    this.isLabotaroryOn,
    this.requested,
    this.rejectionReason,
    this.keywords,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'placemark': placemark,
      'phoneNo': phoneNo,
      'laboratoryName': laboratoryName,
      'address': address,
      'ownerName': ownerName,
      'uploadLicense': uploadLicense,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt,
      'isLabotaroryOn': isLabotaroryOn,
      'requested': requested,
      'rejectionReason': rejectionReason,
      'keywords': keywords,
    };
  }

  Map<String, dynamic> toEditMap() {
    return {
      'lalaboratoryName': laboratoryName,
      'address': address,
      'ownerName': ownerName,
      'uploadLicense': uploadLicense,
      'image': image,
      'keywords': keywords,
    };
  }

  factory LaboratoryModel.fromMap(Map<String, dynamic> map) {
    return LaboratoryModel(
      id: map['id'] != null ? map['id'] as String : null,
      placemark: map['placemark'] != null
          ? PlaceMark.fromMap(map['placemark'] as Map<String, dynamic>)
          : null,
      phoneNo: map['phoneNo'] != null ? map['phoneNo'] as String : null,
      laboratoryName: map['laboratoryName'] != null
          ? map['laboratoryName'] as String
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      ownerName: map['ownerName'] != null ? map['ownerName'] as String : null,
      uploadLicense:
          map['uploadLicense'] != null ? map['uploadLicense'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as Timestamp : null,
      isLabotaroryOn:
          map['isLabotaroryOn'] != null ? map['isLabotaroryOn'] as bool : null,
      requested: map['requested'] != null ? map['requested'] as int : null,
      rejectionReason: map['rejectionReason'] != null
          ? map['rejectionReason'] as String
          : null,
      keywords: map['keywords'] != null
          ? List<String>.from((map['keywords'] as List<dynamic>))
          : null,
    );
  }

  LaboratoryModel copyWith({
    String? id,
    PlaceMark? placemark,
    String? phoneNo,
    String? laboratoryName,
    String? address,
    String? ownerName,
    String? uploadLicense,
    String? image,
    bool? isActive,
    Timestamp? createdAt,
    bool? isLabotaroryOn,
    int? requested,
    String? rejectionReason,
    List<String>? keywords,
  }) {
    return LaboratoryModel(
      id: id ?? this.id,
      placemark: placemark ?? this.placemark,
      phoneNo: phoneNo ?? this.phoneNo,
      laboratoryName: laboratoryName ?? this.laboratoryName,
      address: address ?? this.address,
      ownerName: ownerName ?? this.ownerName,
      uploadLicense: uploadLicense ?? this.uploadLicense,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      isLabotaroryOn: isLabotaroryOn ?? this.isLabotaroryOn,
      requested: requested ?? this.requested,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      keywords: keywords ?? this.keywords,
    );
  }
}
