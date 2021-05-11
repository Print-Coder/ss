import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  @required
  UserData userObject;
  Support({
    Key key,
    this.userObject,
  }) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List<String> supportItems = [
    "Orders",
    "Delivery",
    "Payment",
    "Sell with Us",
    "Earnings",
    "Feedback",
    "Registration",
    "App issues"
  ];
  var supportCat = "Orders";
  String details;
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController detailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  @override
  void initState() {
    // if(editIndex)
    emailCon.text = widget.userObject.email;
    phoneCon.text = widget.userObject.phone;
  }

  @override
  void dispose() {
    super.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    detailCon.dispose();
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        key: _scaffoldkey,
        bottomNavigationBar: BottomNavBar(
          index: 3,
          isLogin: true,
        ),
        appBar: AppBarWithPop(context, "Support",
            needSearch: false, needCart: false, ispop: true),
        body: Consumer<UserData>(builder: (context, userData, ch) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(
                        child: Text(
                            "For any queries, please contact our customer support",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: SizeConfig.w * 0.045))),
                    sizeBetween(),
                    Text("What do you need help with?",
                        style: Theme.of(context).textTheme.headline6.copyWith(

                            // fontSize: SizeConfig.w * 0.04
                            )),
                    Container(
                      height: 40,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                      margin: EdgeInsets.only(left: 0.0, top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: new DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        iconSize: 20,
                        icon: Container(
                            // width:15,
                            child: Center(
                                child: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey, size: 30))),
                        key: Key("support"),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        value: "$supportCat",
                        items: supportItems.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            supportCat = v;
                          });
                        },
                      ),
                    ),
                    sizeBetween(),
                    Text("Mobile Number",
                        style: Theme.of(context).textTheme.headline6.copyWith(

                            // fontSize: SizeConfig.w * 0.04
                            )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).accentColor,
                        ),
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      // height: SizeConfig.w * 0.1,
                      child: TextFormField(
                        expands: false,
                        maxLength: 10,
                        controller: phoneCon,
                        validator: phoneValidation,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          // labelText: "Enter your community/ Appartment Name",s

                          // helperText: "Enter your 10 digit Mobile Number",
                          // helperStyle: TextStyle(
                          //     color: Colors.black45, fontWeight: FontWeight.w400),
                          counterStyle: TextStyle(
                            height: double.minPositive,
                          ),
                          counterText: "",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    sizeBetween(),
                    Text("Email",
                        style: Theme.of(context).textTheme.headline6.copyWith(

                            // fontSize: SizeConfig.w * 0.04
                            )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).accentColor,
                        ),
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.only(left: 5),
                      width: double.infinity,
                      // height: SizeConfig.w * 0.1,
                      child: TextFormField(
                        expands: false,
                        validator: emailValidation,
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          // labelText: "Enter your community/ Appartment Name",s

                          // helperText: "Enter your 10 digit Mobile Number",
                          // helperStyle: TextStyle(
                          //     color: Colors.black45, fontWeight: FontWeight.w400),
                          counterStyle: TextStyle(
                            height: double.minPositive,
                          ),
                          counterText: "",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    sizeBetween(),
                    Text("Add Details",
                        style: Theme.of(context).textTheme.headline6.copyWith(

                            // fontSize: SizeConfig.w * 0.04
                            )),
                    Container(
                      height: SizeConfig.h * 0.2,
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                      margin: EdgeInsets.only(left: 0.0, top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: TextFormField(
                        controller: detailCon,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          // labelText: "Flat/House/Office No *",
                          // labelStyle: TextStyle(
                          //   color: Theme.of(context).primaryColor,
                          // ),
                          // helperText: "Enter your 10 digit Mobile Number",
                          // helperStyle: TextStyle(
                          //     color: Colors.black45, fontWeight: FontWeight.w400),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Center(
                      child: _isLoading
                          ? Center(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.h * 0.016, bottom: 10),
                                  padding: EdgeInsets.all(5),
                                  child: CircularProgressIndicator()),
                            )
                          : InkWell(
                              splashColor: Theme.of(context).primaryColor,
                              onTap: () async {
                                if (_form.currentState.validate()) {
                                  Map data = {
                                    "name": userData.currentUser.name,
                                    "email": emailCon.text,
                                    "phone": phoneCon.text,
                                    "que": detailCon.text,
                                    "title": supportCat
                                  };
                                  showLoading();
                                  // await Future.delayed(
                                  //     Duration(milliseconds: 600));

                                  Map res = await ApiServices.postRequestToken(
                                    json.encode(data),
                                    supportEndPoint,
                                  );
                                  if (res["status"]) {
                                    //  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(
                                    //                                       "successfully added to cart")));
                                    print("bottom sheet setting cart");
                                    emailCon.clear();
                                    detailCon.clear();
                                    phoneCon.clear();
                                    FocusScope.of(context).unfocus();
                                    _scaffoldkey.currentState?.showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds:15),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          content: Text(res["message"])),
                                    );
                                    stopLoading();

                                    // Fluttertoast.showToast(
                                    //   msg: "successfully added to cart",
                                    //   backgroundColor: Colors.grey[400],
                                    //   toastLength: Toast.LENGTH_LONG,
                                    //   gravity: ToastGravity.BOTTOM,
                                    //   timeInSecForIosWeb: 2,
                                    // );
                                    // Provider.of<ProductListData>(
                                    //         context,
                                    //         listen: false)
                                    //     .setQuantity(
                                    //         widget
                                    //             ?.productData,
                                    //         widget
                                    //             ?.productData
                                    //             .variant[
                                    //                 variantIndex]
                                    //             .quantity);
                                  } else {
                                    stopLoading();

                                    _scaffoldkey.currentState?.showSnackBar(
                                      SnackBar(
                                          duration: Duration(seconds: 15),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          content: Text(res["message"] ??
                                              "Sorry, Email not sent!!")),
                                    );
                                  }
                                } //form validate
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.h * 0.016, bottom: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: SizeConfig.h * 0.05,
                                  width: double.infinity,
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "SEND",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.w * 0.4,
                            child: Divider(thickness: 1, color: Colors.black),
                          ),
                          Text(
                            "or",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            width: SizeConfig.w * 0.4,
                            child: Divider(thickness: 1, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: SizeConfig.h * 0.1,
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                        )),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/icons/support32.png",
                              height: SizeConfig.h * 0.15,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.w * 0.7,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "+91-9392951057",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: SizeConfig.w * 0.04),
                                      ),
                                      GestureDetector(
                                          child: Image.asset(
                                            "assets/icons/whatsapp.png",
                                            height: SizeConfig.w * 0.08,
                                          ),
                                          onTap: () async => await canLaunch(
                                                  "https://wa.me/message/BIHUFMSVMQUXM1")
                                              ? await launch(
                                                  "https://wa.me/message/BIHUFMSVMQUXM1")
                                              : print("can'rt launch"))
                                    ],
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.w * 0.7,
                                  child: textH5(
                                      "Phone Support is avilable Monday to Saturday 10AM till 7PM",
                                      textstyle: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig.w * 0.04),
                                      maxLines: 2),
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  SizedBox sizeBetween() {
    return SizedBox(
      height: SizeConfig.h * 0.01,
    );
  }
}
