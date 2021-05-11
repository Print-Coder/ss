import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String name;
  String email;
  Profile({Key key, this.name, this.email}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  bool _isEdit = false;
  bool _isEditemail = false;
  TextEditingController name;
  TextEditingController email;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    name.text = widget.name;
    email = TextEditingController();
    email.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          index: 3,
          isLogin: true,
        ),
        appBar: AppBarWithPop(context, "Profile",
            needSearch: false, needCart: false, ispop: true),
        body: SingleChildScrollView(
            child: Consumer<UserData>(builder: (context, userData, ch) {
          return Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.h * 0.08,
                    ),
                    child: Center(
                      child: Image.asset("assets/icons/user1.png",
                          fit: BoxFit.fill,
                          height: SizeConfig.h * 0.11,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.w * 0.56, SizeConfig.w * 0.18, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Image.asset("assets/icons/pencil.png",
                          height: SizeConfig.h * 0.025,
                          color: Theme.of(context).primaryColorLight),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upload Photo",
                    style: Theme.of(context).textTheme.headline4),
              ),
              Container(
                height: SizeConfig.h * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Theme.of(context).accentColor)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(9),
                child: !_isEdit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            userData?.currentUser?.name ?? "Vijay",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _isEdit = true),
                            child: Image.asset("assets/icons/pencil.png",
                                height: SizeConfig.h * 0.025,
                                color: Theme.of(context).accentColor),
                          ),
                        ],
                      )
                    : TextFormField(
                        // maxLength: 10,
                        controller: name,

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          // labelText: "Enter your community/ Appartment Name",

                          // helperText: "Enter your 10 digit Mobile Number",
                          // helperStyle: TextStyle(
                          //     color: Colors.black45, fontWeight: FontWeight.w400),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).textTheme.title.color),
                          ),
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
              ),
              Container(
                height: SizeConfig.h * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Theme.of(context).accentColor)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(9),
                child: !_isEditemail
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            userData?.currentUser?.email ?? "Email",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () => setState(() => _isEditemail = true),
                            child: Image.asset("assets/icons/pencil.png",
                                height: SizeConfig.h * 0.025,
                                color: Theme.of(context).accentColor),
                          ),
                        ],
                      )
                    : TextFormField(
                        // maxLength: 10,
                        controller: email,

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          // labelText: "Enter your community/ Appartment Name",

                          // helperText: "Enter your 10 digit Mobile Number",
                          // helperStyle: TextStyle(
                          //     color: Colors.black45, fontWeight: FontWeight.w400),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).textTheme.title.color),
                          ),
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
              ),
              Container(
                height: SizeConfig.h * 0.06,
                width: SizeConfig.w * 0.98,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1, color: Theme.of(context).accentColor)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(9),
                child: Text(
                  userData?.currentUser?.phone ?? "9000889990",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 18),
                ),
              ),
              Center(
                child: InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  onTap: () async {
                    if (userData.currentUser.name != name.text ||
                        userData.currentUser.email != email.text) {
                      showLoading();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      //   [{
//
//     }]
                      String token = await prefs.getString('token');

                      List<Map<String, dynamic>> previousAddress =
                          List<Map<String, dynamic>>.from((userData
                              .currentUser.addresses
                              ?.map((x) => x.toMap())));

                      Map<String, dynamic> data = {
                        "name": name.text,
                        "phone": userData.currentUser.phone,
                        "email": email.text,
                        // "gender": "female",
                        "addresses": previousAddress

                        // "otp": otp?.text ?? "123456"
                      }; //update
                      print(data.toString());

                      Map res = await ApiServices.postRequestToken(
                        json.encode(data),
                        userAddEndPoint,
                      );
                      print("res after add address");
                      print(res);
                      if (res != null) {
                        if (res["status"]) {
                          print("status is true");
                          var userProvider =
                              Provider.of<UserData>(context, listen: false);

                          userProvider.setUser(res["data"][0]);
                          setState(() {
                            _isEdit = false;
                            _isEditemail = false;
                          });
                          Fluttertoast.showToast(
                            msg: "Changes Saved",
                            backgroundColor: Colors.grey[400],
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                          );
                          stopLoading();
                        } //status is true
                        else {
                          stopLoading();

                          Fluttertoast.showToast(
                            msg: res["message"],
                            backgroundColor: Colors.grey[400],
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                          );
                        } //status is not true
                      } //res is not null
                      else
                        Fluttertoast.showToast(
                          msg: "Something went wrong! Try again",
                          backgroundColor: Colors.grey[400],
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                        );
                    } else
                      Fluttertoast.showToast(
                        msg: "Please enter a different name",
                        backgroundColor: Colors.grey[400],
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                      );
                  },
                  child: Container(
                      height: SizeConfig.h * 0.05,
                      margin: EdgeInsets.only(top: 25, bottom: 25),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _isEdit || _isEditemail
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: SizeConfig.w * 0.5,
                      child: Center(
                        child: Text(
                          "Save Changes",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color:
                                  //  userData.currentUser.name != name.text
                                  //     ?
                                  Colors.white
                              // : Theme.of(context).accentColor
                              ,
                              fontWeight: FontWeight.w300,
                              fontSize: 17),
                        ),
                      )),
                ),
              ),
            ],
          );
        })));
  }
}
