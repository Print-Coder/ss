import 'package:ECom/src/models/orderData.dart';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/splash_screen_controller.dart';
import 'package:provider/provider.dart';
import '../../src/models/userData.dart';
import 'cart/api/CartData.dart';
import 'home.dart';
import '../../src/models/dynamicLink.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'orders/orderDetails.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  // SplashScreenController _con;

  // SplashScreenState() : super(SplashScreenController()) {
  //   _con = controller;
  // }
  String token;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String firebaseToken;
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<bool, String> arg = await DynamicLinkService().handleDynamicLinks();

    print("inside navigation $arg");

    await Future.delayed(Duration(milliseconds: 1000));
    // prefs.setString('token',
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6Ijc3MDIyMzE4ODkiLCJpYXQiOjE2MTg5NzkzMjUsImV4cCI6MTYzNDUzMTMyNX0.lLDzO3S3BZAiclt5wsUouzQ6EngiqCHnNIl4XxWOILI");
    token = await prefs.getString('token');

    if (token != null) {
      Map res;
      print(" $token ");
      try {
        res = await ApiServices.getRequestToken(
          userAddEndPoint,
        );
        print(res);
      } catch (e) {
        await prefs.remove('token');

        print("inside catch");

        await prefs.setBool('isLogin', false);
        if (arg.keys.toList()[0]) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductWidget(
                        fromDeep: true,
                        linker: arg[true],
                      )));

          print("arg is not null${arg[true]}");
        } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
          prefs.setString("regReferal", arg[false]);
          Navigator.of(context).pushReplacementNamed('/Pages',
              arguments: RouteArgument(id: "0", isLogin: false));
        } else
          Navigator.of(context).pushReplacementNamed('/Pages',
              arguments: RouteArgument(id: "0", isLogin: false));

        Fluttertoast.showToast(
          msg: "Check your Internet Connection",
          backgroundColor: Colors.grey[400],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
        );
      }
//fcm

      await _firebaseMessaging.getToken().then((String token) {
        // assert(token != null);
        firebaseToken = token;
      }).catchError((e) => print(e.toString()));
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.subscribeToTopic('order');

      if (res != null) if (res["addresses"] != null &&
          (res["addresses"] ?? []).isEmpty) {
        // stopLoading();
        await prefs.setBool('isLogin', false);

        if (arg.keys.toList()[0]) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductWidget(
                        fromDeep: true,
                        linker: arg[true],
                      )));

          print("arg is not null${arg[true]}");
        } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
          print("arg is not null${arg[false]}");

          prefs.setString("regReferal", arg[false]);
          Navigator.of(context).pushReplacementNamed('/Intro');
        } else
          Navigator.of(context).pushReplacementNamed('/Intro');
      } //user login but didn't register , make islogin false and go to intro
      else if (res["status"] != null && res["status"] == false ?? true) {
        await prefs.remove('token');
//The Referal Code for registeration is D580E08.Share and earn Cashbacks. Shossasta Application :https://shopsasta.page.link/SC1q66dsZiRPk6xZ6
        await prefs.setBool('isLogin', false);

        if (arg.keys.toList()[0]) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductWidget(
                        fromDeep: true,
                        linker: arg[true],
                      )));

          print("arg is not null${arg[true]}");
        } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
          prefs.setString("regReferal", arg[false]);
          Navigator.of(context).pushReplacementNamed('/Intro');
        } else
          Navigator.of(context).pushReplacementNamed('/Intro');
      } else {
        await prefs.setBool('isLogin', true);
        String tokenPhone = json.decode(ascii.decode(
            base64.decode(base64.normalize(token.split(".")[1]))))["phone"];
        Map<String, dynamic> fireBasedata = {
          "phone": tokenPhone,
          "token": firebaseToken

          // "otp": otp?.text ?? "123456"
        }; //update
        await ApiServices.putRequest(
          json.encode(fireBasedata),
          firebaseEndPoint,
        );
        print("firebase token update in splash" + firebaseToken);
        var userProvider = Provider.of<UserData>(context, listen: false);
        userProvider.setUser(res);
        // userProvider.setAddressIndexwithList(
        //     List<Address>.from(res["addresses"]?.map((x) => x.toMap())));

        // await prefs.setString('pinCode', userProvider.addresses[addIndex].zip);
        if (arg.keys.toList()[0]) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductWidget(
                        fromDeep: true,
                        linker: arg[true],
                      )));

          print("arg is not null${arg[true]}");
        }
        //  else {
        //   prefs.setString("regReferal", arg[false]);
        // }
        else
          Navigator.of(context).pushReplacementNamed('/Pages',
              arguments: RouteArgument(id: "0", isLogin: true));
      }
    } //no token so go to Intro
    else {
      await prefs.setBool('isLogin', false);
//Onions is available at best price ₹20.0. Find best deals on Grocery everyday on ShopSasta. Get cashbacks and Save. Share with friends and family and earn. FREE Home Delivery. https://shopsasta.page.link/tsLvjtEWFKVxjQkT9
      print("token is  null");
      if (arg.keys.toList()[0]) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductWidget(
                      fromDeep: true,
                      linker: arg[true],
                    )));

        print("arg is not null${arg[true]}");
      } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
        prefs.setString("regReferal", arg[false]);
        Navigator.of(context).pushReplacementNamed('/Intro');
      } else
        Navigator.of(context).pushReplacementNamed('/Intro');
    }
  }
  // _con.progress.addListener(() {
  //   double progress = 0;
  //   _con.progress.value.values.forEach((_progress) {
  //     progress += _progress;
  //   });
  // if (progress == 20) {

  // }
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/icons/SHOPSASTA_ICON.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
