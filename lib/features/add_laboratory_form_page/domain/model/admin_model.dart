// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:healthy_cart_laboratory/features/location_picker/domain/model/location_model.dart';

import 'package:healthy_cart_laboratory/utils/constants/enums.dart';

class Admin {
  Admin({
    this.adminType,
    this.phoneNo,
    this.id,
    this.placemark,
  });

  final AdminType? adminType;
  final String? phoneNo;
  String? id;
  PlaceMark? placemark;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminType': adminType?.name,
      'phoneNo': phoneNo,
      'id': id,
      'placemark': placemark?.toJson(),
    };
  }

  // Map<String, dynamic> toEditMap() {
  //   return <String, dynamic>{
  //     'phoneNo': phoneNo,
  //   };
  // }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      adminType: getAdminType(map['adminType']),
      phoneNo: map['phoneNo'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      placemark: map['placemark'] != null
          ? PlaceMark.fromMap(map['placemark'] as Map<String, dynamic>)
          : null,
    );
  }

  static AdminType getAdminType(String value) {
    switch (value) {
      case 'pharmacy':
        return AdminType.pharmacy;
      case 'labortory':
        return AdminType.laboratory;
      case 'hospital':
      default:
        return AdminType.hospital;
    }
  }
}
