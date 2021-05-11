import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  @override
  void dispose() {
    super.dispose();
    // phoneNo.clear();clear
    phoneNo.dispose();
  }

  TextEditingController phoneNo = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          width: SizeConfig.w * 0.93,
          child: TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            controller: phoneNo,
            decoration: InputDecoration(
              labelText: "Mobile Number*",
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              helperText: "Enter your 10 digit Mobile Number",
              helperStyle:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.w400),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).textTheme.title.color),
              ),
            ),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(top: SizeConfig.h * 0.1),
            width: SizeConfig.w * 0.5,
            height: 40,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                : RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 0,
                    color: Theme.of(context).primaryColor,
                    onPressed: _isLoading
                        ? () {}
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (phoneNo?.text.length == 10 &&
                                phoneNo.text != null) {
                              showLoading();

                              // await Future.delayed(Duration(milliseconds: 500));
                              Map<String, dynamic> data = {
                                "phoneNo": phoneNo.text,
                                "screenName": "productdetail"
                              }; //update
                              print(data.toString());
                              // showLoading();
                              Map res = await ApiServices.postRequest(
                                  json.encode(data), loginEndPoint);
                              print("llllllllog${res}");
                              if (res != null) {
                                print("res is not null ${res["status"]}");
                                if (res["status"]) {
                                  print("status is true");
                                  stopLoading();

                                  FocusScope.of(context).unfocus();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => OtpScreen(
                                                phoneNo: phoneNo.text,
                                              )));
                                } //status is true
                                else {
                                  stopLoading();

                                  Fluttertoast.showToast(
                                    msg: res["message"],
                                    backgroundColor: Colors.grey[400],
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                  );
                                } //status is not true
                              } //res is not null
                            } //phone number is empty
                            else {
                              Fluttertoast.showToast(
                                msg: "Please enter your Phone Number",
                                backgroundColor: Colors.grey[400],
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                              );
                            }
                          },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text("Send OTP",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 17, color: Colors.white)),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
