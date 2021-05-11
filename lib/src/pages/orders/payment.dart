import 'dart:async';
import 'dart:convert';

import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ECom/src/helpers/constants.dart';

import 'orderConfirmation.dart';

class Payment extends StatefulWidget {
  String transaction;
  Payment({this.transaction});
  @override
  _PaymentState createState() => new _PaymentState();
}

class _PaymentState extends State<Payment> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    print(
      "webview url" + baseUrl + paymentWebView + "${widget.transaction}&v=1.1",
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 25,
        backgroundColor: Colors.white,
        // leading: Container(),
        elevation: 0,
        title: Text(
          "Payment Gateway",
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontFamily: "QuickSand",
                fontWeight: FontWeight.w800,
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: InAppWebView(
            initialUrl:
                baseUrl + paymentWebView + "${widget.transaction}&v=1.1",
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    // cacheEnabled: true,
                    //debuggingEnabled: true,
                    )),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
              // controller.clearCache();
              controller.addJavaScriptHandler(
                  handlerName: "PAYMENT_SUCCESS",
                  callback: (args) {
                    // Here you receive all the arguments from the JavaScript side
                    // that is a List<dynamic>
                    print("From the JavaScript side:");
                    print(args[0]);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => OrderConfirmation(
                              fromPayment: true,
                              transaction: args[1],
                              ssREf: args[2],
                              orderIds: json.decode(args[0]),
                            )));
                    return "ok";
                  });
              controller.addJavaScriptHandler(
                  handlerName: "PAYMENT_FAILED",
                  callback: (args) {
                    // Here you receive all the arguments from the JavaScript side
                    // that is a List<dynamic>
                    print("From the payment failed");
                    print(args);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        // insetPadding:  EdgeInsets.all(20),
                        titlePadding: EdgeInsets.fromLTRB(15, 30, 0, 10),
                        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                        title: Column(
                          children: <Widget>[
                            Text('Payment has Failed', //red
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: Colors.red)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              args[0],
                            ), //red
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed("/Cart");
                            },
                            child: Text('Close',
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ],
                      ),
                    );
                    return "ok";
                  });
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
      ),
    );
  }
}
