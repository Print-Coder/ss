import 'dart:convert';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/auth/AddAddress.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();
  TextEditingController email;
  TextEditingController name;
  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    email = TextEditingController();
    name = TextEditingController();

    // code.text = "dsds";
    getCode();
  }

  getCode() async {
    showLoading();
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print("reg refferal");

      code.text = pref?.getString("regReferal") ?? "";
      stopLoading();
      print("this is code" + pref?.getString("regReferal"));
    } catch (e) {
    }
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    name.dispose();
  }

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "Login & Register",
            needSearch: false, needCart: false, ispop: true),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(top:SizeConfig.h*0.06),
                        // alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        width: SizeConfig.w * 0.93,
                        child: TextFormField(
                          // maxLength: 10,
                          controller: name,
                          validator: userNameValidation,
                          onSaved: (value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('userName', value);
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Your Name *",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            // helperText: "Enter your 10 digit Mobile Number",
                            // helperStyle: TextStyle(
                            //     color: Colors.black45, fontWeight: FontWeight.w400),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).textTheme.title.color),
                            ),
                          ),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        // alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: SizeConfig.h * 0.03),

                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        width: SizeConfig.w * 0.93,
                        child: TextFormField(
                          controller: email,
                          validator: emailValidation,
                          onSaved: (value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('email', value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          // autovalidate: true,
                          decoration: InputDecoration(
                            labelText: "Email *",

                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            // hintText: "9588470333",
                            // helperText: "OTP has been sent on your number 9588470333",
                            helperStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).textTheme.title.color),
                            ),
                          ),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: SizeConfig.h * 0.03),

                        // alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        width: SizeConfig.w * 0.93,
                        child: TextFormField(
                          controller: code,
                          // maxLength: 10,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Refer Code",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            helperText:
                                "Skip this if you don't have refer code",
                            helperStyle: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w400),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).textTheme.title.color),
                            ),
                          ),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),

                      // Spacer(),

                      Container(
                        width: SizeConfig.w * 0.96,
                        margin: EdgeInsets.only(top: SizeConfig.h * 0.03),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: checkBool,
                              focusColor: Theme.of(context).primaryColor,
                              onChanged: _onCheckChange,
                            ),
                            SizedBox(
                              width: SizeConfig.w * 0.4,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("I have read and agreed to the",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 12)
                                    // .copyWith(fontSize: 16),

                                    ),
                              ),
                            ),
                            SizedBox(
                                width: SizeConfig.w * 0.4,
                                child: AutoSizeText("Terms & Conditions",
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14))),
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(bottom: 10),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // margin: EdgeInsets.only(top:SizeConfig.h*0.2 ),
                                width: SizeConfig.w * 0.9,
                                height: 40,
                                child: RaisedButton(
                                  elevation: 0,
                                  color: checkBool
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).accentColor,
                                  onPressed: _isLoading
                                      ? () {}
                                      : () async {
                                          if (checkBool) {
                                            if (_form.currentState.validate()) {
                                              showLoading();

                                              _form.currentState.save();

                                              stopLoading();
                                              String registerName = name.text;
                                              email.clear();
                                              name.clear();
                                              checkBool = false;
                                              if (code?.text?.isNotEmpty ??
                                                  false)
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            AddAddress(
                                                              name:
                                                                  registerName,
                                                              referalCode:
                                                                  code?.text,
                                                            )));
                                              else
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => AddAddress(
                                                            name:
                                                                registerName)));
                                              // Navigator.of(context).pushNamed('/AddAddress');

                                            } //form is not empty
                                            else {
                                              Fluttertoast.showToast(
                                                msg: "Please fill the Form",
                                                backgroundColor:
                                                    Colors.grey[400],
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                              );
                                            } //form is empty
                                          } //terms and cond
                                          else
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Please check the Terms & Conditions",
                                              backgroundColor: Colors.grey[400],
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 3,
                                            );
                                        },
                                  child: Text("Next",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(color: Colors.white)),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
