import 'package:cloud_firestore/cloud_firestore.dart';

class TransferTransactionsModel {
  String? transactionId;
  Timestamp? dateAndTime;
  num? transferAmount;
  num? commission;
  String? formattedDate;
  List<String>? keywords;
  TransferTransactionsModel({
    this.transactionId,
    this.dateAndTime,
    this.transferAmount,
    this.commission,
    this.formattedDate,
    this.keywords,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'dateAndTime': dateAndTime,
      'transferAmount': transferAmount,
      'commission': commission,
      'formattedDate': formattedDate,
      'keywords': keywords,
    };
  }

  factory TransferTransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransferTransactionsModel(
      transactionId:
          map['transactionId'] != null ? map['transactionId'] as String : null,
      dateAndTime:
          map['dateAndTime'] != null ? map['dateAndTime'] as Timestamp : null,
      transferAmount:
          map['transferAmount'] != null ? map['transferAmount'] as num : null,
      commission: map['commission'] != null ? map['commission'] as num : null,
      formattedDate:
          map['formattedDate'] != null ? map['formattedDate'] as String : null,
      keywords: map['keywords'] != null
          ? List<String>.from(map['keywords'] as List<dynamic>)
          : null,
    );
  }

  TransferTransactionsModel copyWith({
    String? transactionId,
    Timestamp? dateAndTime,
    num? transferAmount,
    num? commission,
    String? formattedDate,
    List<String>? keywords,
  }) {
    return TransferTransactionsModel(
      transactionId: transactionId ?? this.transactionId,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      transferAmount: transferAmount ?? this.transferAmount,
      commission: commission ?? this.commission,
      formattedDate: formattedDate ?? this.formattedDate,
      keywords: keywords ?? this.keywords,
    );
  }
}
