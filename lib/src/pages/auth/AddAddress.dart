import 'dart:convert';
import 'package:ECom/src/models/citiesApi.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/pages/widget/selectTypeAddress.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'deliveryCoverage.dart';

class AddAddress extends StatefulWidget {
  String referalCode;
  String name;
  AddAddress({Key key, this.name, this.referalCode}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  int index = 1;
  List<Cities> citiesData = [];
  String community, name, phone, flat, landmark, street, area, city, zip;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    nameControl.text = widget.name;
  }

  getAddress() async {
    showLoading();
    List<dynamic> res = await ApiServices.getRequestList(cityEndPoint);
    print("all address");
    print(res);
    stopLoading();
    if (res != null)
      res.forEach((x) => citiesData.add(Cities.fromMap(x)));
    else {
      citiesData.add(Cities(city: "Hyderabad", state: "Telangana"));
      citiesData.add(Cities(city: "Kukatpally", state: "Telangana"));
      print("check your internet connection");
    }
  }

  bool nameEdit = true;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool checkBool = false;
  bool checkApply = false;

  void _onCheckApply(bool newValue) => setState(() {
        checkApply = !checkApply;
      });
  void _onCheckChange(bool newValue) => setState(() {
        checkBool = !checkBool;
      });
  TextEditingController nameControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "Add Delivery Address",
            width: 0.5, needSearch: false, needCart: false, ispop: true),
        body: SingleChildScrollView(
            child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Please enter the accurate address with a landmark , it will help us to server you better",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  validator: editAddressValidation,
                  onChanged: (v) {
                    setState(() {
                      community = v;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Community/ Appartment Name",
                    labelStyle: TextStyle(
                        // fontSize: 14,
                        // color: Theme.of(context).primaryColor,
                        ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  // enabled:nameEdit,nameEdit
                  controller: nameControl,
                  validator: editAddressValidation,
                  // maxLength: 10,
                  // onChanged: (v) {
                  //   setState(() {
                  //     name = v;
                  //   });
                  // },name
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name *",
// suffixIcon: IconButton(icon:Icon(Icons.edit),onPressed: ()=>setState((){
//   nameEdit=!nameEdit;
// }),),
                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  // maxLength: 10,
                  validator: editAddressValidation,
                  onChanged: (v) {
                    setState(() {
                      flat = v;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Flat/House/Office No *",

                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  // maxLength: 10,
                  validator: editAddressValidation,
                  onChanged: (v) {
                    setState(() {
                      street = v;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Street Name *",
                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  // maxLength: 10,
                  validator: editAddressValidation,
                  onChanged: (v) {
                    setState(() {
                      landmark = v;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Landmark *",
                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                width: SizeConfig.w * 0.93,
                child: TextFormField(
                  // maxLength: 10,
                  validator: editAddressValidation,
                  onChanged: (v) {
                    setState(() {
                      area = v;
                    });
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Area details *",
                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
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
                // margin: EdgeInsets.only(
                //   bottom: 32,
                // ),

                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15, right: 0, top: 0),
                width: SizeConfig.w * 0.9,
                child: DropdownSearch<String>(
                  autoFocusSearchBox: true,
                  showClearButton: true,
                  validator: (s) {
                    print("validate $s");
                    if (s == null)
                      return "Please select a city from dropdown";
                    else {
                      return null;
                    }
                  },
                  autoValidate: false,
                  // maxHeight: 25,
                  dropDownSearchDecoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w200),
                    alignLabelWithHint: true,
                    fillColor: Colors.green,
                    isDense: true,
                    labelText: "City *",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  searchBoxDecoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),

                    // focusedBorder: InputBorder(borderSide: )
                  ),
                  // items: citiesData.map((c) => c.city).toList(),
                  showSearchBox: true,
                  mode: Mode.BOTTOM_SHEET,
                  // label: "Name",
                  onFind: (String filter) async {
                    // await Fut
                    return citiesData
                        .where((e) =>
                            e.city.toLowerCase().contains(filter.toLowerCase()))
                        .toList()
                        .map((c) => c.city)
                        .toList();
                  },
                  // itemAsString: (String u) => u,
                  onChanged: (v) {
                    // _form.currentState.validate();
                    setState(() {
                      city = v;
                    });
                    print(v);
                  },
                ),
                //  DropdownSearch<String>(
                //     mode: Mode.MENU,
                //     showSelectedItem: true,
                //     items: citiesData.map((c) => c.city).toList(),
                //     label: "Menu mode",
                //     // popupItemDisabled: (String s) =>
                //     //     s.startsWith('I'),
                //     onChanged: print,
                //     selectedItem: citiesData[0].city),
                //  TextFormField(
                //   // maxLength: 10,
                //   validator: editAddressValidation,
                //   onChanged: (v) {
                //     setState(() {
                //       city = v;
                //     });
                //   },
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(
                //     labelText: "City *",
                //     // labelStyle: TextStyle(
                //     //   color: Theme.of(context).primaryColor,
                //     // ),
                //     // helperText: "Enter your 10 digit Mobile Number",
                //     // helperStyle: TextStyle(
                //     //     color: Colors.black45, fontWeight: FontWeight.w400),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //           color: Theme.of(context).primaryColor),
                //     ),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //           color: Theme.of(context)
                //               .textTheme
                //               .title
                //               .color),
                //     ),
                //   ),
                //   style: Theme.of(context).textTheme.headline5,
                // ),
              ),
              Container(
                // alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 0, bottom: 5),
                padding: EdgeInsets.only(left: 15, right: 15, top: 6),
                width: SizeConfig.w * 0.4,
                child: TextFormField(
                  maxLength: 6,
                  validator: zipValidation,
                  onChanged: (v) {
                    setState(() {
                      zip = v;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "PinCode *",
                    // labelStyle: TextStyle(
                    //   color: Theme.of(context).primaryColor,
                    // ),
                    // helperText: "Enter your 10 digit Mobile Number",
                    // helperStyle: TextStyle(
                    //     color: Colors.black45, fontWeight: FontWeight.w400),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).textTheme.title.color),
                    ),
                  ),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SelectTypeAddress(),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: true,
                    focusColor: Theme.of(context).primaryColor,
                    onChanged: _onCheckChange,
                  ),
                  setDefaultText(
                    context,
                  )
                  // FittedBox(
                  //   fit: BoxFit.fitWidth,
                  //   child: Text("Terms & Conditions",
                  //       style: Theme.of(context).textTheme.headline5.copyWith(
                  //             color: Theme.of(context).primaryColor,
                  //           )
                  //       // .copyWith(fontSize: 16),
                  //       ),
                  // ),
                ],
              ),
              Center(
                child: _isLoading
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 10),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // margin: EdgeInsets.only(top:SizeConfig.h*0.2 ),
                        width: SizeConfig.w * 0.8,
                        height: 40,
                        child: RaisedButton(
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          onPressed: _isLoading
                              ? () {}
                              : () async {
                                  if (_form.currentState.validate()) {
                                    showLoading();
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    //   [{
//
//     }]
                                    String token =
                                        await prefs.getString('token');
                                    Map tokenphone = json.decode(ascii.decode(
                                        base64.decode(base64
                                            .normalize(token.split(".")[1]))));
                                    // String mainName =
                                    //     await prefs.getString('userName');
                                    String emailId =
                                        await prefs.getString('email');
                                    print(phone);
                                    Map<String, dynamic> data;
                                    if (widget.referalCode != null) {
                                      print(widget?.referalCode ?? "no code");
                                      data = {
                                        "name": nameControl.text,
                                        "phone": tokenphone["phone"],
                                        "email": emailId ?? "sowmya@iipl.work",
                                        "referred_by":
                                            widget?.referalCode ?? "",
                                        "addresses": [
                                          {
                                            "apartmentName": community,
                                            // "officeNum": "H101",
                                            // "streetName": "Road Number 6",
                                            //  "Friends Colony",

                                            "setDefault": true,
                                            "addressType": "home",
                                            "name": nameControl.text,
                                            "phone": tokenphone["phone"],
                                            "officeNum": flat,
                                            "streetName": street,
                                            "landmark": landmark,
                                            "areaDetails": area ?? "emjal",
                                            "city": city ?? "Hyd",
                                            "pinCode": zip ?? "500072"
                                            // "apartmentName": "mearguda",
                                            // // "officeNum": "H101",
                                            // // "streetName": "Road Number 6",
                                            // //  "Friends Colony",

                                            // "setDefault": true,
                                            // "addressType": "home",
                                            // "name": "harish",
                                            // "phone": tokenphone["phone"],
                                            // "officeNum": "3-22/3",
                                            // "streetName": "mallapur",
                                            // "landmark": "near temple",
                                            // "areaDetails": "golconda",
                                            // "city": "Hyd",
                                            // "pinCode": "500072"
                                          }
                                        ]
                                        // "otp": otp?.text ?? "123456"
                                      }; //update
                                    } else {
                                      data = {
                                        "name": nameControl.text,
                                        "phone": tokenphone["phone"],
                                        "email": emailId ?? "sowmya@iipl.work",

                                        "addresses": [
                                          {
                                            "apartmentName": community,
                                            // "officeNum": "H101",
                                            // "streetName": "Road Number 6",
                                            //  "Friends Colony",

                                            "setDefault": true,
                                            "addressType": "home",
                                            "name": nameControl.text,
                                            "phone": tokenphone["phone"],
                                            "officeNum": flat,
                                            "streetName": street,
                                            "landmark": landmark,
                                            "areaDetails": area ?? "emjal",
                                            "city": city ?? "Hyd",
                                            "pinCode": zip ?? "500072"
                                            // "apartmentName": "mearguda",
                                            // // "officeNum": "H101",
                                            // // "streetName": "Road Number 6",
                                            // //  "Friends Colony",

                                            // "setDefault": true,
                                            // "addressType": "home",
                                            // "name": "harish",
                                            // "phone": tokenphone["phone"],
                                            // "officeNum": "3-22/3",
                                            // "streetName": "mallapur",
                                            // "landmark": "near temple",
                                            // "areaDetails": "golconda",
                                            // "city": "Hyd",
                                            // "pinCode": "500072"
                                          }
                                        ]
                                        // "otp": otp?.text ?? "123456"
                                      }; //update
                                    }
                                    print(data.toString());

                                    Map res =
                                        await ApiServices.postRequestToken(
                                      json.encode(data),
                                      userAddEndPoint,
                                    );
                                    print("res after add address");
                                    print(res);
                                    if (res != null) {
                                      print(
                                          "res is not null ${res["status"] ?? "k"}");
                                      if (res["status"]) {
                                        print("status is true");

                                        var userProvider =
                                            Provider.of<UserData>(context,
                                                listen: false);
                                        userProvider.setUser(res["data"][0]);
                                        // (addIndex >
                                        //                       userProvider
                                        //                               .currentUser
                                        //                               .addresses
                                        //                               .length -
                                        //                           1
                                        //                   ? 0
                                        //                   : addIndex)
                                        // if (checkBool) {

                                        await prefs.setString('pinCode', zip);
                                        // }
                                        Map cartRes =
                                            await ApiServices.getRequestToken(
                                                cartEndPoint);

                                        if (cartRes["status"])
                                          Provider.of<CartData>(context,
                                                  listen: false)
                                              .setCartData(cartRes["data"]);
                                        // otp.clear();
                                        // email.clear();
                                        // name.clear();
                                        // checkBool = false;
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => AddAddress(
                                        //               phoneNo: widget.phoneNo,
                                        //             )));
                                        prefs.setString("isLogin", "true");
                                        await prefs.setBool("isLogin", true);

//------------------firebase push notification--------------------------
                                        final FirebaseMessaging
                                            _firebaseMessaging =
                                            FirebaseMessaging();
                                        String firebaseToken;
                                        await _firebaseMessaging
                                            .getToken()
                                            .then((String token) {
                                          // assert(token != null);

                                          firebaseToken = token;

                                          print("for register of user fcm" +
                                                  token ??
                                              "v");
                                        }).catchError(
                                                (e) => print(e.toString()));

                                        Map<String, dynamic> fireBasedata = {
                                          "phone": json.decode(ascii.decode(
                                              base64.decode(base64.normalize(
                                                  token.split(
                                                      ".")[1]))))["phone"],
                                          "token": firebaseToken

                                          // "otp": otp?.text ?? "123456"
                                        }; //update
                                        await ApiServices.putRequest(
                                          json.encode(fireBasedata),
                                          firebaseEndPoint,
                                        );
//--------------------------------firebase token-----------------------------------------------
//--------------------------------stock status--------------------------
                                        Map<String, dynamic> stockStatusData = {
                                          "pincode": zip

                                          // "otp": otp?.text ?? "123456"
                                        }; //update
                                        Map stockRes =
                                            await ApiServices.postRequest(
                                          json.encode(stockStatusData),
                                          stockStatusEndPoint,
                                        );

                                        stopLoading();

//0 1 2 3 4 5 6 7 8 9
                                        print(!stockRes["stockStatus"]);
                                        if (!stockRes["stockStatus"]) {
                                          stopLoading();
                                          FocusScope.of(context).unfocus();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DeliveryCoverage(
                                                        isAddress: true,
                                                      )));
                                        }
                                        stopLoading();
                                        FocusScope.of(context).unfocus();

                                        Navigator.of(context)
                                            .pushReplacementNamed('/Pages',
                                                arguments: RouteArgument(
                                                    id: "0", isLogin: true));
                                      } //status is true
                                      else {
                                        var userProvider =
                                            Provider.of<UserData>(context,
                                                listen: false);
                                        userProvider.setRegister(area, zip);
                                        stopLoading();
                                        FocusScope.of(context).unfocus();

                                        Fluttertoast.showToast(
                                          msg: res["message"],
                                          backgroundColor: Colors.grey[400],
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                        );
                                        FocusScope.of(context).unfocus();

                                        Navigator.of(context)
                                            .pushNamed('/DeliveryCoverage');
                                      } //status is not true
                                    } //res is not null
                                  } //form is not empty
                                  else
                                    Fluttertoast.showToast(
                                      msg: "Please fill the Form",
                                      backgroundColor: Colors.grey[400],
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                    );
                                },
//                     {
//
// }

                          child: Text("Complete Registration",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17)),
                        ),
                      ),
              ),
            ],
          ),
        )));
  }
}
