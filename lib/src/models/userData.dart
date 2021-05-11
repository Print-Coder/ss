import 'dart:convert';
import 'package:flutter/widgets.dart';

class UserData extends ChangeNotifier {
  UserData(
      {this.id,
      this.userDataId,
      this.name,
      this.firstname,
      this.lastname,
      this.phone,
      this.email,
      // this.gender,
      this.addresses,
      this.referalCode,
      this.referredBy,
      this.datecreated,
      this.dateupdated,
      this.walletAmount,
      this.addressIndex = 0,
      this.area,
      this.pincode});
  final String id;
  final String userDataId;
  final String name;
  final String firstname;
  final String lastname;
  final String phone;
  final String email;
  // final String gender;
  final List<Address> addresses;
  final String referalCode;
  final String referredBy;
  final dynamic datecreated;
  final DateTime dateupdated;
  final double walletAmount;
  String pincode;
  String area;
  int addressIndex;
  UserData _currentUser;
  UserData _unregister;
  UserData get currentUser => _currentUser;
  UserData get unregister => _unregister;
  setUser(Map<String, dynamic> json) {
    _currentUser = UserData.fromMap(json);

    int addIndex =
        _currentUser.addresses.indexWhere((a) => a.setDefault == true);
    _currentUser.addressIndex = addIndex;
    notifyListeners();
  }

  setRegister(String area, String pin) {
    _unregister?.area = area;
    _unregister?.pincode = pin;
    notifyListeners();
  }

  // setAddressIndexwithList(List<Address> addressList) {
  //   int addIndex = addressList.indexWhere((a) => a.setDefault == true);
  //   _currentUser.addressIndex = addIndex;
  //   notifyListeners();
  // }

  setAddressIndex(int addIndex) {
    _currentUser.addressIndex = addIndex;
    notifyListeners();
  }

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
   
        userDataId: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        // gender: json["gender"] == null ? null : json["gender"],
        addresses: json["addresses"] == null
            ? null
            : List<Address>.from(
                json["addresses"].map((x) => Address.fromMap(x))),
        referalCode: json["referal_code"] == null ? null : json["referal_code"],
        referredBy: json["referred_by"] == null ? null : json["referred_by"],
        datecreated: json["datecreated"] == null
            ? null
            : DateTime.parse(json["datecreated"]),
        dateupdated: json["dateupdated"] == null
            ? null
            : DateTime.parse(json["dateupdated"]),
        walletAmount: json["wallet_amount"] == null
            ? null
            : double.parse(json["wallet_amount"].toString()),
      );
  Map<String, dynamic> toMap() => {
     
        "id": userDataId == null ? null : userDataId,
        "name": name == null ? null : name,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        // "gender": gender == null ? null : gender,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses.map((x) => x.toMap())),
        "referal_code": referalCode == null ? null : referalCode,
        "referred_by": referredBy == null ? null : referredBy,
        "datecreated":
            datecreated == null ? null : datecreated.toIso8601String(),
        "dateupdated":
            dateupdated == null ? null : dateupdated.toIso8601String(),
        "wallet_amount": walletAmount == null ? null : walletAmount,
      };
}

class Address {
  Address(
      {this.name,
      this.phone,
      this.setDefault,
      this.street,
      this.area,
      this.city,
      this.zip,
      this.community,
      this.officeNum,
      this.landmark,
      this.istwohrs,
      this.addressType});
  final String officeNum;
  final String landmark;
  bool setDefault;
  final String name;
  final String community;
  final String phone;
  final String street;
  final String area;
  final String city;
  final String zip;
  final bool istwohrs;
  final String addressType;
  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  factory Address.fromMap(Map<String, dynamic> json) => Address(
        community: json["apartmentName"] == null ? null : json["apartmentName"],
        setDefault: json["setDefault"] == null ? null : json["setDefault"],
        addressType: json["addressType"] == null ? null : json["addressType"],
        officeNum: json["officeNum"] == null ? null : json["officeNum"],
        street: json["streetName"] == null ? null : json["streetName"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        area: json["areaDetails"] == null ? null : json["areaDetails"],
        city: json["city"] == null ? null : json["city"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        zip: json["pinCode"] == null ? null : json["pinCode"],
      );
  Map<String, dynamic> toMap() => {
        "setDefault": setDefault == null ? null : setDefault,
        "addressType": "home",
        "officeNum": officeNum == null ? null : officeNum,
        "landmark": landmark == null ? null : landmark,

        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "streetName": street == null ? null : street,
        "areaDetails": area == null ? null : area,
        "city": city == null ? null : city,
        "pinCode": zip == null ? null : zip,
        "apartmentName": community == null ? null : community,
        // "istwohrs": istwohrs == null ? null : istwohrs,
      };
}
