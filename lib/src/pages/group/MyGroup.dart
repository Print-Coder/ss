import 'dart:convert';

import 'package:ECom/src/models/dynamicLink.dart';
import 'package:intl/intl.dart';

import 'groupApi.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/helpers/autoText.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key key}) : super(key: key);

  @override
  _MyGroupState createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  Map<String, dynamic> refdata;
  @override
  void initState() {
    super.initState();

    getGroupData(refresh: false);
  }

  String pinCode, message;
  GroupData groupData;
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });

  bool _isLoading = false;
  getGroupData({
    bool refresh,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool("isLogin") ?? false;
    if (isLogin) {
      if (refresh) {
        // pinCode = pincode;

        print("refresh is true");
      } else {
        setState(() {
          pinCode = Provider.of<UserData>(context, listen: false)
              .currentUser
              .addresses[0]
              .zip;
        });

        showLoading();
      }
      await ApiServices.getRequestToken(
        configRefEndPoint,
      ).then((value) {
        if (value['status']) {
          refdata = value['data'];
        } else {
          refdata = null;
        }
      });
      // await Future.delayed(Duration(milliseconds: 1000));
      Map res = await ApiServices.postRequestToken(
          json.encode({
            "pincodes": [pinCode]
          }),
          userGroupEndPoint);
      print(res);
      if (res != null) {
        // print("init of cart");
        // print(res["data"]["products"].isEmpty);
        // print(res["status"] == false);
        if ((res["status"] ?? false) && (res["data"]?.isNotEmpty ?? false)) {
          groupData = GroupData.fromMap(res["data"][0]);
          stopLoading();
        } //status is true
        else if (res["status"] == false || res["data"].isEmpty) {
          groupData = null;
          message = res["message"] ?? "No Group cashBack yet";
          stopLoading();
          print("refresh is true");

          // groupData = GroupData.fromMap(res["data"][0]);
          // Navigator.of(context).pushNamed("/CartNoItem");
        }
      } else {
        stopLoading();
      } //status is not true
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "My Group Orders",
            needSearch: true, needCart: true, ispop: false),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<UserData>(builder: (context, userData, ch) {
                var userObj = userData.currentUser;
                var userAddObj = userObj.addresses[userObj.addressIndex];

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textH5("Your Group Score this week",
                            textstyle: TextStyle(
                                color: Theme.of(context).accentColor)),
                      ),

                      // GroupDetails(
                      //   pincode: userAddObj.zip,
                      //   orderCount: "87",
                      // ),
                      Container(
                        // height: SizeConfig.h * 0.4,
                        // width: 200,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0.1),
                        decoration: BoxDecoration(
                          // border: BoxBorder(),
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  textH4("Pin Code ",
                                      textstyle: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  Container(
                                    height: 30,
                                    width: SizeConfig.w * 0.3,
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 2, right: 5),
                                    margin: EdgeInsets.only(left: 8.0, top: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).accentColor,
                                            width: 1)),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      iconSize: 20,
                                      icon: Container(
                                          // width:15,
                                          child: Center(
                                              child: Icon(Icons.arrow_drop_down,
                                                  color: Colors.grey,
                                                  size: 30))),
                                      // key: Key(widget.product),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      value: pinCode,
                                      items: userData.currentUser.addresses
                                          .map((e) => e.zip)
                                          .toList()
                                          .toSet()
                                          .map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: textH5(
                                            value,
                                            textstyle:
                                                TextStyle(color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (v) {
                                        print(v);
                                        setState(() {
                                          pinCode = v;
                                        });
                                        getGroupData(refresh: true);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // groupData?.cashbackPercent != null
                            //     ? Align(
                            //         alignment: Alignment.centerLeft,
                            //         child: textST3(
                            //           "Cashback Amount:${groupData?.cashbackPercent}",
                            //           fontWeight: FontWeight.w400,
                            //           textstyle: TextStyle(
                            //               color: Theme.of(context).accentColor),
                            //           // maxLines: 1
                            //         ),
                            //       )
                            //     : Container(),
                            groupData?.cashbackPercent != null
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: textST2(
                                        "Your community received the total ${groupData?.cashbackPercent ?? 0}%  cashback last week. You can place an order now and receive the cashback on your order between  ${groupData?.minVal ?? 0}%  - ${groupData?.maxVal ?? 0}%.",
                                        // "Your community is qualified to get ${groupData?.cashbackPercent ?? 0}% cashback till now. You can place an order now and save ${groupData?.cashbackPercent ?? 0}% on your order as a cashback.",
                                        fontWeight: FontWeight.w400,
                                        textstyle: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                        maxLines: 4),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: textST2(
                                        "Your community is qualified to get 0% cashback till now.You can place an order now and save 0% on your order as a cashback",
                                        fontWeight: FontWeight.w400,
                                        textstyle: TextStyle(
                                            color:
                                                Theme.of(context).accentColor),
                                        maxLines: 4),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: textST2(
                                  "The more your community buys. The more cashback you get",
                                  fontWeight: FontWeight.w400,
                                  textstyle: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  maxLines: 2),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            textST1(
                                "Refer friends & family to shopsasta .You will get ${refdata != null ? refdata['referral_cashback_percent'] : '0'}% cashback every time your referral place their order.",
                                fontWeight: FontWeight.w400,
                                textstyle: TextStyle(
                                    color: Theme.of(context).accentColor),
                                maxLines: 3),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Center(
                                    child: InkWell(
                                        splashColor:
                                            Theme.of(context).primaryColor,
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        highlightColor:
                                            Theme.of(context).primaryColorLight,
                                        onTap: () async {
                                          String link =
                                              await DynamicLinkService()
                                                  .createReferLink(userData
                                                      .currentUser.referalCode);
                                          Share.share(
                                              "Find best deals on Grocery everyday on ShopSasta. Get cashbacks and Save. Share with friends and family and earn. FREE Home Delivery. Install App and use my referral code ${userData.currentUser.referalCode} while signing up $link");

                                          // 'The Referal Code for registeration is .Share and earn Cashbacks. shopsasta Application :com.shopsasta.app');
                                        },
                                        child:
                                            shareEarn(context, "SHARE & EARN")),
                                  ),
                                  Center(
                                    child: InkWell(
                                      splashColor:
                                          Theme.of(context).primaryColor,
                                      onTap: () => Navigator.of(context)
                                          .pushNamed("/Pages", arguments: 0),
                                      child: Container(
                                          // margin: EdgeInsets.only(
                                          //   top: 25,
                                          // ),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: SizeConfig.w * 0.3,
                                          child: Center(
                                            child: Text(
                                              "SHOP",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
              }));
  }
}
