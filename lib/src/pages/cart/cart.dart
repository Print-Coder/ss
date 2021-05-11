import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/cartNoItem.dart';
import 'package:ECom/src/pages/cart/cartdetails.dart';
import 'package:ECom/src/pages/orders/orderConfirmation.dart';
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

// import '../elements/CartBottomDetailsWidget.dart';
// import '../elements/CartItemWidget.dart';
// import '../elements/EmptyCartWidget.dart';
import 'CartProductItem.dart';
import 'cartSummary.dart';
import 'api/CartData.dart';
import 'package:ECom/src/pages/home.dart';

class CartWidget extends StatefulWidget {
  CartWidget({
    Key key,
  }) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool checkBool = false;
  bool checkApply = false;
  String payment_type = "cod";
  int payment_id = 1;
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
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCartData(refresh: false);
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
  // NoRushData noRushData;
  String minOrderAmount = "500";
  getCartData({bool refresh}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool("isLogin") ?? false;
    if (isLogin) {
      refresh ? print("refresh is true") : showLoading();

      // await Future.delayed(Duration(milliseconds: 1000));

      Map res = await ApiServices.getRequestToken(cartEndPoint);
      Map minOrderres = await ApiServices.getRequestToken(minOrdAmtEndPoint);
      if (minOrderres != null) {
        if (minOrderres["status"])
          minOrderAmount = minOrderres["data"]["min_order_amount"].toString();
      }
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _orderConfirmed = false;
  bool goback = false;
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
                                                AddAddressButton(
                                                  showIcon: false,
                                                )
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
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13)),
                                                      Text(
                                                          " -  Ph: " +
                                                              userData
                                                                  .currentUser
                                                                  .phone,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13)),
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
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          13))
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
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
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
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),

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
                                                                  .headline6
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12)),
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
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      addAutomaticKeepAlives: true,
                                      itemCount: cartdata
                                              ?.currentCart?.products?.length ??
                                          0,
                                      itemBuilder: (context, ind) {
                                        return
                                            // Expanded(
                                            //   child:
                                            CartProductItem(
                                          key: Key(
                                              "${cartdata?.currentCart?.products[ind].variantId}"),
                                          cartData: cartdata
                                              ?.currentCart?.products[ind],

                                          heroTag: 'details_featured_product',
                                          product: productImg.elementAt(2),
                                          // ),
                                        );
                                      },
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5, color: Colors.grey)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.grey))),
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "Subtotal",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                      Text(
                                                        Helper.getPrice(cartdata
                                                                .currentCart
                                                                ?.subTotal ??
                                                            0.0),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "Delivery Fee",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                      ),
                                                      Text(
                                                        // cartdata.currentCart
                                                        //                 ?.totalShippingPrice !=
                                                        //             null &&
                                                        //         (cartdata.currentCart
                                                        //                     ?.totalShippingPrice ??
                                                        //                 0) >
                                                        //             0
                                                        //     ? Helper.getPrice(
                                                        //         cartdata
                                                        //             .currentCart
                                                        //             ?.totalShippingPrice)
                                                        //     :
                                                        "--",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            top: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .grey))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            "Total",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          Text(
                                                            Helper.getPrice(cartdata
                                                                    .currentCart
                                                                    ?.subTotal ??
                                                                0.0),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: SizeConfig.w * 0.22,
                                            // color: Colors.red,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "Total Saved",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      Helper.getPrice(cartdata
                                                              .currentCart
                                                              ?.totalSaving ??
                                                          0.0),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: goback
                                          ? CircularProgressIndicator()
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              // width: SizeConfig.w * 0.6,
                                              height: 35,
                                              child: RaisedButton(
                                                elevation: 0,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                onPressed: () {
                                                  _NextPressed();
                                                },
                                                child: Text(
                                                    "Proceed to checkout >>",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 16)),
                                              ),
                                            ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "**Free delivery with order value $minOrderAmount and above",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "**Delivery fee is calculated at checkout time",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }));
    });
  }

  _NextPressed() async {
    print("billing addres");
    Map<String, dynamic> data = {
      "is_checkout": true,
    };
    // print("nnnnnnnnnnnnnnn${data}");
    setState(() {
      goback = true;
    });
    // await Future.delayed(
    //     Duration(milliseconds: 600));
    print(data);
    // print("hitting api for back");

    Map res = await ApiServices.postRequestToken(
      json.encode(data),
      removeCashbacksEndPoint,
    );
    // print("ffffffffffggggggggggggffffffffffffff${res}");
    if (res["status"] != null) {
      if (res["status"]) {
        setState(() {
          goback = false;
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CartDetailsWidget(
                  scaffoldKeyCart1: _scaffoldKey,
                )));
      } else {
        setState(() {
          goback = false;
        });
      }
      // cartdata?.currentCart?.products =
      //     [];

    } //cart res is not null

    else {
      // itemData?.quantity += 1;

      Fluttertoast.showToast(
        msg: res["message"] ?? "Cart is Empty",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    }
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
