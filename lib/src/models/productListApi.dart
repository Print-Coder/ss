// To parse this JSON data, do
//
//     final productListData = productListDataFromMap(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:ECom/src/models/category.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/productDetails/api/productDetailData.dart';
import 'package:flutter/widgets.dart';

class ProductListData extends ChangeNotifier {
  ProductListData({
    this.count,
    this.page,
    this.limit,
    this.pages,
  });

  final int count;
  List<Item> _items = [];
  int page;

  final int limit;
  final int pages;
  bool _stockStatus;
  bool get stockStatus => _stockStatus;
  ProductListData _productListData;
  ProductListData get productListData => _productListData;
  int _selectedMenu = 0, _selectedSubMenu = 0;
  int get selectedMenu => _selectedMenu;
  int get selectedSubMenu => _selectedSubMenu;
  List<HeaderJson> _categoryList = [];
  List<HeaderJson> get categoryList => _categoryList;
  bool _isSubCategory = false;
  bool get isSubCategory => _isSubCategory;
  setProductListData(Map<String, dynamic> json) {
    _productListData = ProductListData.fromMap(json);
    notifyListeners();
  }

  setStock(bool stockStatus) {
    _stockStatus = stockStatus;
    notifyListeners();
  }

  increasePage(int pageI) {
    _productListData.page = pageI;
    notifyListeners();
  }

  setMenu(int menuIndex) {
    _selectedMenu = menuIndex;
    _selectedSubMenu = -1;
    notifyListeners();
  }

  setSubMenu(int submenuIndex) {
    _selectedSubMenu = submenuIndex;
    notifyListeners();
  }

  setCategory(List<HeaderJson> catList) {
    _categoryList = catList;
    notifyListeners();
  }

  setData(List<Item> list, {bool isSubCat = false}) {
    _items = [];
    _items = list ?? [];
    _isSubCategory = isSubCat ?? false;
    notifyListeners();
  }

  addData(List<Item> list, {bool isSubCat = false}) {
    _items.addAll(list ?? []);
    _isSubCategory = isSubCat ?? false;
    notifyListeners();
  }

  setItemData(Item newItemData) {
    Item itemData = _items.firstWhere((e) => e.itemId == newItemData.itemId);
    _items[_items.indexOf(itemData)] = newItemData;
    notifyListeners();
  }

  setQuantity(Item item, int quantity) {
    int itemIndex = _items?.indexWhere((i) => i?.itemId == item?.itemId);

    _items[itemIndex]?.variant[_items[itemIndex].variantIndex].quantity =
        quantity;
    // _items[itemIndex]?.isCart = item.isCart;
    setPrice(itemIndex);
  }

  setvariant(Item item) {
    int itemIndex = _items?.indexWhere((i) => i?.itemId == item?.itemId);
    _items[itemIndex]?.variantIndex = item.variantIndex;
    _items[itemIndex]?.quantIndex = 0;
    // notifyListeners();
    setPrice(itemIndex);
  }

  setQuantIndex(Item item) {
    int itemIndex = _items?.indexWhere((i) => i?.itemId == item?.itemId);

    _items[itemIndex]?.quantIndex = item.quantIndex;
    // notifyListeners();

    setPrice(itemIndex);
  }

  setPrice(int itemIndex) {
    int variantQuantity = _items[itemIndex]
        ?.variant[_items[itemIndex]?.variantIndex]
        .prices[_items[itemIndex]?.quantIndex]
        .quantity;
    if (_items[itemIndex].isCart) {
      // if(item?.quantity>=variantQuantity)
      _items[itemIndex]?.payPrice = double.parse(
          (((_items[itemIndex]?.quantity > 0
                          ? _items[itemIndex]?.quantity
                          : 1) *
                      _items[itemIndex]
                          ?.variant[_items[itemIndex]?.variantIndex]
                          .prices[_items[itemIndex]?.quantIndex]
                          .price) /
                  variantQuantity)
              .toString());
    } else {
      _items[itemIndex]?.payPrice = double.parse((_items[itemIndex]
              ?.variant[_items[itemIndex]?.variantIndex]
              .prices[_items[itemIndex]?.quantIndex]
              .price)
          .toString());
    }
    // item?.payPrice =
    //     item.variant[item.variantIndex].prices[item.quantIndex].price;

    notifyListeners();
  }

  List<Item> get items => _items;
  factory ProductListData.fromJson(String str) =>
      ProductListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListData.fromMap(Map<String, dynamic> json) => ProductListData(
        count: json["count"] == null ? null : json["count"],
        page: json["page"] == null ? null : json["page"],
        limit: json["limit"] == null ? null : json["limit"],
        pages: json["pages"] == null ? null : json["pages"],
      );

  Map<String, dynamic> toMap() => {
        "count": count == null ? null : count,
        // "items": items == null
        //     ? null
        //     : List<dynamic>.from(items.map((x) => x.toMap())),
        "page": page == null ? null : page,
        "limit": limit == null ? null : limit,
        "pages": pages == null ? null : pages,
      };
}

class Item {
  Item(
      {this.id,
      this.itemId,
      this.availability,
      this.category,
      this.isnew,
      this.ispublished,
      this.istop,
      this.linker,
      this.name,
      this.pictures,
      this.payPrice,
      this.mrp,
      this.productType,
      this.bajajModelCode,
      this.variant,
      this.datecreated,
      this.linkerManufacturer,
      this.linkerCategory,
      this.variantIndex = 0,
      this.quantIndex = 0,
      this.isCart = false,
      this.quantity = 0,
      this.isactive,
      this.deliveryType,
      this.adminupdated,
      this.mainCategory,
      this.ssCommissionPercent,
      this.catOneId,
      this.catTwoId,
      this.colorRelated,
      this.relatedProducts,
      this.pageType,
      this.offerdesc,
      this.brand_desc,
      this.simpledesc,
      this.stockStatus,
      this.stock});
  bool stockStatus;
  final String offerdesc;
  final String brand_desc;
  final String simpledesc;
  final int stock;
  final bool isactive;
  final String deliveryType;
  final String adminupdated;
  final String mainCategory;
  final int ssCommissionPercent;
  final String linkerManufacturer;
  final String catOneId;
  final String catTwoId;
  final List<dynamic> colorRelated;
  final List<dynamic> relatedProducts;
  final String pageType;
  int quantity, variantIndex, quantIndex;
  bool isCart;
  final String id;
  final String itemId;
  final String availability;
  final String category;
  final bool isnew;
  final bool ispublished;
  final bool istop;
  final String linker;
  final String name;
  final List<String> pictures;
  double payPrice;
  double mrp;
  final String productType;
  final String bajajModelCode;
  final List<Variant> variant;
  final DateTime datecreated;
  final String linkerCategory;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["_id"] == null ? null : json["_id"],
        stockStatus: json["stockStatus"] == null ? null : json["stockStatus"],
        itemId: json["id"] == null ? null : json["id"],
        availability:
            json["availability"] == null ? null : json["availability"],
        category: json["category"] == null ? null : json["category"],
        isnew: json["isnew"] == null ? null : json["isnew"],
        ispublished: json["ispublished"] == null ? null : json["ispublished"],
        istop: json["istop"] == null ? null : json["istop"],
        linker: json["linker"] == null ? null : json["linker"],
        stock: json["stock"] == null ? null : json["stock"],
        name: json["name"] == null ? null : json["name"],
        pictures: json["pictures"] == null
            ? null
            : List<String>.from(json["pictures"].map((x) => x)),
        payPrice: json["payPrice"] == null
            ? null
            : double.parse(json["payPrice"].toString()),
        mrp: json["mrp"] == null ? null : double.parse(json["mrp"].toString()),
        productType: json["product_type"] == null ? null : json["product_type"],
        bajajModelCode:
            json["bajaj_model_code"] == null ? null : json["bajaj_model_code"],
        variant: json["variant"] == null
            ? null
            : List<Variant>.from(
                json["variant"].map((x) => Variant.fromMap(x))),
        datecreated: json["datecreated"] == null
            ? null
            : DateTime.parse(json["datecreated"]),
        linkerManufacturer: json["linker_manufacturer"] == null
            ? null
            : json["linker_manufacturer"],
        linkerCategory:
            json["linker_category"] == null ? null : json["linker_category"],
        offerdesc: json["offerdesc"] == null ? null : json["offerdesc"],
        brand_desc: json["brand_desc"] == null ? null : json["brand_desc"],
        simpledesc: json["simpledesc"] == null ? null : json["simpledesc"],
        isactive: json["isactive"] == null ? null : json["isactive"],
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        adminupdated:
            json["adminupdated"] == null ? null : json["adminupdated"],
        mainCategory:
            json["main_category"] == null ? null : json["main_category"],
        ssCommissionPercent: json["ss_commission_percent"] == null
            ? null
            : json["ss_commission_percent"],
        catOneId: json["cat_one_id"] == null ? null : json["cat_one_id"],
        catTwoId: json["cat_two_id"] == null ? null : json["cat_two_id"],
        colorRelated: json["ColorRelated"] == null
            ? null
            : List<dynamic>.from(json["ColorRelated"].map((x) => x)),
        relatedProducts: json["RelatedProducts"] == null
            ? null
            : List<dynamic>.from(json["RelatedProducts"].map((x) => x)),
        pageType: json["page_type"] == null ? null : json["page_type"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "id": itemId == null ? null : itemId,
        "availability": availability == null ? null : availability,
        "category": category == null ? null : category,
        "isnew": isnew == null ? null : isnew,
        "ispublished": ispublished == null ? null : ispublished,
        "istop": istop == null ? null : istop,
        "linker": linker == null ? null : linker,
        "name": name == null ? null : name,
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x)),
        "payPrice": payPrice == null ? null : payPrice,
        "mrp": mrp == null ? null : double.parse(mrp.toString()),
        "product_type": productType == null ? null : productType,
        "bajaj_model_code": bajajModelCode == null ? null : bajajModelCode,
        "variant": variant == null
            ? null
            : List<dynamic>.from(variant.map((x) => x.toMap())),
        "datecreated":
            datecreated == null ? null : datecreated.toIso8601String(),
        "linker_manufacturer":
            linkerManufacturer == null ? null : linkerManufacturer,
        "linker_category": linkerCategory == null ? null : linkerCategory,
      };
}

class Variant {
  Variant(
      {this.title,
      this.type,
      this.prices,
      this.id,
      this.baseprice,
      this.sastaPrice,
      this.mrp,
      this.quantity = 0,
      this.stock});
  int stock;
  final String title;
  final double sastaPrice;
  final String type;
  final List<Price> prices;
  final String id;
  int quantity;
  dynamic baseprice;
  double mrp;
  factory Variant.fromJson(String str) => Variant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variant.fromMap(Map<String, dynamic> json) => Variant(
        title: json["title"] == null ? null : json["title"],
        sastaPrice: json["sasta_price"] == null
            ? null
            : double.parse(json["sasta_price"].toString()),
        type: json["type"] == null ? null : json["type"],
        prices: json["prices"] == null || (json["prices"] ?? []).isEmpty
            ? null
            : List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        id: json["id"] == null ? null : json["id"],
        baseprice: json["base_price"] == null ? null : json["base_price"],
        quantity: json["quantity"] == null ? 0 : json["quantity"],
        stock: json["stock"] == null ? 0 : json["stock"],
        mrp: json["mrp"] == null ? 0 : double.parse(json["mrp"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "stock": stock == null ? null : stock,
        "prices": prices == null
            ? null
            : List<dynamic>.from(prices.map((x) => x.toMap())),
        "id": id == null ? null : id,
        "baseprice": baseprice,
      };
}

class Price {
  Price({
    this.quantity,
    this.price,
    this.percentage,
  });

  final dynamic quantity;
  final double price;
  final dynamic percentage;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        quantity: json["quantity"],
        price: double.parse(json["price"].toString()),
        percentage: json["percentage"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "price": price,
        "percentage": percentage,
      };
}
