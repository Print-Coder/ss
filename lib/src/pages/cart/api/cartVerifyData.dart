// To parse this JSON data, do
//
//     final cartVerify = cartVerifyFromMap(jsonString);

import 'dart:convert';

class CartVerify {
    CartVerify({
        this.statusCode,
        this.productName,
        this.pid,
        this.vid,
        this.variantName,
        this.message,
    });

    final String statusCode;
    final String productName;
    final String pid;
    final String vid;
    final String variantName;
    final String message;

    factory CartVerify.fromJson(String str) => CartVerify.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CartVerify.fromMap(Map<String, dynamic> json) => CartVerify(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        productName: json["productName"] == null ? null : json["productName"],
        pid: json["pid"] == null ? null : json["pid"],
        vid: json["vid"] == null ? null : json["vid"],
        variantName: json["variantName"] == null ? null : json["variantName"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toMap() => {
        "statusCode": statusCode == null ? null : statusCode,
        "productName": productName == null ? null : productName,
        "pid": pid == null ? null : pid,
        "vid": vid == null ? null : vid,
        "variantName": variantName == null ? null : variantName,
        "message": message == null ? null : message,
    };
}
