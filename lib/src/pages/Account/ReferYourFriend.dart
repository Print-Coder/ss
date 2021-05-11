import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:ECom/src/models/dynamicLink.dart';

class ReferYourFriend extends StatefulWidget {
  ReferYourFriend({
    Key key,
  }) : super(key: key);

  @override
  _ReferYourFriendState createState() => _ReferYourFriendState();
}

class _ReferYourFriendState extends State<ReferYourFriend>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isloading = false;
  Map<String, dynamic> refdata;
  @override
  void initState() {
    super.initState();
    getReferDetails();
  }

  void getReferDetails() async {
    setState(() {
      isloading = true;
    });
    await ApiServices.getRequestToken(
      configRefEndPoint,
    ).then((value) {
      setState(() {
        isloading = false;
      });

      if (value['status']) {
        refdata = value['data'];
      } else {
        refdata = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<UserData>(builder: (context, userData, ch) {
      return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavBar(
            index: 3,
            isLogin: true,
          ),
          appBar: AppBarWithPop(context, "Refer your friends",
              needSearch: true, needCart: true, ispop: true),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: SizeConfig.h * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Text("Buy Together, Save Together",
                            style: Theme.of(context).textTheme.headline6)),
                    SizedBox(
                      height: SizeConfig.h * 0.018,
                    ),
                    Center(
                        child: Text("Group Buying, More Savings",
                            style: Theme.of(context).textTheme.headline6)),
                    SizedBox(
                      height: SizeConfig.h * 0.05,
                    ),
                    Image.asset("assets/icons/referral256.png",
                        color: Theme.of(context).primaryColor,
                        height: SizeConfig.h * 0.2),
                    //  Icon(Icons.add_shopping_cart, size: 100),
                    SizedBox(
                      height: SizeConfig.h * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.w * 0.07,
                          right: SizeConfig.w * 0.07),
                      child: textST1(
                          "Refer friends & family to shopsasta .You will get ${refdata != null ? refdata['referral_cashback_percent'] : '0'}% cashback every time your referral place their order.",
                          fontWeight: FontWeight.w400,
                          textstyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          maxLines: 3),
                    ),
                    SizedBox(
                      height: SizeConfig.h * 0.04,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            // margin: EdgeInsets.only(top: 25, bottom: 25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(5),
                            width: SizeConfig.w * 0.40,
                            height: SizeConfig.w * 0.12,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '${userData.currentUser.referalCode}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.w * 0.025),
                              ),
                            )),
                        Center(
                          child: InkWell(
                              splashColor: Theme.of(context).primaryColor,
                              focusColor: Theme.of(context).primaryColor,
                              highlightColor:
                                  Theme.of(context).primaryColorLight,
                              onTap: () async {
                                String link = await DynamicLinkService()
                                    .createReferLink(
                                        userData.currentUser.referalCode);
                                Share.share(
                                    "Find best deals on Grocery everyday on ShopSasta. Get cashbacks and Save. Share with friends and family and earn. FREE Home Delivery. Install App and use my referral code ${userData.currentUser.referalCode} while signing up $link");
                                // 'The Referal Code for registeration is .Share and earn Cashbacks. ShopSasta Application :$link');
                              },
                              child: shareEarn(context, "Share Code")),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.h * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.w * 0.07,
                          right: SizeConfig.w * 0.07),
                      child: textST3(
                          "** You can use your referral earnings anytime when you place the order",
                          fontWeight: FontWeight.w400,
                          textstyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          maxLines: 2),
                      //  Text(
                      //     "** You can use your referral earnings anytime when you place the order",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline6
                      //         .copyWith(fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
