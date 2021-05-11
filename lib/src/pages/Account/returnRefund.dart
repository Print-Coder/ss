import 'dart:async';

import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ECom/src/helpers/constants.dart';

class ReturnRefund extends StatefulWidget {
  @override
  _ReturnRefundState createState() => new _ReturnRefundState();
}

class _ReturnRefundState extends State<ReturnRefund> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: 3,
        isLogin: true,
      ),
      appBar: AppBarWithPop(context, "Return Refund",
          needSearch: false, needCart: false, ispop: true),
      body: SafeArea(
        child: Center(
          child: InAppWebView(
            initialUrl: baseUrl + returnRefund,
            initialHeaders: {},
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                    // cacheEnabled: true,
                    //debuggingEnabled: true,
                    )),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
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
