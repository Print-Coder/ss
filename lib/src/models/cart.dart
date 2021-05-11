// To parse this JSON data, do
//
//     final Cart = CartFromMap(jsonString);

import 'dart:convert';

import 'package:ECom/src/models/productListApi.dart';

class Cart {
  Cart({
    this.productId,
    this.quantity,
    this.variantId,
    this.pincode,
    // this.cartItem
  });
  // Item cartItem;
  final String productId;
  final int quantity;
  final String variantId;
  final String pincode;

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        productId: json["productId"] == null ? null : json["productId"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        variantId: json["variantId"] == null ? null : json["variantId"],
        pincode: json["pincode"] == null ? null : json["pincode"],
      );

  Map<String, dynamic> toMap({
    productId,
    quantity,
    variantId,
    pincode,
  }) =>
      {
        "productId": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "variantId": variantId == null ? null : variantId,
        "pincode": pincode == null ? null : pincode,
      };
  Map<String, dynamic> toSastaMap({
    productId,
    quantity,
    variantId,
    pincode,
  price
  }) =>
      {"cart_type": "sasta",
         "price": price == null ? null : price,
        "productId": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "variantId": variantId == null ? null : variantId,
        "pincode": pincode == null ? null : pincode,
      };
}
