import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditAddress.dart';
import 'package:ECom/src/pages/widget/AddAddressButton.dart';

class AllAddress extends StatefulWidget {
  bool fromChange = false;
  AllAddress({Key key, this.fromChange = false}) : super(key: key);

  @override
  _AllAddressState createState() => _AllAddressState();
}

class _AllAddressState extends State<AllAddress> {
  @override
  void initState() {
    super.initState();
    getAllAddress(refresh: true);
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  getAllAddress({bool refresh}) async {
    refresh ? showLoading() : print("refresh false");
    Map userRes = await ApiServices.getRequestToken(userAddEndPoint);

    if (userRes != null) if (userRes["addresses"].isEmpty) {
      stopLoading();

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => Register()));
    } else {
      var userProvider = Provider.of<UserData>(context, listen: false);
      print("address response");
      print(userRes);
      userProvider.setUser(userRes);
      // setState(() {
      //   isLogin = true;
      //   isRegister = true;
      // });
      stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "My Address",
            needSearch: false,
            needCart: false,
            ispop: !(widget?.fromChange ?? false)),
        bottomNavigationBar: BottomNavBar(
          index: 3,
          isLogin: true,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => Future.delayed(Duration(seconds: 2)),
                child: Consumer<UserData>(builder: (_, userData, ch) {
                  var addObj = userData.currentUser.addresses;
                  var userObj = userData.currentUser;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 5,
                                    thickness: 1,
                                  ),
                                );
                              },
                              itemCount: addObj.length,
                              itemBuilder: (context, addressIndex) {
                                return GestureDetector(
                                  // selected: addressIndex == userObj.addressIndex,
                                  // leading:addressIndex == userObj.addressIndex?Icon(Icons.radio_button_checked): Icon(Icons.radio_button_unchecked),
                                  // dense: true,
                                  // activeColor: Colors.black,
                                  onTap: () async {
                                    if (addObj[userObj.addressIndex].zip !=
                                        addObj[addressIndex].zip) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                // insetPadding:  EdgeInsets.all(20),
                                                titlePadding:
                                                    EdgeInsets.fromLTRB(
                                                        15, 30, 0, 10),
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20, 5, 20, 0),
                                                // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                                                title: Text(
                                                    'Change the Default Address?',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5),
                                                content: Text(
                                                    'Your Cart will be cleared!!!',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: Text('No',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () async {
                                                      await ApiServices
                                                          .delRequestToken(
                                                              cartEndPoint);
                                                      Provider.of<CartData>(
                                                              context,
                                                              listen: false)
                                                          .setCartData(
                                                              {"products": []});
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      await prefs.setString(
                                                          'pinCode',
                                                          addObj[addressIndex]
                                                              .zip);
                                                      List<Map<String, dynamic>>
                                                          previousAddress =
                                                          List<
                                                                  Map<String,
                                                                      dynamic>>.from(
                                                              (userData
                                                                  .currentUser
                                                                  .addresses
                                                                  ?.map((x) => x
                                                                      .toMap())));

                                                      previousAddress.any((a) =>
                                                          a["setDefault"] =
                                                              false);

                                                      previousAddress[
                                                              addressIndex]
                                                          ["setDefault"] = true;
                                                      print(
                                                          "previous add arra$previousAddress");
                                                      Map<String, dynamic>
                                                          data = {
                                                        "name": userData
                                                            .currentUser.name,
                                                        "phone": userData
                                                            .currentUser.phone,
                                                        "email": userData
                                                                .currentUser
                                                                .email ??
                                                            "sowmya@iipl.work",
                                                        // "gender": "female",
                                                        "addresses":
                                                            previousAddress

                                                        // "otp": otp?.text ?? "123456"
                                                      }; //update
                                                      print(data.toString());

                                                      Map res =
                                                          await ApiServices
                                                              .postRequestToken(
                                                        json.encode(data),
                                                        userAddEndPoint,
                                                      );

                                                      getAllAddress(
                                                          refresh: false);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ));
                                    } else {
                                      print("same pincode");
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      await prefs.setString(
                                          'pinCode', addObj[addressIndex].zip);
                                      List<Map<String, dynamic>>
                                          previousAddress =
                                          List<Map<String, dynamic>>.from(
                                              (userData.currentUser.addresses
                                                  ?.map((x) => x.toMap())));

                                      previousAddress
                                          .any((a) => a["setDefault"] = false);

                                      previousAddress[addressIndex]
                                          ["setDefault"] = true;
                                      print(
                                          "previous add arra$previousAddress");
                                      Map<String, dynamic> data = {
                                        "name": userData.currentUser.name,
                                        "phone": userData.currentUser.phone,
                                        "email": userData.currentUser.email ??
                                            "sowmya@iipl.work",
                                        // "gender": "female",
                                        "addresses": previousAddress

                                        // "otp": otp?.text ?? "123456"
                                      }; //update
                                      print(data.toString());

                                      Map res =
                                          await ApiServices.postRequestToken(
                                        json.encode(data),
                                        userAddEndPoint,
                                      );

                                      getAllAddress(refresh: false);
                                    }
                                  },
                                  // value: addressIndex,
                                  // groupValue: userData.currentUser.addressIndex,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: addressIndex ==
                                                userObj.addressIndex
                                            ? Icon(Icons.radio_button_checked)
                                            : Icon(
                                                Icons.radio_button_unchecked),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        width: SizeConfig.w * 0.676,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //                "street": "strt two",
                                            // "area": "emjal",
                                            // "city": "Hyd",
                                            // "zip": "500059"
//                                             Show the “Name” in line1
// Apartment Number & Street Name in line2
// Landmark & Area Details in Line3
// City & Pin code in line4
// Email in line5
// Phone No in line6

                                            Text(
                                                "${addObj[addressIndex].name.capitalizeFirstofEach} ${userData.currentUser.addressIndex == addressIndex ? "(Default)" : ""}",

                                                // Ph: ${userData.currentUser.phone}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            addObj[addressIndex].community !=
                                                    null
                                                ? Text(
                                                    addObj[addressIndex]
                                                        .community
                                                        .capitalizeFirstofEach

                                                    // "H 101, White Arcade, Friends Clony,"
                                                    ,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6)
                                                : Container(),
                                            Text(
                                                addObj[addressIndex].officeNum +
                                                    ", " +
                                                    addObj[addressIndex]
                                                        .street
                                                        .capitalizeFirstofEach
                                                // "H 101, White Arcade, Friends Clony,"
                                                ,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            Text(
                                                addObj[addressIndex]
                                                        .landmark
                                                        .capitalizeFirstofEach +
                                                    ", " +
                                                    userData
                                                        .currentUser
                                                        .addresses[addressIndex]
                                                        .area
                                                        .capitalizeFirstofEach

                                                // "H 101, White Arcade, Friends Clony,"
                                                ,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),

                                            Text(
                                                userData
                                                            .currentUser
                                                            .addresses[
                                                                addressIndex]
                                                            .city
                                                            .capitalizeFirstofEach +
                                                        ", " +
                                                        userData
                                                            .currentUser
                                                            .addresses[
                                                                addressIndex]
                                                            .zip ??
                                                    "Road No6, Chandanagar, Hyd- 500050",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            Text(
                                                userData.currentUser.email ??
                                                    "email Id",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            Text(
                                                "Ph: " +
                                                        userData.currentUser
                                                            .phone ??
                                                    "phone",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          ],
                                        ),
                                      ),
                                      // Spacer(),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 20, right: 5),
                                            // alignment: Alignment.topRight,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              // border: Border.all(
                                              //   width: 1.2,
                                              //   color: Theme.of(context).accentColor,
                                              // ),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            width: SizeConfig.w * 0.17,
                                            child: RaisedButton(
                                              elevation: 0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            EditAddress(
                                                              length:userData
                                                                      .currentUser.addresses.length,
                                                              checkBool: addressIndex ==
                                                                  userData
                                                                      .currentUser
                                                                      .addressIndex,
                                                              editIndex:
                                                                  addressIndex,
                                                              userObject: userData
                                                                      .currentUser
                                                                      .addresses[
                                                                  addressIndex],
                                                            )));
                                              },
                                              child: SizedBox(
                                                width: SizeConfig.w * 0.17,
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text("Edit",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          addressIndex == userObj.addressIndex
                                              ? Container()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  // margin: EdgeInsets.only(right: 23),
                                                  // key: Key(widget.cartData.variantId),
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                  alignment:
                                                      Alignment.centerRight,

                                                  child: GestureDetector(
                                                    child: Image.asset(
                                                      'assets/icons/rubbish.png',
                                                      fit: BoxFit.cover,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      // height: 60,
                                                      // width: 60,
                                                    ),
                                                    onTap: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          // insetPadding:  EdgeInsets.all(20),
                                                          titlePadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      15,
                                                                      30,
                                                                      0,
                                                                      10),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(20,
                                                                      5, 20, 0),
                                                          // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                                                          title: Text(
                                                              'Delete Address',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5),
                                                          content: Text(
                                                              'Are you Sure you want to remove this Address?',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false),
                                                              child: Text('No',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6),
                                                            ),
                                                            FlatButton(
                                                              onPressed:
                                                                  () async {
                                                                SharedPreferences
                                                                    prefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                //   [{
//
//     }]
                                                                String token =
                                                                    await prefs
                                                                        .getString(
                                                                            'token');
                                                                Map tokenphone =
                                                                    json.decode(
                                                                        ascii.decode(
                                                                            base64.decode(base64.normalize(token.split(".")[1]))));
                                                                String
                                                                    mainName =
                                                                    await prefs
                                                                        .getString(
                                                                            'userName');
                                                                String emailId =
                                                                    await prefs
                                                                        .getString(
                                                                            'email');
                                                                print(
                                                                    tokenphone);
                                                                List<
                                                                    Map<String,
                                                                        dynamic>> previousAddress = List<
                                                                    Map<String,
                                                                        dynamic>>.from((userData
                                                                    .currentUser
                                                                    .addresses
                                                                    ?.map((x) =>
                                                                        x.toMap())));

                                                                previousAddress
                                                                    .removeAt(
                                                                        addressIndex);
                                                                print(
                                                                    "previous add arra$previousAddress");
                                                                Map<String,
                                                                        dynamic>
                                                                    data = {
                                                                  "name": userData
                                                                      .currentUser
                                                                      .name,
                                                                  "phone": tokenphone[
                                                                          "phone"] ??
                                                                      "9347980470",
                                                                  "email": userData
                                                                          .currentUser
                                                                          .email ??
                                                                      "sowmya@iipl.work",
                                                                  // "gender": "female",
                                                                  "addresses":
                                                                      previousAddress

                                                                  // "otp": otp?.text ?? "123456"
                                                                }; //update
                                                                print(data
                                                                    .toString());

                                                                Map res =
                                                                    await ApiServices
                                                                        .postRequestToken(
                                                                  json.encode(
                                                                      data),
                                                                  userAddEndPoint,
                                                                );
                                                                print(
                                                                    "res after add address");
                                                                print(res);
                                                                if (res !=
                                                                    null) {
                                                                  if (res[
                                                                      "status"]) {
                                                                    print(
                                                                        "status is true");
                                                                    var userProvider = Provider.of<
                                                                            UserData>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                    userProvider.setUser(
                                                                        res["data"]
                                                                            [
                                                                            0]);
                                                                    Navigator.pop(
                                                                        context);
                                                                    stopLoading();

                                                                    // Navigator.of(
                                                                    //         context)
                                                                    //     .pop();
                                                                  } //status is true
                                                                  else {
                                                                    stopLoading();
                                                                    Navigator.pop(
                                                                        context);
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg: res[
                                                                          "message"],
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[400],
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_LONG,
                                                                      gravity:
                                                                          ToastGravity
                                                                              .CENTER,
                                                                      timeInSecForIosWeb:
                                                                          2,
                                                                    );
                                                                  } //status is not true
                                                                }
                                                              },
                                                              child:
                                                                  Text('Yes'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        // Spacer(),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // Center(
                              //     child: Text(
                              //         "Please add a new address using the add new address",
                              //         style: Theme.of(context).textTheme.headline6)),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ]);
                }),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: AddAddressButton(
          showIcon: true,
        ));
  }
}
