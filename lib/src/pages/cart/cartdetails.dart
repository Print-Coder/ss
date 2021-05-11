import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/cartNoItem.dart';
import 'package:ECom/src/pages/orders/orderConfirmation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/pages/Account/address/EditAddress.dart';
import 'package:ECom/src/pages/widget/AddAddressButton.dart';
import 'package:ECom/src/pages/widget/cartRadio.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ECom/src/pages/orders/payment.dart';
// import '../elements/CartBottomDetailsWidget.dart';
// import '../elements/CartItemWidget.dart';
// import '../elements/EmptyCartWidget.dart';
import 'CartProductItem.dart';
import 'cartSummary.dart';
import 'api/CartData.dart';
import 'api/cartVerifyData.dart';
import 'package:ECom/src/pages/home.dart';

class CartDetailsWidget extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKeyCart1;

  CartDetailsWidget({Key key, this.scaffoldKeyCart1}) : super(key: key);

  @override
  _CartDetailsWidgetState createState() => _CartDetailsWidgetState();
}

class _CartDetailsWidgetState extends State<CartDetailsWidget> {
  bool checkBool = false;
  bool checkApply = false;
  String payment_type = "cod";
  String rush_type = "Regular";
  int payment_id = 1;
  int rush = 1;
  void _onCheckApply(bool newValue) => setState(() {
        checkApply = !checkApply;
      });
  void _onCheckChange(bool newValue) => setState(() {
        checkBool = !checkBool;
      });
  // CartController _con;

  // _CartWidgetState() : super(CartController()) {
  //   _con = controller;
  // }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCartData(refresh: false);
    timeout(30);
  }

  timeout(int minutes) async {
    Future.delayed(Duration(minutes: minutes), () {
      // Future.delayed(Duration(minutes: minutes), () {
      // 5s over, navigate to a new page
      widget.scaffoldKeyCart1.currentState?.showSnackBar(
        SnackBar(
            duration: Duration(seconds: 15),
            backgroundColor: Theme.of(context).primaryColor,
            content: Text("Your session has been expired")),
      );
      Navigator.pop(context);
    });
  }

  String coupon;
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });

  showWLoading() => setState(() {
        _isWLoading = true;
      });
  stopWLoading() => setState(() {
        _isWLoading = false;
      });

  showCLoading() => setState(() {
        _isCLoading = true;
      });
  stopCLoading() => setState(() {
        _isCLoading = false;
      });
  bool _isLoading = false;
  bool _isWLoading = false;
  bool _isCLoading = false;
  bool _isCart = false;
  NoRushData noRushData;
  Regular regularData;
  Duration regularDay = Duration(days: int.parse("1") + 1);
  getCartData({bool refresh}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool("isLogin") ?? false;
    if (isLogin) {
      refresh ? print("refresh is true") : showLoading();

      // await Future.delayed(Duration(milliseconds: 1000));

      Map res = await ApiServices.getRequestToken(cartEndPoint);
      Map noRushres = await ApiServices.getRequestToken(noRushEndPoint);
      Map regularres = await ApiServices.getRequestToken(regEndPoint);
      if (noRushres != null) {
        noRushData = NoRushData.fromMap(noRushres["data"]);
      }
      if (regularres != null) regularData = Regular.fromMap(regularres["data"]);
      regularDay =
          new Duration(days: int.parse(regularData?.daysOfSkip ?? "1") + 1);
      if (res != null) {
        // print("init of cart");
        // print(res["data"]["products"].isEmpty);
        // print(res["status"] == false);
        if (res["status"] && (res["data"]["products"]?.isNotEmpty ?? false)) {
          Provider.of<CartData>(context, listen: false)
              .setCartData(res["data"]);
          stopLoading();
          setState(() {
            _isCart = true;
          });
        } //status is true
        else if (res["status"] == false || res["data"]["products"].isEmpty) {
          stopLoading();
          setState(() {
            _isCart = false;
          });
          // Navigator.of(context).pushNamed("/CartNoItem");
        }
      } else {
        stopLoading();
      } //status is not true
    }
  }

  bool _orderConfirmed = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<CartData>(builder: (context, cartdata, ch) {
      return Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavBar(
            index: 0,
            isLogin: true,
          ),
          backgroundColor: Colors.white,
          appBar: AppBarWithPop(context, "My Cart",
              needCart: false, ispop: true, needSearch: true),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (!_isCart ||
                      (cartdata?.currentCart?.products?.isEmpty ?? false))
                  ? CartNoItem()
                  : Consumer<UserData>(builder: (_, userData, ch) {
                      bool noData =
                          userData?.currentUser?.addresses?.isEmpty ?? true;

                      Address userObject = userData?.currentUser
                          ?.addresses[userData?.currentUser?.addressIndex ?? 0];
                      print("ffffffffffff${userObject.toJson()}");
                      return noData
                          ? Container()
                          : RefreshIndicator(
                              onRefresh: () => getCartData(refresh: true),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: SizeConfig.w * 0.9,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Deliver to",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                    Icons.radio_button_checked),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  width: SizeConfig.w / 1.3,
                                                  child: Wrap(
                                                    spacing: 5,
                                                    children: <Widget>[
                                                      //                "street": "strt two",
                                                      // "area": "emjal",
                                                      // "city": "Hyd",
                                                      // "zip": "500059"
                                                      Text(
                                                          userObject.name
                                                              .capitalizeFirstofEach,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
                                                      Text(
                                                          " -  Ph: " +
                                                              userData
                                                                  .currentUser
                                                                  .phone,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
                                                      userObject.community !=
                                                              null
                                                          ? Text(
                                                              userObject
                                                                  .community
                                                                  .capitalizeFirstofEach
                                                              // "H 101, White Arcade, Friends Clony,"
                                                              ,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6)
                                                          : Container(),
                                                      Text(
                                                          userObject.officeNum +
                                                              ", " +
                                                              userObject.street
                                                                  .capitalizeFirstofEach
                                                          // "H 101, White Arcade, Friends Clony,"
                                                          ,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
                                                      Text(
                                                          userObject.landmark
                                                                  .capitalizeFirstofEach +
                                                              ", " +
                                                              userObject.area
                                                                  .capitalizeFirstofEach

                                                          // "H 101, White Arcade, Friends Clony,"
                                                          ,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),

                                                      Text(
                                                          userObject.city
                                                                      .capitalizeFirstofEach +
                                                                  ", " +
                                                                  userObject
                                                                      .zip ??
                                                              "Road No6, Chandanagar, Hyd- 500050",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6),
//                                                Text(
//                                                    userData.currentUser
//                                                            .email ??
//                                                        "email Id",
//                                                    style: Theme.of(context)
//                                                        .textTheme
//                                                        .headline6),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Column(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: <Widget>[
                                            //     //                "street": "strt two",
                                            //     // "area": "emjal",
                                            //     // "city": "Hyd",
                                            //     // "zip": "500059"
                                            //     Text(
                                            //         "${userObject.name.replaceRange(0, 1, userObject.name[0].toUpperCase())}- Ph: ${userObject.phone}",
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .headline6),
                                            //     Text(
                                            //         !userObject.street
                                            //                 .contains("///")
                                            //             ? userObject.street
                                            //             : userObject.street
                                            //                     .split("///")[0] +
                                            //                 ", " +
                                            //                 userObject.street
                                            //                     .split("///")[1] +
                                            //                 ", " +
                                            //                 userObject.street
                                            //                     .split("///")[2] +
                                            //                 ", " +
                                            //                 userObject.area
                                            //         // "H 101, White Arcade, Friends Clony,"
                                            //         ,
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .headline6),
                                            //     Text(
                                            //         userObject.city +
                                            //                 ", " +
                                            //                 userObject.zip ??
                                            //             "Road No6, Chandanagar, Hyd- 500050",
                                            //         style: Theme.of(context)
                                            //             .textTheme
                                            //             .headline6),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Center(
                                    //   child: Container(
                                    //     height: 35,
                                    //     width: SizeConfig.w * 0.9,
                                    //     padding: const EdgeInsets.only(
                                    //         left: 8.0, top: 2, right: 5),
                                    //     margin: EdgeInsets.only(left: 0.0, top: 10),
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         border: Border.all(
                                    //             color:
                                    //                 Theme.of(context).accentColor,
                                    //             width: 1.2)),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "Add New Address",
                                    //         style: Theme.of(context)
                                    //             .textTheme
                                    //             .headline5
                                    //             .copyWith(color: Colors.black),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Divider(
                                      thickness: 1,
                                      color: Theme.of(context).dividerColor,
                                    ),

                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 15, bottom: 12),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Apply Coupon",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 14),
                                      ),
                                    ),

                                    // (cartdata.currentCart.ssTotalPrice >
                                    //         0) //total price should be >0
                                    //     ?
                                    cartdata.currentCart.isCouponApplied
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 8.0, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Coupon Applied:",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${cartdata.currentCart.coupon}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          color: Colors.red,
                                                          fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
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
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                                            'Delete Coupon',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5),
                                                        content: Text(
                                                            'Are you Sure you want to remove this coupon?',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child: Text('No',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6),
                                                          ),
                                                          FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Map res =
                                                                  await ApiServices
                                                                      .postRequestToken(
                                                                json.encode({
                                                                  "coupon": cartdata
                                                                      .currentCart
                                                                      .coupon
                                                                }),
                                                                cartRCouponEndPoint,
                                                              );

                                                              getCartData(
                                                                  refresh:
                                                                      true);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Coupon Deleted",
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        400],
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    3,
                                                              );
                                                            },
                                                            child: Text('Yes'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 35,
                                                width: SizeConfig.w * 0.73,
                                                padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 2,
                                                ),
                                                margin: EdgeInsets.only(
                                                    left: 15, top: 0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5)),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.2)),
                                                child: Center(
                                                  child: TextField(
                                                    //  maxLength: 10,
                                                    enabled: !(cartdata
                                                            ?.currentCart
                                                            ?.isCouponApplied ??
                                                        false)

                                                    //      &&
                                                    // (cartdata
                                                    //         .currentCart
                                                    //         .ssTotalPrice >
                                                    //     0)
                                                    ,
                                                    onChanged: (c) {
                                                      setState(() {
                                                        coupon = c;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      //  prefixText: "Enter Coupon Code"
                                                      labelText: "Enter Code",
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,

                                                      labelStyle: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      //  helperText: "Enter your 10 digit Mobile Number",
                                                      //  helperStyle: TextStyle(
                                                      //      color: Colors.black45,
                                                      //      fontWeight: FontWeight.w400),
                                                      //  focusedBorder: UnderlineInputBorder(
                                                      //    borderSide: BorderSide(
                                                      //        color: Theme.of(context).primaryColor),
                                                      //  ),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ),
                                              ),
                                              _isCLoading
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 25),
                                                      // margin: EdgeInsets.only(
                                                      //     left: 14,
                                                      //     bottom: 12,
                                                      //     right: 11,
                                                      //     top: 12),
                                                      width: 22,
                                                      height: 22,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        strokeWidth: 1.3,
                                                      )),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 10),
                                                      width: SizeConfig.w * 0.2,
                                                      height: 35,
                                                      child: RaisedButton(
                                                        elevation: 0,
                                                        color:
                                                            // cartdata.currentCart
                                                            //                 .ssTotalPrice >
                                                            //             0 &&
                                                            (coupon?.isNotEmpty ??
                                                                    false)
                                                                ? Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                : Colors
                                                                    .grey[500],
                                                        onPressed:
                                                            (coupon?.isEmpty ??
                                                                    false)
                                                                ? () {}
                                                                : () async {
                                                                    // if (check) {

                                                                    showCLoading();
                                                                    // await Future.delayed(
                                                                    //     Duration(
                                                                    //         milliseconds: 500));
                                                                    print(
                                                                        coupon);
                                                                    Map res = await ApiServices.postRequestToken(
                                                                        json.encode({
                                                                          "coupon":
                                                                              coupon
                                                                        }),
                                                                        cartCouponEndPoint);
                                                                    print(res);
                                                                    if (res !=
                                                                        null) {
                                                                      if (res[
                                                                          "status"]) {
                                                                        getCartData(
                                                                            refresh:
                                                                                true);
                                                                        stopCLoading();
                                                                      } //status is true
                                                                      else {
                                                                        stopCLoading();
                                                                        _scaffoldKey
                                                                            .currentState
                                                                            ?.showSnackBar(SnackBar(
                                                                          backgroundColor:
                                                                              Theme.of(context).primaryColor,
                                                                          content:
                                                                              Text(res["message"] ?? (res["data"] ?? "Invalid Couopn")),
                                                                        ));
                                                                        print(
                                                                            "apply coupon not updated at backend");
                                                                      }
                                                                    } else {
                                                                      stopCLoading();
                                                                    } //status is not true
                                                                  },
                                                        child: FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Text("Apply",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .copyWith(
                                                                      color:
                                                                          // cartdata.currentCart.ssTotalPrice > 0 &&
                                                                          (coupon?.isNotEmpty ?? false)
                                                                              ? Colors.white
                                                                              : Colors.black)),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )
                                    // : Container()
                                    ,
                                    userData.currentUser.walletAmount > 0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              _isWLoading
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 14,
                                                          bottom: 12,
                                                          right: 11,
                                                          top: 12),
                                                      width: 22,
                                                      height: 22,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        strokeWidth: 1.3,
                                                      )),
                                                    )
                                                  : Checkbox(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      value: cartdata
                                                          .currentCart.iswallet,
                                                      focusColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      onChanged: (check) async {
                                                        // if (check) {
                                                        showWLoading();
                                                        // await Future.delayed(Duration(
                                                        //     milliseconds: 1000));

                                                        Map res = await ApiServices
                                                            .postRequestToken(
                                                                json.encode({
                                                                  "is_wallet":
                                                                      check
                                                                }),
                                                                cartUpdateEndPoint);
                                                        print(res);
                                                        if (res != null) {
                                                          if (res["status"]) {
                                                            getCartData(
                                                                refresh: true);
                                                            stopWLoading();
                                                          } //status is true
                                                          else if (res[
                                                              "status"]) {
                                                            stopWLoading();
                                                            print(
                                                                "apply check not updated at backend");
                                                          }
                                                        } else {
                                                          stopWLoading();
                                                        } //status is not true
                                                      },
                                                    ),
                                              SizedBox(
                                                width: SizeConfig.w * 0.6,
                                                // child: FittedBox(
                                                //   fit: BoxFit.fitWidth,
                                                child: textH5(
                                                  "Apply Available Cashback",
                                                  textstyle:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: Text(
                                                  Helper.getPrice(userData
                                                      .currentUser
                                                      .walletAmount),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    // Radio(
                                    //       activeColor:
                                    //           Theme.of(context).primaryColor,
                                    //       onChanged: (i) {
                                    //         setState(() {

                                    //           value = i;
                                    //         });
                                    //       },
                                    //       value: ,
                                    //       groupValue: value,
                                    //       title: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment
                                    //                   .spaceBetween,
                                    //           children: <Widget>[
                                    //           ]),
                                    //       subtitle: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: <Widget>[

                                    //         ],
                                    //       ),
                                    //     );

                                    // (cartdata.currentCart.ssTotalPrice <= 0)
                                    //     ? Padding(
                                    //         padding: EdgeInsets.only(left: 15),
                                    //         child: Align(
                                    //           alignment: Alignment.centerLeft,
                                    //           child: Text(
                                    //             "There are no shopsasta products",
                                    //             style: Theme.of(context)
                                    //                 .textTheme
                                    //                 .headline6
                                    //                 .copyWith(
                                    //                     fontSize: 12,
                                    //                     color: Colors.red),
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : Container(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CartSummary(
                                      cartSummary: cartdata.currentCart,
                                    ),
//                    (cartdata.currentCart.ssTotalPrice > 0)
//                        ? Column(
//                      children: [
//                        Row(
//                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Checkbox(
//                              activeColor:
//                              Theme.of(context).primaryColor,
//                              value: checkBool,
//                              focusColor:
//                              Theme.of(context).primaryColor,
//                              onChanged: _onCheckChange,
//                            ),
//                            SizedBox(
//                              width: SizeConfig.w * 0.7,
//                              child: FittedBox(
//                                fit: BoxFit.fitWidth,
//                                child: Text(
//                                    "Extra ${noRushData?.cashbackPercent ?? 1}% cashback for No-Rush delivery",
//                                    style: Theme.of(context)
//                                        .textTheme
//                                        .headline6
//                                  // .copyWith(fontSize: 16),
//                                ),
//                              ),
//                            ),
//                            Icon(
//                              Icons.info_outline,
//                              color: Theme.of(context).primaryColor,
//                            )
//                          ],
//                        ),
//                      ],
//                    )
//                        : Container(),
                                    // (cartdata.currentCart.ssTotalPrice > 0)
                                    //     ?
                                    Container(
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Delivery Options",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                        )),
                                    // : Container(),
                                    // (cartdata.currentCart.ssTotalPrice > 0)
                                    //     ?
                                    Wrap(
                                      spacing: 0,
                                      children: <Widget>[
                                        RadioCart(
                                          radioText: 'Regular',
                                          payment_id: rush,
                                          valueint: 1,
                                          radioClick: (val) {
                                            setState(() {
                                              rush_type = 'Regular';
                                              rush = 1;
                                            });
                                          },
                                          textClick: () {
                                            setState(() {
                                              rush_type = 'Regular';
                                              rush = 1;
                                            });
                                          },
                                        ),
                                        RadioCart(
                                          radioText:
                                              'No-Rush (You get extra ${noRushData?.cashbackPercent}% cashback)',
                                          payment_id: rush,
                                          valueint: 2,
                                          radioClick: (val) {
                                            setState(() {
                                              rush_type = 'NoRush';
                                              rush = 2;
                                            });
                                          },
                                          textClick: () {
                                            setState(() {
                                              rush_type = 'NoRush';
                                              rush = 2;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    // : Container(),
                                    rush == 2
                                        ? FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              "Expected delivery on ${DateFormat.yMMMEd().format(DateTime.now().add(Duration(days: 7)))}(${noRushData?.deliveryHours})",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 5.0,
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                "Expected delivery on ${DateFormat.yMMMEd().format(DateTime.now().add(regularDay))}(${regularData?.deliveryHours})",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          ),
                                    Container(
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Payment Options",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                RadioCart(
                                                  radioText: 'PAYTM',
                                                  payment_id: payment_id,
                                                  valueint: 2,
                                                  radioClick: (val) {
                                                    setState(() {
                                                      payment_type = 'online';
                                                      payment_id = 2;
                                                    });
                                                  },
                                                  textClick: () {
                                                    setState(() {
                                                      payment_type = 'online';
                                                      payment_id = 2;
                                                    });
                                                  },
                                                ),
                                                RadioCart(
                                                  radioText: 'COD',
                                                  payment_id: payment_id,
                                                  valueint: 1,
                                                  radioClick: (val) {
                                                    setState(() {
                                                      payment_type = 'cod';
                                                      payment_id = 1;
                                                    });
                                                  },
                                                  textClick: () {
                                                    setState(() {
                                                      payment_type = 'cod';
                                                      payment_id = 1;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: _orderConfirmed
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    // width: SizeConfig.w * 0.4,
                                                    height: 35,
                                                    child: RaisedButton(
                                                      elevation: 0,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      onPressed: () async {
                                                        print("billing addres");
//-----------cart verify
                                                        Map<String, dynamic>
                                                            cartVerifydata = {
                                                          "pincode":
                                                              userObject.zip
                                                        };

                                                        List<CartVerify>
                                                            cartVerifyList = [];

                                                        List<dynamic>
                                                            cartVerifyres =
                                                            await ApiServices
                                                                .postRequestListToken(
                                                          json.encode(
                                                              cartVerifydata),
                                                          cartVerifyEndPoint,
                                                        );
                                                        cartVerifyres.forEach(
                                                            (x) => cartVerifyList
                                                                .add(CartVerify
                                                                    .fromMap(
                                                                        x)));
                                                        bool stockBool = false;
                                                        int booLength = 0;

                                                        cartVerifyList
                                                            .forEach((c) {
                                                          stockBool =
                                                              c.statusCode !=
                                                                  "INSTOCK";
                                                          if (stockBool)
                                                            booLength += 1;
                                                        });

                                                        stockBool = cartVerifyList
                                                            .any((c) =>
                                                                c.statusCode !=
                                                                "INSTOCK");
                                                        if (stockBool ??
                                                            false) {
                                                          setState(() {
                                                            _orderConfirmed =
                                                                false;
                                                          });
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              SizeConfig().init(
                                                                  context);
                                                              return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  scrollable:
                                                                      true,
                                                                  content:
                                                                      SizedBox(
                                                                    // height: 60,
                                                                    width: SizeConfig
                                                                            .w *
                                                                        0.7,
                                                                    child:
                                                                        AutoSizeText(
                                                                      "Your cart prices and items are updated, if you want to continue with revised stock and price",
                                                                      maxLines:
                                                                          3,
                                                                      minFontSize:
                                                                          11,
                                                                      maxFontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  title: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        // constraints:
                                                                        //     BoxConstraints(maxHeight: SizeConfig.h * 0.5),

                                                                        // height: SizeConfig.h *
                                                                        //     0.15,
                                                                        child: ListView.separated(
                                                                            separatorBuilder: (context, i) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Divider(
                                                                                  height: 2,
                                                                                  thickness: 1,
                                                                                ),
                                                                              );
                                                                            },
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.vertical,
                                                                            itemCount: booLength,
                                                                            itemBuilder: (context, index) {
                                                                              if (cartVerifyList[index].statusCode != "INSTOCK")
                                                                                return SizedBox(
                                                                                  width: SizeConfig.w * 0.6,
                                                                                  child: Text(
                                                                                    cartVerifyList[index].message,
                                                                                    maxLines: 3,
                                                                                    softWrap: true,
                                                                                  ),
                                                                                );
                                                                              else
                                                                                return Container();
                                                                            }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  actions: [
                                                                    FlatButton(
                                                                      child:
                                                                          Text(
                                                                        "Review Cart",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Theme.of(context).primaryColor),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        await ApiServices
                                                                            .postRequestToken(
                                                                          json.encode(
                                                                              cartVerifyres),
                                                                          cartConfirmEndPoint,
                                                                        );
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        Navigator.of(context)
                                                                            .popAndPushNamed('/Cart');
                                                                      },
                                                                    ),
                                                                    FlatButton(
                                                                        child:
                                                                            Text(
                                                                          "Confirm Order",
                                                                          style:
                                                                              TextStyle(color: Theme.of(context).primaryColor),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Map<String, dynamic>
                                                                              data =
                                                                              {
                                                                            "billingAddress":
                                                                                userObject.toMap(),
                                                                            "payment_type":
                                                                                payment_type,
                                                                            "nextweekdelivery": rush == 2
                                                                                ? true
                                                                                : false,
                                                                            "email":
                                                                                userData.currentUser.email,
                                                                            "expected_delivery_time": (rush == 2
                                                                                ? noRushData.deliveryHours
                                                                                : regularData.deliveryHours),
                                                                            "expected_delivery_date": rush == 2
                                                                                ? DateTime.now().add(Duration(days: 7)).toIso8601String()
                                                                                : DateTime.now().add(regularDay).toIso8601String()
                                                                          };
                                                                          print(
                                                                              "nnnnnnnnnnnnnnn${data}");
                                                                          setState(
                                                                              () {
                                                                            _orderConfirmed =
                                                                                true;
                                                                          });
                                                                          // await Future.delayed(
                                                                          //     Duration(milliseconds: 600));
                                                                          // print(
                                                                          //     data);
                                                                          // print(
                                                                          //     "hitting api for order");

                                                                          Map res =
                                                                              await ApiServices.postRequestToken(
                                                                            json.encode(data),
                                                                            createOrderEndPoint,
                                                                          );
                                                                          // print(
                                                                          //     "ffffffffffggggggggggggffffffffffffff${res}");
                                                                          if (res["status"] !=
                                                                              null) {
                                                                            SharedPreferences
                                                                                prefs =
                                                                                await SharedPreferences.getInstance();

                                                                            Map userRes;
                                                                            // print(" $token ");
                                                                            try {
                                                                              userRes = await ApiServices.getRequestToken(userAddEndPoint);
                                                                            } catch (e) {
                                                                              await prefs.remove('token');
                                                                              setState(() {
                                                                                _orderConfirmed = false;
                                                                              });
                                                                              Fluttertoast.showToast(
                                                                                msg: "Server is not responding",
                                                                                backgroundColor: Colors.grey[400],
                                                                                toastLength: Toast.LENGTH_LONG,
                                                                                gravity: ToastGravity.BOTTOM,
                                                                                timeInSecForIosWeb: 2,
                                                                              );
                                                                            }

                                                                            if (userRes != null) if (userRes["addresses"] != null &&
                                                                                (userRes["addresses"] ?? []).isEmpty) {
                                                                              // stopLoading();

                                                                              stopLoading();

                                                                              // Navigator.of(context).pushNamed('/Intro');
                                                                            } //user login but didn't register , make islogin false and go to intro
                                                                            else if (userRes["status"] != null &&
                                                                                (userRes["status"] == false ?? true)) {
                                                                              await prefs.remove('token');

                                                                              await prefs.setBool('isLogin', false);

                                                                              stopLoading();
                                                                            } else {
                                                                              //has token and address

                                                                              var userProvider = Provider.of<UserData>(context, listen: false);
                                                                              userProvider.setUser(userRes);

                                                                              print("into the order screen");
                                                                            } //user data update

                                                                            // Provider.of<CartData>(
                                                                            //         context,
                                                                            //         listen:
                                                                            //             false)
                                                                            //     .setCartData({
                                                                            //   "products": []
                                                                            // });
                                                                            print("order Id${res["orderIds"]}");

                                                                            if (payment_id ==
                                                                                1)
                                                                              Navigator.of(context)
                                                                                  .push(MaterialPageRoute(
                                                                                      builder: (_) => OrderConfirmation(
                                                                                            fromPayment: false,
                                                                                            orderIds: res["data"]["orderIds"],
                                                                                          )))
                                                                                  .then((e) => setState(() {
                                                                                        _orderConfirmed = false;
                                                                                      }));
                                                                            else {
                                                                              Navigator.of(context)
                                                                                  .push(MaterialPageRoute(
                                                                                      builder: (_) => Payment(
                                                                                            transaction: res["txnid"],
                                                                                          )))
                                                                                  .then((e) => setState(() {
                                                                                        _orderConfirmed = false;
                                                                                      }));
                                                                            }
                                                                            // cartdata?.currentCart?.products =
                                                                            //     [];

                                                                          } //cart res is not null

                                                                          else {
                                                                            setState(() {
                                                                              _orderConfirmed = false;
                                                                            });
                                                                            // itemData?.quantity += 1;

                                                                            Fluttertoast.showToast(
                                                                              msg: res["message"] ?? "Cart is Empty",
                                                                              backgroundColor: Colors.grey[400],
                                                                              toastLength: Toast.LENGTH_LONG,
                                                                              gravity: ToastGravity.CENTER,
                                                                              timeInSecForIosWeb: 2,
                                                                            );
                                                                          }
                                                                        }),
                                                                  ]);
                                                            },
                                                          );
                                                        }

                                                        //--------order confirm without cart confirm

                                                        else {
                                                          Map<String, dynamic>
                                                              data = {
                                                            "billingAddress":
                                                                userObject
                                                                    .toMap(),
                                                            "payment_type":
                                                                payment_type,
                                                            "nextweekdelivery":
                                                                rush == 2
                                                                    ? true
                                                                    : false,
                                                            "email": userData
                                                                .currentUser
                                                                .email,
                                                            "expected_delivery_time":
                                                                (rush == 2
                                                                    ? noRushData
                                                                        .deliveryHours
                                                                    : regularData
                                                                        .deliveryHours),
                                                            "expected_delivery_date": rush ==
                                                                    2
                                                                ? DateTime.now()
                                                                    .add(Duration(
                                                                        days:
                                                                            7))
                                                                    .toIso8601String()
                                                                : DateTime.now()
                                                                    .add(
                                                                        regularDay)
                                                                    .toIso8601String()
                                                          };
                                                          print(
                                                              "nnnnnnnnnnnnnnn${data}");
                                                          setState(() {
                                                            _orderConfirmed =
                                                                true;
                                                          });
                                                          // await Future.delayed(
                                                          //     Duration(milliseconds: 600));
                                                          print(data);
                                                          print(
                                                              "hitting api for order");

                                                          Map res =
                                                              await ApiServices
                                                                  .postRequestToken(
                                                            json.encode(data),
                                                            createOrderEndPoint,
                                                          );
                                                          print(
                                                              "ffffffffffggggggggggggffffffffffffff${res}");
                                                          if (res["status"] !=
                                                              null) {
                                                            SharedPreferences
                                                                prefs =
                                                                await SharedPreferences
                                                                    .getInstance();

                                                            Map userRes;
                                                            // print(" $token ");
                                                            try {
                                                              userRes = await ApiServices
                                                                  .getRequestToken(
                                                                      userAddEndPoint);
                                                            } catch (e) {
                                                              await prefs
                                                                  .remove(
                                                                      'token');
                                                              setState(() {
                                                                _orderConfirmed =
                                                                    false;
                                                              });
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Server is not responding",
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        400],
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    2,
                                                              );
                                                            }

                                                            if (userRes !=
                                                                null) if (userRes[
                                                                        "addresses"] !=
                                                                    null &&
                                                                (userRes["addresses"] ??
                                                                        [])
                                                                    .isEmpty) {
                                                              // stopLoading();

                                                              stopLoading();

                                                              // Navigator.of(context).pushNamed('/Intro');
                                                            } //user login but didn't register , make islogin false and go to intro
                                                            else if (userRes[
                                                                        "status"] !=
                                                                    null &&
                                                                (userRes["status"] ==
                                                                        false ??
                                                                    true)) {
                                                              await prefs
                                                                  .remove(
                                                                      'token');

                                                              await prefs
                                                                  .setBool(
                                                                      'isLogin',
                                                                      false);

                                                              stopLoading();
                                                            } else {
                                                              //has token and address

                                                              var userProvider =
                                                                  Provider.of<
                                                                          UserData>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              userProvider
                                                                  .setUser(
                                                                      userRes);

                                                              print(
                                                                  "into the order screen");
                                                            } //user data update

                                                            // Provider.of<CartData>(
                                                            //         context,
                                                            //         listen:
                                                            //             false)
                                                            //     .setCartData({
                                                            //   "products": []
                                                            // });

                                                            setState(() {
                                                              _orderConfirmed =
                                                                  false;
                                                            });

                                                            if (payment_id == 1)
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          OrderConfirmation(
                                                                            fromPayment:
                                                                                false,
                                                                            orderIds:
                                                                                res["data"]["orderIds"],
                                                                          )));
                                                            else {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          Payment(
                                                                            transaction:
                                                                                res["txnid"],
                                                                          )));
                                                            }
                                                            // cartdata?.currentCart?.products =
                                                            //     [];

                                                          } //cart res is not null

                                                          else {
                                                            setState(() {
                                                              _orderConfirmed =
                                                                  false;
                                                            });
                                                            // itemData?.quantity += 1;

                                                            Fluttertoast
                                                                .showToast(
                                                              msg: res[
                                                                      "message"] ??
                                                                  "Cart is Empty",
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      400],
                                                              toastLength: Toast
                                                                  .LENGTH_LONG,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER,
                                                              timeInSecForIosWeb:
                                                                  2,
                                                            );
                                                          }
                                                        }
                                                      },
                                                      child: FittedBox(
                                                        fit: BoxFit.fitWidth,
                                                        child: Text(
                                                            "Confirm Order",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: SizeConfig
                                                                            .w *
                                                                        0.035)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            );
                    }));
    });
  }
}

class CheckBoxWid extends FormField<bool> {
  CheckBoxWid({
    Widget title,
    @required BuildContext context,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
    // AutovalidateMode autovalidateMode = AutovalidateMode.disabled
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            // autovalidateMode: autovalidateMode,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Text(
                        state.errorText,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
