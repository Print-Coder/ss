import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/productListing/ProductItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SastaDeals extends StatefulWidget {
  SastaDeals({Key key}) : super(key: key);

  @override
  _SastaDealsState createState() => _SastaDealsState();
}

class _SastaDealsState extends State<SastaDeals> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    InAppWebViewController webView;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "Sasta Deals",
          needSearch: true, needCart: true, ispop: false),
      body: Consumer<UserData>(builder: (_, userData, ch) {
        var addObj = userData.currentUser.addresses;
        var userObj = userData.currentUser;
        return SafeArea(
          child: Center(
            child: InAppWebView(
              initialUrl: baseUrl +
                  sastaWebView +
                  "?pincode=${addObj[userObj.addressIndex].zip}&v=1.4",
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                clearCache: true,
                // cacheEnabled: true,
                // debuggingEnabled: true,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
                controller.clearCache();
                controller.addJavaScriptHandler(
                    handlerName: "ADD_CART",
                    callback: (args) async {
                      // Here you receive all the arguments from the JavaScript side
                      // that is a List<dynamic>
//                     cart_type: "sasta"
// pincode: "500072"
// price: 120
// productId: "497239001dt61b"
// quantity: 1
// variantId: "497239002dt60b" pId, vId, price
                      print("From the JavaScript side:");
                      print(args);

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      String pincode = await prefs.getString('pinCode');

                      Map data = Cart().toSastaMap(
                        productId: args[0],
                        quantity: 1,
                        variantId: args[1],
                        price: args[2],
                        pincode: pincode,
                      );
                      Map res = await ApiServices.postRequestToken(
                        json.encode(data),
                        cartEndPoint,
                      );
                      Provider.of<CartData>(context, listen: false)
                          .setCartData(res["data"]);
                      print("From the JavaScript side:");
                      print("added");
                      scaffoldKey.currentState?.showSnackBar(
                        SnackBar(
                            duration: Duration(seconds: 15),
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text("The product has added to cart")),
                      );
                      // Navigator.of(context).pushNamed("/Cart");

                      return "ok";
                    });
                //   controller.addJavaScriptHandler(
                //       handlerName: "PAYMENT_FAILED",
                //       callback: (args) {
                //         // Here you receive all the arguments from the JavaScript side
                //         // that is a List<dynamic>
                //         print("From the JavaScript side:");
                //         print(args);
                //         showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(8)),
                //             // insetPadding:  EdgeInsets.all(20),
                //             titlePadding: EdgeInsets.fromLTRB(15, 30, 0, 10),
                //             contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                //             // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                //             title: Text('Payment has Failed',
                //                 style: Theme.of(context).textTheme.headline3),
                //             content: Text('Move to Cart',
                //                 style: Theme.of(context).textTheme.headline6),
                //             actions: <Widget>[
                //               FlatButton(
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                   Navigator.pop(context);
                //                   Navigator.of(context).pushNamed("/Cart");
                //                 },
                //                 child: Text('Go To Cart',
                //                     style: Theme.of(context).textTheme.headline6),
                //               ),
                //             ],
                //           ),
                //         );
                //         return "ok";
                //       });
              },

              // onLoadStart: (InAppWebViewController controller, String url) {
              //   setState(() {
              //     this.iframeUrl = url;
              //   });
              // },
              // onLoadStop: (InAppWebViewController controller, String url) async {
              //   setState(() {
              //     this.iframeUrl = url;
              //   });
              // },
              // onProgressChanged: (InAppWebViewController controller, int progress) {
              //   setState(() {
              //     this.progress = progress / 100;
              //   });
              // },admin@123 9988776655
            ),
          ),
        );
      }),
    );
  }
}
