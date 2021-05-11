import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/orderData.dart';
import 'package:ECom/src/pages/orders/orderConfirmation.dart';
import 'package:ECom/src/pages/orders/orderDetails.dart';
import 'package:ECom/src/pages/orders/orderDetailsRefund.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalOrder extends StatefulWidget {
  LocalOrder({Key key}) : super(key: key);

  @override
  _LocalOrderState createState() => _LocalOrderState();
}

class _LocalOrderState extends State<LocalOrder> {
  @override
  void initState() {
    super.initState();
    getOrderData();
  }

  List<OrderData> OrderList = new List<OrderData>();

  List<OrderData> ActiveList = new List<OrderData>();
  List<OrderData> PastList = new List<OrderData>();
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

    Map OrderListRes =
        await ApiServices.postRequestToken('''{}''', getOrderEndPoint);
    if (OrderListRes != null) {
      // if (res!=null ) {
      stopLoading();

      // List<Map<String,dynamic>> OrderListRes =
      // await ApiServices.postRequestListToken('''{}''', getOrderEndPoint);
      OrderList = List<OrderData>.from(
          (OrderListRes["items"]?.map((x) => OrderData.fromMap(x))) ?? []);
      // print('hhhhhhhhhhhhhh${OrderList[OrderList.length - 1].status}');
      OrderList.forEach((element) {
        if (element.status.toLowerCase() == "delivered" ||
            element.status.toLowerCase() == "cancelled" ||
            element.status.toLowerCase() == "refunded") {
          PastList.add(element);
        } else {
          ActiveList.add(element);
        }
      });
      // } //status is true
      // else if (res["status"] == false || res["data"]["products"].isEmpty) {
      //   stopLoading();
      //
      //   // Navigator.of(context).pushNamed("/CartNoItem");
      // }
    } else {
      stopLoading();
    } //status is not true
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 15),
            child: SingleChildScrollView(
              child: OrderList == []
                  ? Center(
                      child: Text("No Orders yet"),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                          child: Text(
                            "Active Orders",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, sepearatedIndecx) {
                              return Container(height: 10)
                                  //  Divider(
                                  //   thickness: 1,
                                  //   color: Theme.of(context).dividerColor,
                                  // )
                                  ;
                            },
                            itemCount: ActiveList.length,
                            itemBuilder: (context, i) {
                              return
                                  // Column(
                                  // children: [
                                  Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Icon(Icons.timer),
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => OrderDetails(
                                                        orderData:
                                                            ActiveList[i],
                                                      ))).then((value) {
                                            ActiveList.clear();
                                            PastList.clear();
                                            OrderList.clear();
                                            getOrderData();
                                          }),
                                      child:
                                          orderContent(context, ActiveList[i])),
                                ],
                              );
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: <Widget>[
                              //     Center(
                              //       child:InkWell(
                              //         splashColor: Theme.of(context).primaryColor,
                              //         onTap: () => Navigator.of(context).pushNamed("/OrderDetails"),
                              //
                              //         child: Container(
                              //             margin: EdgeInsets.only(top: 25, bottom: 25),
                              //             decoration: BoxDecoration(
                              //               color: Theme.of(context).primaryColor,
                              //               borderRadius: BorderRadius.circular(5),
                              //             ),
                              //             padding: EdgeInsets.all(5),
                              //             width: SizeConfig.w * 0.40,
                              //             child: Center(
                              //               child: Text(
                              //                 "Order Details",
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .bodyText1
                              //                     .copyWith(color: Colors.white),
                              //               ),
                              //             )),
                              //       ),
                              //     ),
                              //     Center(
                              //       child: InkWell(
                              //         splashColor: Theme.of(context).primaryColor,
                              //         onTap: () => Navigator.of(context).pushNamed("/OrderHistory"),
                              //         child: Container(
                              //             margin: EdgeInsets.only(top: 25, bottom: 25),
                              //             padding: EdgeInsets.all(5),
                              //             decoration: BoxDecoration(
                              //               color: Theme.of(context).primaryColor,
                              //               borderRadius: BorderRadius.circular(5),
                              //             ),
                              //             width: SizeConfig.w * 0.3,
                              //             child: Center(
                              //               child: Text(
                              //                 "Cancel",
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .bodyText1
                              //                     .copyWith(color: Colors.white),
                              //               ),
                              //             )),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              //   ],
                              // );
                            }),

                        // Divider(
                        //   thickness: 1,
                        //   color: Theme.of(context).dividerColor,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                          child: Text(
                            "Past Orders",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        // Expanded(
                        //   child:
                        PastList.length > 0
                            ? ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, sepearatedIndecx) {
                                  return Divider(
                                    thickness: 1,
                                    color: Theme.of(context).dividerColor,
                                  );
                                },
                                itemCount: PastList?.length ?? 0,
                                itemBuilder: (context, i) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Icon(Icons.check_circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      GestureDetector(
                                          onTap: () => PastList[i]
                                                      .status
                                                      .toLowerCase() ==
                                                  "refunded"
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          OrderDetailsRefund(
                                                            orderData:
                                                                PastList[i],
                                                          ))).then((value) {
                                                  ActiveList.clear();
                                                  PastList.clear();
                                                  OrderList.clear();
                                                  getOrderData();
                                                })
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          OrderDetails(
                                                            orderData:
                                                                PastList[i],
                                                          ))).then((value) {
                                                  ActiveList.clear();
                                                  PastList.clear();
                                                  OrderList.clear();
                                                  getOrderData();
                                                }),
                                          child: orderContent(
                                              context, PastList[i])),
                                    ],
                                  );
                                })
                            : Center(
                                child: Text("No past orders available"),
                              ),
                        // ),
                        // orderContent(context),

                        // SizedBox(height: 20,),
                      ],
                    ),
            ),
          );
  }

  Card orderContent(BuildContext context, OrderData orderData) {
    return Card(
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: SizeConfig.w * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.w * 0.4,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '#${orderData.number}',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.w * 0.35,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Deliver By ${orderData?.deliveryType == "shop-sasta" ? "shopsasta" : orderData?.deliveryType}',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 10),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (orderData.count ?? 1).toString() +
                      (orderData.count > 1 ? " items" : " item"),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Helper.getPrice(
                      double.parse((orderData.price ?? 0).toString())),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: SizedBox(
                width: SizeConfig.w * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      orderData?.datecreated != null
                          ? DateFormat('EEE MMM d yyyy')
                              .format(orderData?.datecreated)
                              .toString()
                          : " ",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 10),
                    ),
                    Text(
                      orderData?.status ?? "Order Placed",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
