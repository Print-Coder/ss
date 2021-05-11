import 'dart:convert';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/validations.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/auth/deliveryCoverage.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/pages/widget/selectTypeAddress.dart';
import 'package:ECom/src/models/citiesApi.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({
    Key key,
  }) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  int index = 1;

  String community, name, phone, flat, landmark, street, area, city = " ", zip;
  List<Cities> citiesData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
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

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  // bool checkBool = false;
  // void _onCheckChange(bool newValue) => setState(() {
  //       checkBool = !checkBool;
  //     });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "Add New Delivery Address",
            width: .55, needSearch: false, needCart: false, ispop: true),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                key: _form,
                child: Consumer<UserData>(builder: (_, userData, ch) {
                  return Column(
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
                          // maxLength: 10,
                          keyboardType: TextInputType.text,
                          validator: editAddressValidation,
                          // maxLength: 10,
                          onChanged: (v) {
                            setState(() {
                              community = v;
                            });
                          },
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
                                  color:
                                      Theme.of(context).textTheme.title.color),
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
                          onChanged: (v) {
                            setState(() {
                              name = v;
                            });
                          },
                          keyboardType: TextInputType.text,
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
                                  color:
                                      Theme.of(context).textTheme.title.color),
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
                          // maxLength: 10,
                          // maxLength: 10,
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
                                  color:
                                      Theme.of(context).textTheme.title.color),
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
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w200),
                            alignLabelWithHint: true,
                            fillColor: Colors.green,
                            isDense: true,
                            labelText: "City *",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          searchBoxDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
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
                                .where((e) => e.city
                                    .toLowerCase()
                                    .contains(filter.toLowerCase()))
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
                      SelectTypeAddress(),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Checkbox(
                      //       activeColor: Theme.of(context).primaryColor,
                      //       value: checkBool,
                      //       focusColor: Theme.of(context).primaryColor,
                      //       onChanged: _onCheckChange,
                      //     ),
                      //     setDefaultText(
                      //       context,
                      //     )
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
                                            print(phone);
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
                                            //     zip) {
                                            //   await ApiServices.delRequestToken(
                                            //       cartEndPoint);
                                            //   Provider.of<CartData>(context,
                                            //           listen: false)
                                            //       .setCartData(
                                            //           {"products": []});
                                            // }
                                            // }
                                            Map<String, dynamic> newAdd = {
                                              "apartmentName": community,
                                              // "officeNum": "H101",
                                              // "streetName": "Road Number 6",
                                              //  "Friends Colony",

                                              "setDefault": false,
                                              // checkBool ? true : false,
                                              "addressType": "home",
                                              "name": name,
                                              "phone": tokenphone["phone"],
                                              "officeNum": flat,
                                              "streetName": street,
                                              "landmark": landmark,
                                              "areaDetails": area ?? "emjal",
                                              "city": city ?? "Hyd",
                                              "pinCode": zip ?? "500059"
                                            };
                                            previousAddress.add(newAdd);
                                            Map<String, dynamic> data = {
                                              "name":
                                                  userData.currentUser.name ??
                                                      "Sowmya Chowdam",
                                              "phone": tokenphone["phone"] ??
                                                  "9347980470",
                                              "email":
                                                  userData.currentUser.email ??
                                                      "sowmya@iipl.work",
                                              "addresses": previousAddress,
                                            }; //update
                                            print(data.toString());

                                            Map res = await ApiServices
                                                .postRequestToken(
                                              json.encode(data),
                                              userAddEndPoint,
                                            );
                                            print("res after add address");
                                            print(res);
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
                                                                pincode: zip,
                                                                area: area)));
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
                                  child: Text("Add New Address",
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
                  );
                }),
              )));
  }
}
