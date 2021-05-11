// To parse this JSON data, do
//
//     final productDetailData = productDetailDataFromMap(jsonString);

import 'dart:convert';
import '../../../models/productListApi.dart';

class ProductDetailData {
  ProductDetailData(
      {this.id,
      this.productDetailDataId,
      this.availability,
      this.body,
      this.bodywidgets,
      this.category,
      this.offerdesc,
      this.isnew,
      this.ispublished,
      this.istop,
      this.linker,
      this.name,
      this.pictures,
      this.payPrice,
      this.shippingPrice,
      this.pricemin,
      this.pricemax,
      this.priceold,
      this.mrp,
      this.brand_desc,
      this.simpledesc,
      this.productType,
      this.apXitemCode,
      this.pinelabsproductCode,
      this.liveproductObjHtml,
      this.searchAdminName,
      this.weight,
      this.hits,
      this.deleteLog,
      this.searchkeywords,
      this.ispickup,
      this.iscod,
      this.stockSyncDate,
      this.bajajModelCode,
      this.variant,
      this.datecreated,
      this.admincreated,
      this.dateupdated,
      this.linkerManufacturer,
      this.linkerCategory,
      this.search,
      this.isactive,
      this.colorRelated,
      this.relatedProducts,
      this.pageType,
      this.stockStatus,
      this.quantity = 0});
  int quantity;
  bool stockStatus;
  final String id;
  final String productDetailDataId;
  final String availability;
  final String body;
  final List<dynamic> bodywidgets;
  final String category;
  final String offerdesc;
  final String brand_desc;
  final String simpledesc;
  final bool isnew;
  final bool ispublished;
  final bool istop;
  final String linker;
  final String name;
  final List<String> pictures;
  final int payPrice;
  final int shippingPrice;
  final int pricemin;
  final int pricemax;
  final int priceold;
  final int mrp;
  final String productType;
  final String apXitemCode;
  final String pinelabsproductCode;
  final String liveproductObjHtml;
  final String searchAdminName;
  final int weight;
  final int hits;
  final String deleteLog;
  final List<String> searchkeywords;
  final bool ispickup;
  final bool iscod;
  final dynamic stockSyncDate;
  final String bajajModelCode;
  final List<Variant> variant;
  final DateTime datecreated;
  final String admincreated;
  final DateTime dateupdated;
  final String linkerManufacturer;
  final String linkerCategory;
  final String search;
  final bool isactive;
  final List<dynamic> colorRelated;
  final List<dynamic> relatedProducts;
  final String pageType;

  factory ProductDetailData.fromJson(String str) =>
      ProductDetailData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailData.fromMap(Map<String, dynamic> json) =>
      ProductDetailData(
        stockStatus: json["stockStatus"] == null ? true : json["stockStatus"],
        id: json["_id"] == null ? null : json["_id"],
        productDetailDataId: json["id"] == null ? null : json["id"],
        availability:
            json["availability"] == null ? null : json["availability"],
        body: json["body"] == null ? null : json["body"],
        bodywidgets: json["bodywidgets"] == null
            ? null
            : List<dynamic>.from(json["bodywidgets"].map((x) => x)),
        category: json["category"] == null ? null : json["category"],
        offerdesc: json["offerdesc"] == null ? null : json["offerdesc"],
        brand_desc: json["brand_desc"] == null ? null : json["brand_desc"],
        simpledesc: json["simpledesc"] == null ? null : json["simpledesc"],
        isnew: json["isnew"] == null ? null : json["isnew"],
        ispublished: json["ispublished"] == null ? null : json["ispublished"],
        istop: json["istop"] == null ? null : json["istop"],
        linker: json["linker"] == null ? null : json["linker"],
        name: json["name"] == null ? null : json["name"],
        pictures: json["pictures"] == null
            ? null
            : List<String>.from(json["pictures"].map((x) => x)),
        payPrice: json["payPrice"] == null ? null : json["payPrice"],
        shippingPrice:
            json["shippingPrice"] == null ? null : json["shippingPrice"],
        pricemin: json["pricemin"] == null ? null : json["pricemin"],
        pricemax: json["pricemax"] == null ? null : json["pricemax"],
        priceold: json["priceold"] == null ? null : json["priceold"],
        mrp: json["mrp"] == null ? null : json["mrp"],
        productType: json["product_type"] == null ? null : json["product_type"],
        apXitemCode: json["APXitemCode"] == null ? null : json["APXitemCode"],
        pinelabsproductCode: json["PinelabsproductCode"] == null
            ? null
            : json["PinelabsproductCode"],
        liveproductObjHtml: json["liveproductObj_html"] == null
            ? null
            : json["liveproductObj_html"],
        searchAdminName: json["search_admin_name"] == null
            ? null
            : json["search_admin_name"],
        weight: json["weight"] == null ? null : json["weight"],
        hits: json["hits"] == null ? null : json["hits"],
        deleteLog: json["delete_log"] == null ? null : json["delete_log"],
        searchkeywords: json["searchkeywords"] == null
            ? null
            : List<String>.from(json["searchkeywords"].map((x) => x)),
        ispickup: json["ispickup"] == null ? null : json["ispickup"],
        iscod: json["iscod"] == null ? null : json["iscod"],
        stockSyncDate: json["stock_sync_date"],
        bajajModelCode:
            json["bajaj_model_code"] == null ? null : json["bajaj_model_code"],
        variant: json["variant"] == null
            ? null
            : List<Variant>.from(
                json["variant"].map((x) => Variant.fromMap(x))),
        datecreated: json["datecreated"] == null
            ? null
            : DateTime.parse(json["datecreated"]),
        admincreated:
            json["admincreated"] == null ? null : json["admincreated"],
        dateupdated: json["dateupdated"] == null
            ? null
            : DateTime.parse(json["dateupdated"]),
        linkerManufacturer: json["linker_manufacturer"] == null
            ? null
            : json["linker_manufacturer"],
        linkerCategory:
            json["linker_category"] == null ? null : json["linker_category"],
        search: json["search"] == null ? null : json["search"],
        isactive: json["isactive"] == null ? null : json["isactive"],
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
        "id": productDetailDataId == null ? null : productDetailDataId,
        "availability": availability == null ? null : availability,
        "body": body == null ? null : body,
        "bodywidgets": bodywidgets == null
            ? null
            : List<dynamic>.from(bodywidgets.map((x) => x)),
        "category": category == null ? null : category,
        "offerdesc": offerdesc == null ? null : offerdesc,
        "isnew": isnew == null ? null : isnew,
        "ispublished": ispublished == null ? null : ispublished,
        "istop": istop == null ? null : istop,
        "linker": linker == null ? null : linker,
        "name": name == null ? null : name,
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x)),
        "payPrice": payPrice == null ? null : payPrice,
        "shippingPrice": shippingPrice == null ? null : shippingPrice,
        "pricemin": pricemin == null ? null : pricemin,
        "pricemax": pricemax == null ? null : pricemax,
        "priceold": priceold == null ? null : priceold,
        "mrp": mrp == null ? null : mrp,
        "product_type": productType == null ? null : productType,
        "APXitemCode": apXitemCode == null ? null : apXitemCode,
        "PinelabsproductCode":
            pinelabsproductCode == null ? null : pinelabsproductCode,
        "liveproductObj_html":
            liveproductObjHtml == null ? null : liveproductObjHtml,
        "search_admin_name": searchAdminName == null ? null : searchAdminName,
        "weight": weight == null ? null : weight,
        "hits": hits == null ? null : hits,
        "delete_log": deleteLog == null ? null : deleteLog,
        "searchkeywords": searchkeywords == null
            ? null
            : List<dynamic>.from(searchkeywords.map((x) => x)),
        "ispickup": ispickup == null ? null : ispickup,
        "iscod": iscod == null ? null : iscod,
        "stock_sync_date": stockSyncDate,
        "bajaj_model_code": bajajModelCode == null ? null : bajajModelCode,
        "variant": variant == null
            ? null
            : List<dynamic>.from(variant.map((x) => x.toMap())),
        "datecreated":
            datecreated == null ? null : datecreated.toIso8601String(),
        "admincreated": admincreated == null ? null : admincreated,
        "dateupdated":
            dateupdated == null ? null : dateupdated.toIso8601String(),
        "linker_manufacturer":
            linkerManufacturer == null ? null : linkerManufacturer,
        "linker_category": linkerCategory == null ? null : linkerCategory,
        "search": search == null ? null : search,
        "isactive": isactive == null ? null : isactive,
        "ColorRelated": colorRelated == null
            ? null
            : List<dynamic>.from(colorRelated.map((x) => x)),
        "RelatedProducts": relatedProducts == null
            ? null
            : List<dynamic>.from(relatedProducts.map((x) => x)),
        "page_type": pageType == null ? null : pageType,
      };
}
