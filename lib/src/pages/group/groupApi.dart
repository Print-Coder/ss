// To parse this JSON data, do
//
//     final groupData = groupDataFromMap(jsonString);

import 'dart:convert';

class GroupData {
  GroupData({
    this.maxVal,
    this.minVal,
    this.pincode,
    this.cashbackPercent,
    this.createdon,
  });

  final String pincode;

  final String cashbackPercent, minVal, maxVal;

  final DateTime createdon;

  factory GroupData.fromJson(String str) => GroupData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupData.fromMap(Map<String, dynamic> json) => GroupData(
        pincode: json["pincode"] == null ? null : json["pincode"],
        cashbackPercent: json["cashback_percent"] == null
            ? null
            : json["cashback_percent"].toString(),
        minVal: json["minVal"] == null ? null : json["minVal"].toString(),
        maxVal: json["maxVal"] == null ? null : json["maxVal"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "pincode": pincode == null ? null : pincode,
        "cashback_percent": cashbackPercent == null ? null : cashbackPercent,
      };
}
