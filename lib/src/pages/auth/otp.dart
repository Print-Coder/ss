import 'dart:async';
import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/category.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/auth/AddAddress.dart';
import 'package:ECom/src/pages/auth/register.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/pages/home.dart';

class OtpScreen extends StatefulWidget {
  String phoneNo;
  OtpScreen({Key key, this.phoneNo}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String paramPhone;
  // void callSnackBar(String msg) {
  //   print(msg + "snack msg");
  //   final Snack = new snack.SnackBar(
  //     content: new Text(msg),
  //     duration: new Duration(seconds: 3),
  //   );
  //   _scaffoldkey.currentState.showSnackBar(Snack);
  // }
  bool _resendEnable = false, _resendLoading = false;
  void initState() {
    super.initState();
    phnNo = TextEditingController(text: widget.phoneNo ?? "1234567890");

    otp = TextEditingController();
    enableResend();
    PhoneNo = widget.phoneNo;
  }

  enableResend() async {
    Future.delayed(Duration(minutes: 5)).then((d) {
      if (mounted)
        setState(() {
          _resendEnable = true;
        });
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    otp.dispose();

    super.dispose();
  }

  showLoading() => setState(() {
        _isLoading = true;
        _resendEnable = false;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  String PhoneNo;
  TextEditingController phnNo;
  TextEditingController otp;

  bool checkBool = false;
  bool checkApply = false;

  void _onCheckApply(bool newValue) => setState(() {
        checkApply = !checkApply;
      });
  void _onCheckChange(bool newValue) => setState(() {
        checkBool = !checkBool;
      });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
//
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "OTP",
          needSearch: false, needCart: false, ispop: true),
      body: Form(
        key: _form,
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.h * 0.12),
                child: Center(
                    child: new Text(
                  "Enter OTP",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 25, color: Theme.of(context).primaryColor),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.h * 0.05),
                child: new Text(
                  "OTP has been sent on your number ${PhoneNo}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 12.0),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.h * 0.08),
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                  width: SizeConfig.w * 0.68,
                  height: SizeConfig.w * 0.2,
                  child: TextFormField(
                    maxLength: 6,
                    // autovalidate: true,

                    controller: otpController,
                    validator: otpValidation,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      helperText: "Note: OTP is valid for 5 minutes",
                      helperStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                          fontWeight: FontWeight.w400),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).textTheme.title.color),
                      ),
                    ),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.h * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _resendLoading
                        ? SizedBox(
                            width: SizeConfig.w * 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          )
                        : FlatButton(
                            splashColor: _resendEnable && !_isLoading
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).accentColor,
                            onPressed: _resendEnable && !_isLoading
                                ? () async {
                                    Map<String, dynamic> data = {
                                      "phoneNo": PhoneNo,
                                      "screenName": "productdetail"
                                    }; //update
                                    print(data.toString());
                                    setState(() {
                                      _resendLoading = true;
                                    });
                                    // showLoading();
                                    Map res = await ApiServices.postRequest(
                                        json.encode(data), loginEndPoint);
                                    print(res);
                                    if (res != null) {
                                      print("res is not null ${res["status"]}");
                                      if (res["status"]) {
                                        print("status is true");
                                        //
                                        setState(() {
                                          _resendLoading = false;
                                          _resendEnable = false;
                                        });
                                        enableResend();
                                        FocusScope.of(context).unfocus();

                                        Fluttertoast.showToast(
                                          msg:
                                              "OTP has been sent on your number ${PhoneNo}",
                                          backgroundColor: Colors.grey[400],
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                        );
                                      } //status is true
                                      else {
                                        setState(() {
                                          _resendEnable = true;
                                          _resendLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                          msg: res["message"],
                                          backgroundColor: Colors.grey[400],
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                        );
                                      } //status is not true
                                    }
                                  }
                                : () {},
                            child: Text("RESEND OTP",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: _resendEnable && !_isLoading
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).accentColor,
                                    )),
                          ),
                    _isLoading
                        ? SizedBox(
                            width: SizeConfig.w * 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            splashColor: Theme.of(context).primaryColor,
                            focusColor: Theme.of(context).primaryColor,
                            highlightColor: Theme.of(context).primaryColorLight,
                            child: new Text(
                              'VERIFY OTP  ',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onTap: _isLoading
                                ? () {}
                                : () async {
                                    if (otpController.text.length == 6) {
                                      showLoading();
                                      // await Future.delayed(
                                      //     Duration(milliseconds: 700));
                                      Map<String, dynamic> data = {
                                        "phoneNo": PhoneNo,
                                        "otp": otpController?.text ?? "123456"
                                      }; //update
                                      print(data);
                                      Map res = await ApiServices.postRequest(
                                          json.encode(data), verifyOtpEndPoint);
                                      print("otp respponse");
                                      // print(res);
                                      if (res != null) {
                                        print(
                                            "res is not null ${res["status"] ?? "k"}");
                                        if (res["status"]) {
                                          print("status is true");
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.remove('token');
                                          await prefs.setString(
                                              'token', res["token"]);

                                          Fluttertoast.showToast(
                                            msg: res["message"],
                                            backgroundColor: Colors.grey[400],
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 2,
                                          );
                                          otpController.clear();
                                          print("res in otp");
                                          print(res);
                                          if (res["data"] != null) {
                                            if (res["data"]["addresses"] ==
                                                    null ||
                                                res["data"]["addresses"]
                                                    ?.isEmpty) {
                                              stopLoading();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Register()));
                                            } else {
                                              print("user provider");
                                              var userProvider =
                                                  Provider.of<UserData>(context,
                                                      listen: false);
                                              userProvider.setUser(res["data"]);
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              Map cartRes = await ApiServices
                                                  .getRequestToken(
                                                      cartEndPoint);
                                              print(
                                                  "after otp cart response $cartRes");
                                              if (cartRes["status"] ?? false)
                                                Provider.of<CartData>(context,
                                                        listen: false)
                                                    .setCartData(
                                                        cartRes["data"]);

                                              await prefs.setBool(
                                                  "isLogin", true);
                                              final FirebaseMessaging
                                                  _firebaseMessaging =
                                                  FirebaseMessaging();
                                              String firebaseToken;
                                              await _firebaseMessaging
                                                  .getToken()
                                                  .then((String token) {
                                                // assert(token != null);
                                                firebaseToken = token;
                                              }).catchError((e) =>
                                                      print(e.toString()));

                                              Map<String, dynamic>
                                                  fireBasedata = {
                                                "phone": json.decode(
                                                    ascii.decode(base64.decode(
                                                        base64.normalize(
                                                            res["token"]
                                                                    .split(".")[
                                                                1]))))["phone"],
                                                "token": firebaseToken

                                                // "otp": otp?.text ?? "123456"
                                              }; //update
//firebase format
                                              await ApiServices.putRequest(
                                                json.encode(fireBasedata),
                                                firebaseEndPoint,
                                              );
                                              int addIndex = res["data"]
                                                      ["addresses"]
                                                  .indexWhere((a) =>
                                                      a["setDefault"] == true);
                                              await prefs.setString(
                                                  'pinCode',
                                                  res["data"]["addresses"]
                                                      [addIndex ?? 0]["pinCode"]
                                                  // Provider.of<UserData>(context)
                                                  //     .addresses[addIndex]
                                                  //     .zip
                                                  );
                                              stopLoading();
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/Pages',
                                                      arguments: RouteArgument(
                                                          id: "0",
                                                          isLogin: true));
                                            }
                                          } //data is null in otp response
                                          else {
                                            stopLoading();
                                            print(await prefs
                                                .getString("regReferal"));
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        Register()));
                                          }
                                          // Navigator.of(context).pushNamed('/AddAddress');
                                        } //status is true
                                        else {
                                          stopLoading();
                                          setState(() {
                                            _resendEnable = true;
                                          });
                                          Fluttertoast.showToast(
                                            msg: res["message"],
                                            backgroundColor: Colors.grey[400],
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                          );
                                        } //status is false
                                      } //res is not null

                                      else {
                                        stopLoading();
                                      }
                                    } //form is not empty
                                    else {
                                      stopLoading();

                                      Fluttertoast.showToast(
                                        msg: "Please enter the OTP",
                                        backgroundColor: Colors.grey[400],
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                      );
                                    }
                                  },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
