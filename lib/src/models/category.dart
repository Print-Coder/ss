// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/widgets.dart';

class Category {
  Category({
    this.category,
  });

  final String category;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        category: json["Category"] == null ? null : json["Category"],
      );

  Map<String, dynamic> toMap() => {
        "Category": category == null ? null : category,
      };
}

class HeaderJson  {
  HeaderJson({
    this.menuName,
    this.hrefUrl,
    this.menuType,
    this.subMenu1,
  });
  final String menuName;
  final String hrefUrl;
  final String menuType;
  final List<SubMenu1> subMenu1;

  factory HeaderJson.fromJson(String str) =>
      HeaderJson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HeaderJson.fromMap(Map<String, dynamic> json) => HeaderJson(
        menuName: json["menuName"] == null ? null : json["menuName"],
        hrefUrl: json["hrefUrl"] == null ? null : json["hrefUrl"],
        menuType: json["menuType"] == null ? null : json["menuType"],
        subMenu1: json["subMenu1"] == null
            ? null
            : List<SubMenu1>.from(
                json["subMenu1"].map((x) => SubMenu1.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "menuName": menuName == null ? null : menuName,
        "hrefUrl": hrefUrl == null ? null : hrefUrl,
        "menuType": menuType == null ? null : menuType,
        "subMenu1": subMenu1 == null
            ? null
            : List<dynamic>.from(subMenu1.map((x) => x.toMap())),
      };
}

class SubMenu1 {
  SubMenu1({
    this.subMenu1Name,
    this.hrefUrl,
  });

  final String subMenu1Name;
  final String hrefUrl;

  factory SubMenu1.fromJson(String str) => SubMenu1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubMenu1.fromMap(Map<String, dynamic> json) => SubMenu1(
        subMenu1Name:
            json["subMenu1Name"] == null ? null : json["subMenu1Name"],
        hrefUrl: json["hrefUrl"] == null ? null : json["hrefUrl"],
      );

  Map<String, dynamic> toMap() => {
        "subMenu1Name": subMenu1Name == null ? null : subMenu1Name,
        "hrefUrl": hrefUrl == null ? null : hrefUrl,
      };
}
