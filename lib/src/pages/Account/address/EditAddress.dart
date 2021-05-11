import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/auth/deliveryCoverage.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/pages/widget/selectTypeAddress.dart';

class EditAddress extends StatefulWidget {
  int editIndex, length;
  bool checkBool;
  @required
  Address userObject;
  EditAddress(
      {Key key, this.editIndex, this.length, this.userObject, this.checkBool})
      : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  int index = 1;

  TextEditingController name, phone, flat, landmark, street, area, city, zip;
  @override
  void initState() {
    // if(editIndex)
    checkBool = widget.checkBool;
    nameController.text = widget.userObject.name;
    communityController.text = widget.userObject.community;

    flatController.text = widget.userObject.officeNum;
    streetController.text = widget.userObject.street;
    landmarkController.text = widget.userObject.landmark;
    areaController.text = widget.userObject.area;
    cityController.text = widget.userObject.city;
    zipController.text = widget.userObject.zip;
    super.initState();
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool checkBool = false;
  // void _onCheckChange(bool newValue) => setState(() {
  //       checkBool = !checkBool;
  //     });
  TextEditingController areaController = TextEditingController();
  TextEditingController communityController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "Edit Address",
            needSearch: false, needCart: false, ispop: true),
        body: SingleChildScrollView(
            child: Form(
                key: _form,
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                        // maxLength: 10,
                        controller: communityController,

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Enter your community/ Appartment Name",

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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      width: SizeConfig.w * 0.93,
                      child: TextFormField(
                        validator: editAddressValidation,
                        // maxLength: 10,

                        // addObj[addressIndex].name.replaceRange(0, 1, addObj[addressIndex].name[0].toUpperCase())} ${userData.currentUser.addressIndex == addressIndex ? "(Default)" : ""}",
                        //                             // Ph: ${userData.currentUser.phone}",
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .headline6),
                        //                         Text(
                        //                             !addObj[addressIndex]
                        //                                     .street
                        //                                     .contains("///")
                        //                                 ? addObj[addressIndex]
                        //                                     .street
                        //                                 : addObj[addressIndex]
                        //                                         .street
                        //                                         .split("///")[0] +
                        //                                     ", " +
                        //                                     addObj[addressIndex]
                        //                                         .street
                        //                                         .split("///")[1] +
                        //                                     ", " +
                        //                                     addObj[addressIndex]
                        //                                         .street
                        //                                         .split("///")[2] +
                        //                                     ", " +
                        //                                     userData
                        //                                         .currentUser
                        //                                         .addresses[
                        //                                             addressIndex]
                        //                                         .area
                        //                             // "H 101, White Arcade, Friends Clony,"
                        //                             ,
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .headline6),
                        //                         Text(
                        //                             userData
                        //                                         .currentUser
                        //                                         .addresses[
                        //                                             addressIndex]
                        //                                         .city +
                        //                                     ", " +
                        //                                     userData
                        //                                         .currentUser
                        //                                         .addresses[
                        //                                             addressIndex]
                        //                                         .zip ??
                        //                                 "Road No6, Chandanagar, Hyd- 500050",
                        //                             style: Theme.of(context)
                        //                                 .textTheme
                        //                                 .headline6),
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name *",
                          // labelStyle: TextStyle(
                          //   color: Theme.of(context).primaryColor,
                          // ),
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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      width: SizeConfig.w * 0.93,
                      child: TextFormField(
                        // maxLength: 10,
                        validator: editAddressValidation,

                        controller: flatController,

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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      width: SizeConfig.w * 0.93,
                      child: TextFormField(
                        // maxLength: 10,
                        validator: editAddressValidation,

                        controller: streetController,

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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      width: SizeConfig.w * 0.93,
                      child: TextFormField(
                        // maxLength: 10,
                        validator: editAddressValidation,

                        //controller: TextEditingController(text: landmark),

                        // maxLength: 10,
                        // maxLength: 10,
                        controller: landmarkController,

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
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      width: SizeConfig.w * 0.93,
                      child: TextFormField(
                        // maxLength: 10,
                        //controller: TextEditingController(text: area),

                        validator: editAddressValidation,

                        controller: areaController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Area details *",
                          //  h
                          // prefixText: addObj.area,
                          // labelStyle: TextStyle(
                          //   color: Theme.of(context).primaryColor,
                          // ),
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
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 15),

                          // alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                          width: SizeConfig.w * 0.4,
                          child: TextFormField(
                            // maxLength: 10,
                            validator: editAddressValidation,
                            enabled: false,

                            controller: cityController,

                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "City *",
                              // labelStyle: TextStyle(
                              //   color: Theme.of(context).primaryColor,
                              // ),
                              // helperText: "Enter your 10 digit Mobile Number",
                              // helperStyle: TextStyle(
                              //     color: Colors.black45, fontWeight: FontWeight.w400),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .textTheme
                                        .title
                                        .color),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Container(
                          // alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 0),
                          padding: EdgeInsets.only(left: 15, right: 15, top: 6),
                          width: SizeConfig.w * 0.4,
                          child: TextFormField(
                            maxLength: 6,
                            enabled: false,
                            validator: zipValidation,
                            controller: zipController,
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
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .textTheme
                                        .title
                                        .color),
                              ),
                            ),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                    SelectTypeAddress(),
                    // Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Checkbox(
                    //       activeColor: Theme.of(context).primaryColor,
                    //       value: checkBool,
                    //       focusColor: Theme.of(context).primaryColor,
                    //       onChanged: (widget.length > 1)
                    //           ? (b) => {_onCheckChange(b)}
                    //           : (b) {},
                    //     ),
                    //     SizedBox(
                    //       width: SizeConfig.w * 0.8,
                    //       child: FittedBox(
                    //         fit: BoxFit.fitWidth,
                    //         child: Text(
                    //           "Set this as my default delivery address",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .headline5
                    //               // .copyWith(fontSize: 12)
                    //               .copyWith(fontSize: 16),
                    //         ),
                    //       ),
                    //     ),
                    //     // FittedBox(
                    //     //   fit: BoxFit.fitWidth,
                    //     //   child: Text("Terms & Conditions",
                    //     //       style: Theme.of(context).textTheme.headline5.copyWith(
                    //     //             color: Theme.of(context).primaryColor,
                    //     //           )
                    //     //       // .copyWith(fontSize: 16),
                    //     //       ),
                    //     // ),
                    //   ],
                    // ),
                    Center(
                      child: _isLoading
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : Consumer<UserData>(builder: (_, userData, ch) {
                              var addObj =
                                  Provider.of<UserData>(context, listen: false)
                                      .currentUser
                                      .addresses[widget.editIndex];

                              return Container(
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
                                                await SharedPreferences
                                                    .getInstance();
                                            //   [{
//
//     }]
                                            String token =
                                                await prefs.getString('token');
                                            Map tokenphone = json.decode(
                                                ascii.decode(base64.decode(
                                                    base64.normalize(
                                                        token.split(".")[1]))));
                                            String mainName = await prefs
                                                .getString('userName');
                                            String emailId =
                                                await prefs.getString('email');
                                            print(tokenphone);
                                            List<Map<String, dynamic>>
                                                previousAddress =
                                                List<Map<String, dynamic>>.from(
                                                    (userData
                                                        .currentUser.addresses
                                                        ?.map(
                                                            (x) => x.toMap())));
                                            // if (checkBool) {
                                            //   previousAddress.any((a) =>
                                            //       a["setDefault"] = false);

                                            // if (userData
                                            //         .currentUser
                                            //         .addresses[userData
                                            //             .currentUser
                                            //             .addressIndex]
                                            //         .zip !=
                                            //     zipController.text) {
                                            //   await ApiServices
                                            //       .delRequestToken(
                                            //           cartEndPoint);
                                            //   Provider.of<CartData>(context,
                                            //           listen: false)
                                            //       .setCartData(
                                            //           {"products": []});
                                            // }
                                            // }
                                            Map<String, dynamic> newAdd = {
                                              "apartmentName":
                                                  communityController.text,
                                              // "officeNum": "H101",
                                              // "streetName": "Road Number 6",
                                              //  "Friends Colony",

                                              "setDefault": widget.checkBool
                                                  ? true
                                                  : false,
                                              "addressType": "home",
                                              "name": nameController.text,
                                              "phone": tokenphone["phone"],
                                              "officeNum": flatController.text,
                                              "streetName":
                                                  streetController.text,
                                              "landmark":
                                                  landmarkController.text,
                                              "areaDetails":
                                                  areaController.text,
                                              "city":
                                                  cityController.text ?? "Hyd",
                                              "pinCode": zipController.text
                                            };

                                            previousAddress[widget.editIndex] =
                                                newAdd;
                                            print(
                                                "previous add arra$previousAddress");
                                            Map<String, dynamic> data = {
                                              "name": userData.currentUser.name,
                                              "phone": tokenphone["phone"] ??
                                                  "9347980470",
                                              "email":
                                                  userData.currentUser.email ??
                                                      "sowmya@iipl.work",
                                              // "gender": "female",
                                              "addresses": previousAddress

                                              // "otp": otp?.text ?? "123456"
                                            }; //update
                                            print(data.toString());

                                            Map res = await ApiServices
                                                .postRequestToken(
                                              json.encode(data),
                                              userAddEndPoint,
                                            );
                                            print("res after add address");
                                            // print(res);
                                            if (res != null) {
                                              if (res["status"]) {
                                                print("status is true");
                                                var userProvider =
                                                    Provider.of<UserData>(
                                                        context,
                                                        listen: false);

                                                userProvider
                                                    .setUser(res["data"][0]);

                                                // _form.currentState.save();
                                                // Fluttertoast.showToast(
                                                //   msg: res["message"],
                                                //   backgroundColor: Colors.grey[400],
                                                //   toastLength: Toast.LENGTH_LONG,
                                                //   gravity: ToastGravity.CENTER,
                                                //   timeInSecForIosWeb: 2,
                                                // );

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
                                                stopLoading();
                                                FocusScope.of(context)
                                                    .unfocus();

                                                Navigator.of(context).pop();
                                              } //status is true
                                              else {
                                                stopLoading();

                                                Fluttertoast.showToast(
                                                  msg: res["message"],
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 2,
                                                );
                                                FocusScope.of(context)
                                                    .unfocus();

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            DeliveryCoverage(
                                                                pincode:
                                                                    zipController
                                                                        .text,
                                                                area:
                                                                    areaController
                                                                        .text)));
                                                ;
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

                                  child: Text("Save Address",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17)),
                                ),
                              );
                            }),
                    ),
                  ],
                ))));
  }
}
