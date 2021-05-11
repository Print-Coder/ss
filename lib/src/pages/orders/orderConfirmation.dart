import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/models/dynamicLink.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:share/share.dart';
import 'package:ECom/src/pages/widget/widgets.dart';

class OrderConfirmation extends StatefulWidget {
  List<dynamic> orderIds;
  bool fromPayment;
  String transaction, ssREf;
  OrderConfirmation(
      {Key key,
      this.orderIds,
      this.fromPayment = false,
      this.ssREf,
      this.transaction})
      : super(key: key);

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  String orderId = "";
  @override
  void initState() {
    super.initState();
    // print("before error");
    // widget.orderIds.forEach((or) => orderId += or["number"] + ", \n");
    for (int i = 0; i < (widget?.orderIds?.length ?? 0) - 1; i++)
      orderId += widget.orderIds[i]["number"] + ", \n";
    orderId += widget.orderIds[widget.orderIds.length - 1]["number"];
//segregate with |
    // getOrderData();
    getReferDetails();
    makeCartEmpty();
  }

  makeCartEmpty() async {
    await Future.delayed(Duration(seconds: 1)).then((e) =>
        Provider.of<CartData>(context, listen: false)
            .setCartData({"products": []}));
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  bool _isCart = false;
  getOrderData() async {
    showLoading();
    // await Future.delayed(Duration(milliseconds: 1000));

    Map res = await ApiServices.getRequestToken(getOrderEndPoint);
    if (res != null) {
      // print("init of cart");
      // print(res["data"]["products"].isEmpty);
      // print(res["status"] == false);
      if (res["status"] && res["data"]["products"].isNotEmpty) {
        // Provider.of<CartData>(context, listen: false).setCartData(res["data"]);
        stopLoading();
        setState(() {
          _isCart = true;
        });
      } //status is true
      else if (res["status"] == false || res["data"]["products"].isEmpty) {
        stopLoading();
        setState(() {
          _isCart = false;
        });
        // Navigator.of(context).pushNamed("/CartNoItem");
      }
    } else {
      stopLoading();
    } //status is not true
  }

  Map<String, dynamic> refdata;
  bool isloading = false;
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

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: 0,
        isLogin: true,
      ),
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "Order Confirmation",
          needSearch: false, needCart: false, ispop: false),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
          return Future.value(true);
        },
        child: Consumer<UserData>(builder: (context, userData, ch) {
          return ListView(
            padding: EdgeInsets.only(left: 10),
            children: <Widget>[
              SizedBox(
                height: SizeConfig.h * (widget.fromPayment ? 0.1 : 0.2),
              ),
              widget.fromPayment
                  ? Center(
                      child: Text(
                        "Payment Sucessfull!",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.green, fontSize: 15),
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                      size: SizeConfig.h * 0.13),
                  Container(
                    width: SizeConfig.w * 0.58,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: SizedBox(
                            width: SizeConfig.w * 0.55,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "Thank you for the Order",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                      width: SizeConfig.w * 0.18,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Order No:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                        ),
                                      ))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                      width: SizeConfig.w * 0.35,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          " ${orderId != null ? orderId.toString() : ""}",
                                          softWrap: true,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        widget.fromPayment
                            ? SizedBox(
                                width: SizeConfig.w * 0.525,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "Ref ID: ${widget.ssREf}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                            color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              )
                            : Container(),
                        //   child: Text(
                        //     "Order Amount:  ₹487",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline5
                        //         .copyWith(color: Colors.black, fontSize: 15),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
              widget.fromPayment
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(
                                    width: SizeConfig.w * 0.85,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Paytm Ref ID:  ${widget.transaction}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 15),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ))
                  : Container(),
              // items(context, "ShopSasta(in 48 hours)"),
              // Divider(
              //   height: 25,
              //   thickness: 1,
              // ),
              // items(context, "XYZ"),
              // Divider(
              //   height: 15,
              //   thickness: 1,
              // ),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50, bottom: 25),
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
                                },
                                child: shareEarn(context, "SHARE & EARN")),
                          ),
                        ),
                        Center(
                          child: InkWell(
                            splashColor: Theme.of(context).primaryColor,
                            onTap: () => Navigator.of(context)
                                .pushNamed("/OrderHistory"),
                            child: Container(
                                margin: EdgeInsets.only(top: 50, bottom: 25),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: SizeConfig.w * 0.3,
                                child: Center(
                                  child: Text(
                                    "My Orders",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
              Container(
                  // width: 25,
                  // height: 25,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: BoxBorder(),
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    // color: i == index
                    //     ? Theme.of(context).primaryColor
                    //     : Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Referral/Shared Earnings",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17),
                      ),
                      textST1(
                          "Refer friends & family to shopsasta .You will get ${refdata != null ? refdata['referral_cashback_percent'] : '0'}% cashback every time your referral place their order.",
                          fontWeight: FontWeight.w400,
                          textstyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          maxLines: 3),
                    ],
                  )),
            ],
          );
        }),
      ),
    );
  }

  Column items(BuildContext context, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Items delivered by $text",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Theme.of(context).primaryColor, fontSize: 16),
        ),
        Divider(
          height: 8,
          thickness: 1,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: SizeConfig.w * 0.7,
                      child: Center(
                        child: Text(
                          "Items",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: SizeConfig.w * 0.25,
                      child: Text(
                        "Qty",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Aashirvaad Atta- Whole Wheat",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      "2",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "FREEDOM Refined Sunflower Oil",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      "1",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ]),
      ],
    );
  }
}
