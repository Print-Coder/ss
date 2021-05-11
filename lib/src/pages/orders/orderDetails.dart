import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/models/orderData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ECom/src/helpers/autoText.dart';

class OrderDetails extends StatefulWidget {
  OrderData orderData;

  OrderDetails({
    Key key,
    this.orderData,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: 3,
        isLogin: true,
      ),
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "Order Details",
          needSearch: true, needCart: true, ispop: true, fcm: false),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.only(left: 10, right: 10),
          // decoration: BoxDecoration(
          //   // border: BoxBorder(),
          //   border: Border.all(width: 1, color: Theme.of(context).accentColor),
          //   borderRadius: BorderRadius.all(Radius.circular(2)),
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: TabBar(
                  tabs: <Tab>[
                    new Tab(
                      text: "Details",
                      icon: new Icon(Icons.info_outline),
                    ),
                    new Tab(
                      text: "Items",
                      icon: new Icon(Icons.list),
                    ),
                  ],
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  controller: _tabController,
                ),
              ),

              Container(
                //  color: Colors.black,
                height: SizeConfig.h * 0.7,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          Text(
                            "Order Details",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17),
                          ),
                          // Center(
                          //   child: InkWell(
                          //     splashColor: Theme.of(context).primaryColor,
                          //     onTap: () {},
                          //     // Navigator.of(context).pushNamed("/OrderDetails"),
                          //     child: Container(
                          //         // margin: EdgeInsets.only(top: 25, bottom: 25),
                          //         decoration: BoxDecoration(
                          //           color: Theme.of(context).primaryColor,
                          //           borderRadius: BorderRadius.circular(5),
                          //         ),
                          //         padding: EdgeInsets.all(5),
                          //         width: SizeConfig.w * 0.35,
                          //         child: Center(
                          //           child: FittedBox(
                          //             fit: BoxFit.fitWidth,
                          //             child: Text(
                          //               "Track Your Order",
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .bodyText1
                          //                   .copyWith(color: Colors.white),
                          //             ),
                          //           ),
                          //         )),
                          //   ),
                          // ),
                          // ],
                          // ),
                          orderContent(context, widget.orderData),
                          // Divider(
                          //   thickness: 1,
                          // ),
                          //        "delivery_type": "shop-sasta",
                          //         "quantity": 1,
                          //         "variantId": "453062002op60b",
                          //         "cartId": "453062001op61b-453062002op60b",
                          //         "price": 70,
                          //         "mrp": 100
                          //     }
                          // ],
                          // "price": 70,
                          // "totalShippingPrice": 0,
                          // "mrp": 100,
                          // "delivery_type": "shop-sasta",
                          // "SubTotal": 70,
                          // "count": 1,

                          tab2(),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Text(
                            "${widget.orderData.orderItems.length} " +
                                (widget.orderData.orderItems.length > 1
                                    ? "products "
                                    : "product ") +
                                "${widget.orderData.count} " +
                                (widget.orderData.count > 1
                                    ? "items "
                                    : "item ") +
                                " in the cart",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17),
                          ),
                        ),
                        Expanded(child: _buildList()),
                      ],
                    ),
                  ],
                ),
              ),

//              Container(
//                height: SizeConfig.h * 0.1,
//                // width: SizeConfig.w * 0.8,
//                margin: EdgeInsets.only(top: 15),
//                child: ListView.builder(
//                    padding: EdgeInsets.symmetric(horizontal: 5),
//                    // shrinkWrap: true,
//                    scrollDirection: Axis.horizontal,
//                    itemCount: widget.orderData.orderItems.length,
//                    itemBuilder: (context, i) {
//                      return CachedNetworkImage(
//                        imageUrl: awsLink +
//                            widget.orderData.orderItems[i].pictures[0] +
//                            ".jpg",
//                        fit: BoxFit.fill,
//                        width: 100,
//                        placeholder: (context, url) => Image.asset(
//                          'assets/img/loading.gif',
//                          fit: BoxFit.fill,
//                          width: 100,
//
//                          // width: double.infinity,
//                          height: 100,
//                        ),
//                        errorWidget: (context, url, error) => Icon(Icons.image),
//                      );
//                    }),
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        //shrinkWrap: true,
        // scrollDirection: Axis.horizontal,

        itemCount: widget.orderData.orderItems.length,
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              productContent(context, widget.orderData.orderItems[i]),
            ],
          );
        });
  }

  Widget tab2() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 1,
        ),
        Text(
          "Payment Details",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
          textAlign: TextAlign.left,
        ),
        paymentContent(context, widget.orderData),
        Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Total",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black, fontSize: 16.5)),
            Text(
              Helper.getOrderPrice(widget.orderData?.price ?? 0),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        Text(
          "Delivery Address",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //                "street": "strt two",
              // "area": "emjal",
              // "city": "Hyd",
              // "zip": "500059"
              Text((widget?.orderData?.name ?? " ").capitalizeFirstofEach,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),
              Text(
                  (widget?.orderData?.apartmentName ?? " ")
                      .capitalizeFirstofEach
                  // "H 101, White Arcade, Friends Clony,"
                  ,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),
              Text(
                  '${(widget?.orderData?.officeNum ?? " ").capitalizeFirstofEach},${(widget?.orderData?.street ?? " ").capitalizeFirstofEach}'
                  // "H 101, White Arcade, Friends Clony,"
                  ,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),
              Text(
                  '${(widget?.orderData?.landmark ?? " ").capitalizeFirstofEach},${(widget?.orderData?.area ?? " ").capitalizeFirstofEach}'
                  // "H 101, White Arcade, Friends Clony,"
                  ,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),

              Text(
                  '${widget.orderData.city.capitalizeFirstofEach},${widget.orderData.zip.capitalizeFirstofEach}'
                  // "H 101, White Arcade, Friends Clony,"
                  ,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )), // Text(
              //     !widget.orderData.deliverystreet.contains("///")
              //         ? widget
              //             .orderData.deliverystreet.capitalizeFirstofEach
              //         : widget.orderData.deliverystreet
              //             .split("///")[2]
              //             .capitalizeFirstofEach

              //     // "H 101, White Arcade, Friends Clony,"
              //     ,
              //     style: Theme.of(context).textTheme.headline6.copyWith(
              //           color: Colors.black,
              //           fontSize: 15,
              //         )),
              // Text(
              //     widget.orderData.deliverystreet
              //                 .city +
              //             ", " +
              //             widget.orderData.deliverystreet
              //                 .zip ??
              //         "Road No6, Chandanagar, Hyd- 500050",
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline6),
              Text(
                  '${widget.orderData.email != null ? widget.orderData.email : ''}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),
              Text(
                  "Ph: ${widget.orderData.phone != null ? widget.orderData.phone : ''}",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      )),
              widget.orderData.status == "Order Placed"
                  ? isloading
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                          child: Center(
                            child: InkWell(
                              splashColor: Theme.of(context).primaryColor,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text(" shopsata"),
                                        content: Text(
                                            "Are you sure do you want cancel your order?"),
                                        actions: [
                                          FlatButton(
                                            child: Text("cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              setState(() {
                                                isloading = true;
                                              });
                                              await ApiServices
                                                  .postRequestToken(
                                                json.encode({
                                                  "id":
                                                      "${widget.orderData.orderDataId}",
                                                  "phone":
                                                      "${widget.orderData.iduser}"
                                                }),
                                                cancelOrderEndPoint,
                                              ).then((value) {
                                                setState(() {
                                                  isloading = false;
                                                });
                                                if (value['status']) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Your order successfully canceled");

                                                  back();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Your order cancelation failed");
                                                }
                                              });
                                            },
                                          ),
                                        ]);
                                  },
                                );
                              },
                              // Navigator.of(context).pushNamed("/OrderDetails"),
                              child: Container(
                                  // margin: EdgeInsets.only(top: 25, bottom: 25),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  width: SizeConfig.w * 0.35,
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  back() {
    Navigator.of(context).pop();
  }

  Row orderContent(BuildContext context, OrderData orderData) {
    SizedBox sizeText(Text text) {
      return SizedBox(
        // width: SizeConfig.w * 0.25,
        child: FittedBox(
          fit: BoxFit.cover,
          child: text,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: SizeConfig.w * 0.5,
          height: SizeConfig.h * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              sizeText(
                Text(
                  "Order date",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              sizeText(
                Text(
                  "Order No",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      // .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              sizeText(
                Text(
                  "Expected Delivery Date",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      // .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              orderData?.expected_delivery_time != null
                  ? sizeText(
                      Text(
                        "Expected Delivery Time",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            // .bodyText2
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    )
                  : Container(),
              sizeText(
                Text(
                  "No of Items",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      // .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              sizeText(
                Text(
                  "Order Status",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              // orderData.status.toLowerCase() == "refunded"
              //     ? sizeText(
              //         Text(
              //           "Refund Amount",
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyText2
              //               .copyWith(color: Colors.black, fontSize: 14),
              //         ),
              //       )
              //     : ConstrainedBox(constraints: BoxConstraints(minHeight: 0,maxHeight: 0)),
              // orderData.status.toLowerCase() == "refunded"
              // ? sizeText(
              //     Text(
              //       "Refund Type",
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodyText2
              //           .copyWith(color: Colors.black, fontSize: 14),
              //     ),
              //   )
              // : ConstrainedBox(constraints: BoxConstraints(minHeight: 0,maxHeight: 0)),

              // orderData.status.toLowerCase() == "refunded" &&
              //         orderData.referalId != null
              //     ? sizeText(
              //         Text(
              //           "Refund Id",
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodyText2
              //               .copyWith(color: Colors.black, fontSize: 14),
              //         ),
              //       )
              //     : ConstrainedBox(constraints: BoxConstraints(minHeight: 0,maxHeight: 0)),

              sizeText(
                Text(
                  "Deliver By",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              //delivery date
              sizeText(
                Text(
                  "Payment mode",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
              sizeText(
                Text(
                  "Total Amount",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: SizeConfig.w * 0.36,
          height: SizeConfig.h * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                orderData?.datecreated != null
                    ? DateFormat('EEE MMM d yyyy')
                        .format(orderData.datecreated)
                        .toString()
                    : " ",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                    ),
              ),
              Text(
                orderData.number ?? "1",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
              ),
              Text(
                orderData?.expected_delivery_date != null
                    ? orderData.expected_delivery_date.toString()
                    : " ",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
              ),
              orderData?.expected_delivery_time != null
                  ? Text(
                      orderData.expected_delivery_time.toString(),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                    )
                  : Container(),
              Text(
                (orderData.count ?? 1).toString() +
                    (orderData.count > 1 ? " items" : " item"),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
              ),
              Text(
                orderData.status,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
              // orderData.status.toLowerCase() == "refunded"
              //     ? Text(
              //         Helper.getOrderPrice(double.parse(
              //             (orderData.refund_amount ?? 0).toString())),
              //         style: Theme.of(context).textTheme.headline6.copyWith(
              //               color: Colors.black,
              //               fontSize: 15,
              //             ),
              //       )
              //     : SizedBox(height: 0),
              // orderData.status.toLowerCase() == "refunded"
              //     ? Text(
              //         orderData.refund_type,
              //         style: Theme.of(context)
              //             .textTheme
              //             .headline6
              //             .copyWith(color: Colors.black, fontSize: 14),
              //       )
              //     : SizedBox(),
              // orderData.status.toLowerCase() == "refunded" &&
              //         orderData.referalId != null
              //     ? Text(
              //         orderData.referalId,
              //         style: Theme.of(context)
              //             .textTheme
              //             .headline6
              //             .copyWith(color: Colors.black, fontSize: 14),
              //       )
              //     : Container(),
              Text(
                orderData?.deliveryType == "shop-sasta"
                    ? "shopsasta"
                    : orderData?.deliveryType ?? "shopsasta"
                // orderData.deliveryType
                ,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
              Text(
                (orderData?.tag == "cod" ?? true)
                    ? "Cash On Delivery"
                    : "Online",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black, fontSize: 14),
              ),
              Text(
                Helper.getOrderPrice(
                    double.parse((orderData.price ?? 0).toString())),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row productContent(BuildContext context, OrderItem orderItem) {
    var requiredvariant = orderItem?.variant;
    return Row(
      //mainAxisAlignment: MainAxisAlignment.s,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: awsLink + orderItem.pictures[0] + ".jpg",
          fit: BoxFit.fill,
          width: 100,
          placeholder: (context, url) => Image.asset(
            'assets/img/loading.gif',
            fit: BoxFit.fill,
            width: 100,

            // width: double.infinity,
            height: 100,
          ),
          errorWidget: (context, url, error) => Icon(Icons.image),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                //width: SizeConfig.w * 0.4,
                child: AutoSizeText(
                  orderItem.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              AutoSizeText(
                "(${requiredvariant.title})",
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                ),
                child: AutoSizeText(
                  "${orderItem.quantity} x ${Helper.getPrice((orderItem.price ?? 0) / orderItem.quantity)}",
                  maxLines: 1,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        // Spacer(),
      ],
    );
  }

  Row paymentContent(BuildContext context, OrderData orderData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  "Cart Value",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  "Delivery Fee",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
              orderData?.discount != null && (orderData?.discount ?? 0) > 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Text(
                        "Coupon Discount",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black, fontSize: 15),
                      ),
                    )
                  : Container(),
              orderData?.wallet_amount != null &&
                      (orderData?.wallet_amount ?? 0) > 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Text(
                        "Cashback Discount",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black, fontSize: 15),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  Helper.getOrderPrice(orderData.subTotal ?? 0),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Text(
                  Helper.getOrderPrice(orderData?.totalShippingPrice ?? 0),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
              orderData?.discount != null && (orderData?.discount ?? 0) > 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Text(
                        "- " + Helper.getOrderPrice(orderData?.discount ?? 0),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.red, fontSize: 15),
                      ),
                    )
                  : Container(),
              orderData?.wallet_amount != null &&
                      (orderData?.wallet_amount ?? 0) > 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Text(
                        "- " +
                            Helper.getOrderPrice(orderData?.wallet_amount ?? 0),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.red, fontSize: 15),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
