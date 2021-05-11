import 'dart:convert';

import 'package:ECom/src/models/productListApi.dart';

class OrderData {
  OrderData(
      {this.id,
      this.name,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.street,
      this.city,
      this.country,
      this.billingstreet,
      this.billingcity,
      this.billingcountry,
      this.delivery,
      this.payment,
      this.company,
      this.companyid,
      this.companyvat,
      this.datecreated,
      this.iduser,
      this.iscompany,
      this.ispaid,
      this.iscod,
      this.referalId,
      this.internalType,
      this.tag,
      this.orderFrom,
      this.area,
      this.pickupCity,
      this.pickupLocation,
      this.pickupAddress,
      this.pickupMobile,
      this.pickupState,
      this.pickupPincode,
      this.ispickup,
      this.deliverycity,
      this.deliverycountry,
      this.deliveryfirstname,
      this.deliverylastname,
      this.deliveryphone,
      this.deliverystreet,
      this.version,
      this.orderDataId,
      this.orderItems,
      this.price,
      this.totalShippingPrice,
      this.mrp,
      this.deliveryType,
      this.subTotal,
      this.count,
      this.datecod,
      this.number,
      this.wallet_amount,
      this.status,
      this.discount,
      this.zip,
      this.apartmentName,
      this.refund_amount,
      this.refund_type,
      this.refund_id,
      this.expected_delivery_date,
      this.expected_delivery_time,
      this.officeNum,
      this.landmark});
  double discount;
  final String id;
  final String name;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String street;
  final String city;
  final String country;
  final String billingstreet;
  final String billingcity;
  final String billingcountry;
  final String delivery;
  final String payment;
  final String company;
  final String companyid;
  final String companyvat;
  final DateTime datecreated;
  final String iduser;
  final String iscompany;
  final bool ispaid;
  final bool iscod;
  final String referalId;
  final String internalType;
  final String tag;
  final String orderFrom;
  final String area;
  final String pickupCity;
  final String pickupLocation;
  final String pickupAddress;
  final String pickupMobile;
  final String pickupState;
  final String pickupPincode;
  final bool ispickup;
  final String deliverycity;
  final String deliverycountry;
  final String deliveryfirstname;
  final String deliverylastname;
  final dynamic deliveryphone;
  final String deliverystreet;
  final String version;
  final String orderDataId;
  final List<OrderItem> orderItems;
  final double price;
  final double totalShippingPrice;
  final double mrp;
  final String deliveryType;
  final double subTotal;
  final double wallet_amount;
  final int count;
  final DateTime datecod;
  final String expected_delivery_date;
  final String expected_delivery_time;
  final dynamic number;
  final String status;
  final String zip;
  final String apartmentName;
  final String officeNum;
  final String landmark;
  final double refund_amount;
  final String refund_type;
  final String refund_id;
  factory OrderData.fromJson(String str) => OrderData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderData.fromMap(Map<String, dynamic> json) => OrderData(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        street: json["street"] == null ? null : json["street"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        billingstreet:
            json["billingstreet"] == null ? null : json["billingstreet"],
        billingcity: json["billingcity"] == null ? null : json["billingcity"],
        billingcountry:
            json["billingcountry"] == null ? null : json["billingcountry"],
        delivery: json["delivery"] == null ? null : json["delivery"],
        payment: json["payment"] == null ? null : json["payment"],
        company: json["company"] == null ? null : json["company"],
        companyid: json["companyid"] == null ? null : json["companyid"],
        companyvat: json["companyvat"] == null ? null : json["companyvat"],
        datecreated: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        expected_delivery_date: json["expected_delivery_date"] == null
            ? null
            : json["expected_delivery_date"],
        expected_delivery_time: json["expected_delivery_time"] == null
            ? null
            : json["expected_delivery_time"],
        iduser: json["iduser"] == null ? null : json["iduser"],
        iscompany: json["iscompany"] == null ? null : json["iscompany"],
        ispaid: json["ispaid"] == null ? null : json["ispaid"],
        iscod: json["iscod"] == null ? null : json["iscod"],
        referalId: json["referalId"] == null ? null : json["referalId"],
        internalType:
            json["internal_type"] == null ? null : json["internal_type"],
        tag: json["tag"] == null ? null : json["tag"],
        orderFrom: json["order_from"] == null ? null : json["order_from"],
        area: json["area"] == null ? null : json["area"],
        pickupCity: json["pickupCity"] == null ? null : json["pickupCity"],
        pickupLocation:
            json["pickupLocation"] == null ? null : json["pickupLocation"],
        pickupAddress:
            json["pickupAddress"] == null ? null : json["pickupAddress"],
        pickupMobile:
            json["pickupMobile"] == null ? null : json["pickupMobile"],
        pickupState: json["pickupState"] == null ? null : json["pickupState"],
        pickupPincode:
            json["pickupPincode"] == null ? null : json["pickupPincode"],
        ispickup: json["ispickup"] == null ? null : json["ispickup"],
        deliverycity:
            json["deliverycity"] == null ? null : json["deliverycity"],
        deliverycountry:
            json["deliverycountry"] == null ? null : json["deliverycountry"],
        deliveryfirstname: json["deliveryfirstname"] == null
            ? null
            : json["deliveryfirstname"],
        deliverylastname:
            json["deliverylastname"] == null ? null : json["deliverylastname"],
        deliveryphone:
            json["deliveryphone"] == null ? null : json["deliveryphone"],
        deliverystreet:
            json["deliverystreet"] == null ? null : json["deliverystreet"],
        version: json["version"] == null ? null : json["version"],
        orderDataId: json["id"] == null ? null : json["id"],
        orderItems: json["items"] == null
            ? null
            : List<OrderItem>.from(
                json["items"].map((x) => OrderItem.fromMap(x))),
        price: json["price"] == null
            ? null
            : double.parse(json["price"].toString()),
        totalShippingPrice: json["totalShippingPrice"] == null
            ? null
            : double.parse(json["totalShippingPrice"].toString()),
        mrp: json["mrp"] == null ? null : double.parse(json["mrp"].toString()),
        discount: json["discount"] == null
            ? null
            : double.parse(json["discount"].toString()),
        wallet_amount: json["wallet_amount"] == null
            ? null
            : double.parse(json["wallet_amount"].toString()),
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        refund_amount: json["refund_amount"] == null
            ? null
            : double.parse(json["refund_amount"].toString()),
        refund_type: json["refund_type"] == null ? null : json["refund_type"],
        refund_id: json["refund_id"] == null ? null : json["refund_id"],
        subTotal: json["SubTotal"] == null
            ? null
            : double.parse(json["SubTotal"].toString()),
        count: json["count"] == null ? null : json["count"],
        datecod:
            json["datecod"] == null ? null : DateTime.parse(json["datecod"]),
        number: json["number"] == null ? null : json["number"],
        status: json["status"] == null ? null : json["status"],
        zip: json["zip"] == null ? null : json["zip"],
        apartmentName:
            json["apartmentName"] == null ? null : json["apartmentName"],
        officeNum: json["officeNum"] == null ? null : json["officeNum"],
        landmark: json["landmark"] == null ? null : json["landmark"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "street": street == null ? null : street,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "billingstreet": billingstreet == null ? null : billingstreet,
        "billingcity": billingcity == null ? null : billingcity,
        "billingcountry": billingcountry == null ? null : billingcountry,
        "delivery": delivery == null ? null : delivery,
        "payment": payment == null ? null : payment,
        "company": company == null ? null : company,
        "companyid": companyid == null ? null : companyid,
        "companyvat": companyvat == null ? null : companyvat,
        "created_on":
            datecreated == null ? null : datecreated.toIso8601String(),
        "iduser": iduser == null ? null : iduser,
        "iscompany": iscompany == null ? null : iscompany,
        "ispaid": ispaid == null ? null : ispaid,
        "iscod": iscod == null ? null : iscod,
        "referalId": referalId == null ? null : referalId,
        "internal_type": internalType == null ? null : internalType,
        "tag": tag == null ? null : tag,
        "order_from": orderFrom == null ? null : orderFrom,
        "area": area == null ? null : area,
        "pickupCity": pickupCity == null ? null : pickupCity,
        "pickupLocation": pickupLocation == null ? null : pickupLocation,
        "pickupAddress": pickupAddress == null ? null : pickupAddress,
        "pickupMobile": pickupMobile == null ? null : pickupMobile,
        "pickupState": pickupState == null ? null : pickupState,
        "pickupPincode": pickupPincode == null ? null : pickupPincode,
        "ispickup": ispickup == null ? null : ispickup,
        "deliverycity": deliverycity == null ? null : deliverycity,
        "deliverycountry": deliverycountry == null ? null : deliverycountry,
        "deliveryfirstname":
            deliveryfirstname == null ? null : deliveryfirstname,
        "deliverylastname": deliverylastname == null ? null : deliverylastname,
        "deliveryphone": deliveryphone == null ? null : deliveryphone,
        "deliverystreet": deliverystreet == null ? null : deliverystreet,
        "version": version == null ? null : version,
        "id": orderDataId == null ? null : orderDataId,
        "items": orderItems == null
            ? null
            : List<dynamic>.from(orderItems.map((x) => x.toMap())),
        "price": price == null ? null : price,
        "totalShippingPrice":
            totalShippingPrice == null ? null : totalShippingPrice,
        "mrp": mrp == null ? null : mrp,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "SubTotal": subTotal == null ? null : subTotal,
        "count": count == null ? null : count,
        "datecod": datecod == null ? null : datecod.toIso8601String(),
        "number": number == null ? null : number,
        "status": status == null ? null : status,
        "zip": zip == null ? null : zip,
        "apartmentName": apartmentName == null ? null : apartmentName,
        "officeNum": officeNum == null ? null : officeNum,
        "landmark": landmark == null ? null : landmark,
      };
}

class OrderItem {
  OrderItem({
    this.id,
    this.orderItemId,
    this.offerdesc,
    this.name,
    this.pictures,
    this.shippingPrice,
    this.ispickup,
    this.iscod,
    this.variant,
    this.deliveryType,
    this.quantity,
    this.variantId,
    this.cartId,
    this.price,
    this.mrp,
  });

  final String id;
  final String orderItemId;
  final String offerdesc;
  final String name;
  final List<String> pictures;
  final double shippingPrice;
  final bool ispickup;
  final bool iscod;
  final Variant variant;
  final String deliveryType;
  final int quantity;
  final String variantId;
  final String cartId;
  final double price;
  final double mrp;

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["_id"] == null ? null : json["_id"],
        orderItemId: json["id"] == null ? null : json["id"],
        offerdesc: json["offerdesc"] == null ? null : json["offerdesc"],
        name: json["name"] == null ? null : json["name"],
        pictures: json["pictures"] == null
            ? null
            : List<String>.from(json["pictures"].map((x) => x)),
        shippingPrice: json["shippingPrice"] == null
            ? null
            : double.parse(json["shippingPrice"].toString()),
        ispickup: json["ispickup"] == null ? null : json["ispickup"],
        iscod: json["iscod"] == null ? null : json["iscod"],
        variant:
            json["variant"] == null ? null : Variant.fromMap(json["variant"]),
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        variantId: json["variantId"] == null ? null : json["variantId"],
        cartId: json["cartId"] == null ? null : json["cartId"],
        price: json["price"] == null
            ? null
            : double.parse(json["price"].toString()),
        mrp: json["mrp"] == null ? null : double.parse(json["mrp"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "id": orderItemId == null ? null : orderItemId,
        "offerdesc": offerdesc == null ? null : offerdesc,
        "name": name == null ? null : name,
        "pictures": pictures == null
            ? null
            : List<dynamic>.from(pictures.map((x) => x)),
        "shippingPrice": shippingPrice == null ? null : shippingPrice,
        "ispickup": ispickup == null ? null : ispickup,
        "iscod": iscod == null ? null : iscod,
        "variant": variant == null ? null : variant,
        "delivery_type": deliveryType == null ? null : deliveryType,
        "quantity": quantity == null ? null : quantity,
        "variantId": variantId == null ? null : variantId,
        "cartId": cartId == null ? null : cartId,
        "price": price == null ? null : price,
        "mrp": mrp == null ? null : mrp,
      };
}
