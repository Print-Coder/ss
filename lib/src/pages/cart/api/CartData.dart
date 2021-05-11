// To parse this JSON data, do
//
//     final cartData = cartDataFromMap(jsonString);

import 'dart:convert';
import 'package:flutter/widgets.dart';

import '../../../models/productListApi.dart';

class CartData extends ChangeNotifier {
  CartData(
      {this.id,
      this.products,
      this.dataId,
      this.datecreated,
      this.dateupdated,
      this.paymentType,
      // this.status,
      this.subTotal,
      this.coupon,
      this.discount,
      this.totalPrice,
      this.totalQuantity,
      this.totalMrp,
      this.totalShippingPrice,
      this.isCouponApplied,
      this.walletAmount,
      this.ssTotalPrice,
      this.totalSaving,
      this.iswallet});

  final String id;
  List<Product> products;
  final String dataId;
  final DateTime datecreated;
  final DateTime dateupdated;
  final String paymentType;
  // final String status;
  String coupon;
  final double discount;
  final double totalPrice;
  final int totalQuantity;
  final double totalMrp;
  final double totalSaving;
  final double totalShippingPrice;
  // "coupon": "",
  // "discount": null,
  double walletAmount;
  double ssTotalPrice;
  double subTotal;
  bool iswallet;
  bool isCouponApplied;

  CartData _currentCart;
  CartData get currentCart => _currentCart;
  setCartData(Map json) {
    // print("bbbbbbbbbbbbbbbbbbbbbbbb${json["products"].length>0?json["products"][0]["variant"]:0}");
    _currentCart = CartData.fromMap(json ?? {});
    notifyListeners();
  }

  factory CartData.fromJson(String str) => CartData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartData.fromMap(Map<dynamic, dynamic> json) => CartData(
        id: json["_id"] == null ? null : json["_id"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
        dataId: json["id"] == null ? null : json["id"],
        datecreated: json["datecreated"] == null
            ? null
            : DateTime.parse(json["datecreated"]),
        dateupdated: json["dateupdated"] == null
            ? null
            : DateTime.parse(json["dateupdated"]),
        paymentType: json["payment_type"] == null ? null : json["payment_type"],
        // status: json["status"] == null ? null : json["status"],
        coupon: json["coupon"] == null ? null : json["coupon"],
        discount: json["discount"] == null
            ? null
            : double.parse(json["discount"].toString()),
        totalPrice: json["totalPrice"] == null
            ? null
            : double.parse(json["totalPrice"].toString()),
        subTotal: json["SubTotal"] == null
            ? null
            : double.parse(json["SubTotal"].toString()),
        totalSaving: json["totalSavings"] == null
            ? null
            : double.parse(json["totalSavings"].toString()),
        ssTotalPrice: json["ssTotalPrice"] == null
            ? null
            : double.parse(json["ssTotalPrice"].toString()),
        totalQuantity:
            json["TotalQuantity"] == null ? null : json["TotalQuantity"],
        totalMrp: json["totalMrp"] == null
            ? null
            : double.parse(json["totalMrp"].toString()),
        totalShippingPrice: json["totalShippingPrice"] == null
            ? null
            : double.parse(json["totalShippingPrice"].toString()),
        iswallet: json["is_wallet"] == null ? false : json["is_wallet"],
        isCouponApplied: json["is_coupon_applied"] == null
            ? false
            : json["is_coupon_applied"],
        walletAmount: json["wallet_amount"] == null
            ? null
            : double.parse(json["wallet_amount"].toString()),
//  "totalShippingPrice": 0,
//         "internalShippingPrice": 0,
//         "ssMinOrderShippingPrice": 0,
//         "ssTotalPrice": 140,
//         "totalMrp": 175
        //      "totalPrice": 165,
        // "TotalQuantity": 4,
        // "totalMrp": 155,
        // "totalShippingPrice": 10
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toMap())),
        "id": dataId == null ? null : dataId,
        "datecreated":
            datecreated == null ? null : datecreated.toIso8601String(),
        "dateupdated":
            dateupdated == null ? null : dateupdated.toIso8601String(),
        "payment_type": paymentType == null ? null : paymentType,
        // "status": status == null ? null : status,
        "coupon": coupon == null ? null : coupon,
        "discount": discount,
        "ssTotalPrice": totalPrice == null ? null : totalPrice,
        "TotalQuantity": totalQuantity == null ? null : totalQuantity,
        "totalMrp": totalMrp == null ? null : totalMrp,
        "totalShippingPrice":
            totalShippingPrice == null ? null : totalShippingPrice,
        "is_wallet": iswallet == null ? false : iswallet,
        "is_coupon_applied": isCouponApplied == null ? false : isCouponApplied,
      };
}

class Product {
  Product({
    this.id,
    this.linker,
    this.productId,
    this.offerdesc,
    this.name,
    this.pictures,
    this.shippingPrice,
    this.pinelabsproductCode,
    this.ispickup,
    this.iscod,
    this.bajajModelCode,
    this.variant,
    this.deliveryType,
    this.quantity,
    this.variantId,
    this.cartId,
    this.price,
    this.mrp,
  });

  final String id;
  final String linker;
  final String productId;
  final String offerdesc;
  final String name;
  final List<String> pictures;
  final int shippingPrice;
  final String pinelabsproductCode;
  final bool ispickup;
  final bool iscod;
  final String bajajModelCode;
  final Variant variant;
  final String deliveryType;
  int quantity;
  final String variantId;
  final String cartId;
  final double price;
  final double mrp;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) {
    print('bbbbbbbbbbbb${json["variant"]}');

    return Product(
      id: json["_id"] == null ? null : json["_id"],
      linker: json["linker"] == null ? null : json["linker"],
      productId: json["id"] == null ? null : json["id"],
      offerdesc: json["offerdesc"] == null ? null : json["offerdesc"],
      name: json["name"] == null ? null : json["name"],
      pictures: json["pictures"] == null
          ? null
          : List<String>.from(json["pictures"].map((x) => x)),
      shippingPrice:
          json["shippingPrice"] == null ? null : json["shippingPrice"],
      pinelabsproductCode: json["PinelabsproductCode"] == null
          ? null
          : json["PinelabsproductCode"],
      ispickup: json["ispickup"] == null ? null : json["ispickup"],
      iscod: json["iscod"] == null ? null : json["iscod"],
      bajajModelCode:
          json["bajaj_model_code"] == null ? null : json["bajaj_model_code"],
      variant:
          json["variant"] == null ? null : Variant.fromMap(json["variant"]),
      deliveryType:
          json["delivery_type"] == null ? null : json["delivery_type"],
      quantity: json["quantity"] == null ? null : json["quantity"],
      variantId: json["variantId"] == null ? null : json["variantId"],
      cartId: json["cartId"] == null ? null : json["cartId"],
      price:
          json["price"] == null ? null : double.parse(json["price"].toString()),
      mrp: json["mrp"] == null ? null : double.parse(json["mrp"].toString()),
    );
  }

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "id": productId == null ? null : productId,
        "offerdesc": offerdesc == null ? null : offerdesc,
        "name": name == null ? null : name,
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x)),
        "shippingPrice": shippingPrice == null ? null : shippingPrice,
        "PinelabsproductCode":
            pinelabsproductCode == null ? null : pinelabsproductCode,
        "ispickup": ispickup == null ? null : ispickup,
        "iscod": iscod == null ? null : iscod,
        "bajaj_model_code": bajajModelCode == null ? null : bajajModelCode,
        "variant": variant == null ? null : variant,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "quantity": quantity == null ? null : quantity,
        "variantId": variantId == null ? null : variantId,
        "cartId": cartId == null ? null : cartId,
        "price": price == null ? null : price,
        "mrp": mrp == null ? null : mrp,
      };
}

enum Type { UNIT, UNITS, EMPTY }

final typeValues =
    EnumValues({"": Type.EMPTY, "Unit": Type.UNIT, "Units": Type.UNITS});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
// To parse this JSON data, do
//
//     final noRushData = noRushDataFromMap(jsonString);



class Regular {
    Regular({
        this.daysOfSkip,
        this.deliveryHours,
        this.sundayDelivery,
    });

    final String daysOfSkip;
    final String deliveryHours;
    final bool sundayDelivery;

    factory Regular.fromJson(String str) => Regular.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Regular.fromMap(Map<String, dynamic> json) => Regular(
        daysOfSkip: json["days_of_skip"] == null ? null : json["days_of_skip"],
        deliveryHours: json["delivery_hours"] == null ? null : json["delivery_hours"],
        sundayDelivery: json["sunday_delivery"] == null ? null : json["sunday_delivery"],
    );

    Map<String, dynamic> toMap() => {
        "days_of_skip": daysOfSkip == null ? null : daysOfSkip,
        "delivery_hours": deliveryHours == null ? null : deliveryHours,
        "sunday_delivery": sundayDelivery == null ? null : sundayDelivery,
    };
}


class NoRushData {
  NoRushData({
    this.deliveryDay,
    this.deliveryHours,
    this.sundayDelivery,
    this.cashbackPercent,
  });

  final String deliveryDay;
  final String deliveryHours;
  final bool sundayDelivery;
  final String cashbackPercent;

  factory NoRushData.fromJson(String str) =>
      NoRushData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NoRushData.fromMap(Map<String, dynamic> json) => NoRushData(
        deliveryDay: json["delivery_day"] == null ? null : json["delivery_day"],
        deliveryHours:
            json["delivery_hours"] == null ? null : json["delivery_hours"],
        sundayDelivery:
            json["sunday_delivery"] == null ? null : json["sunday_delivery"],
        cashbackPercent: json["cashback_percent"] == null
            ? null
            : json["cashback_percent"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "delivery_day": deliveryDay == null ? null : deliveryDay,
        "delivery_hours": deliveryHours == null ? null : deliveryHours,
        "sunday_delivery": sundayDelivery == null ? null : sundayDelivery,
        "cashback_percent": cashbackPercent == null ? null : cashbackPercent,
      };
}
