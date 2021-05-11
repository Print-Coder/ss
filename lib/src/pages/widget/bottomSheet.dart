import 'dart:convert';
import 'widgets.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/widget/pincodeFabGrey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future ProductBottomSheet(Item itemData, BuildContext context) async {
  // @required Item itemData;

  int value = 00;
  int selectedQuantity, variantIndex;
  // Item itemData;
  bool _additem = false, isLogin = false;
  // @override
  // void initState() {
  //   super.initState();
  //    itemData = widget.itemData;
  //
//  showLoading() => setState(() {
//         _isLoading = true;
//       });
//   stopLoading() => setState(() {
//         _isLoading = false;
//       });
  // bool _isLoading = false;
  // showLoading();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  isLogin = prefs.getBool("isLogin") ?? false;

  if (isLogin) {
    Map res = isLogin
        ? await ApiServices.getRequestPincode(
            "detail/" + itemData.linker + producDataEndPoint)
        : await ApiServices.getRequest(
            "detail/" + itemData.linker + producDataEndPoint);
    if (res != null) {
      print("status is true");
      itemData = Item.fromMap(res);
      // await Provider.of<ProductListData>(context, listen: false)
      //     .setItemData(itemData);
      print("varient updates");
    }
  } //status is true
  // else {
  //   // stopLoading();

  //   Fluttertoast.showToast(
  //     msg: "Something went wrong",
  //     backgroundColor: Colors.grey[400],
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 2,
  //   );
  // }
  !isLogin
      ? Navigator.of(context).pushNamed('/Login')
      : showModalBottomSheet(
          backgroundColor: Colors.white,
          // enableDrag: true,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0)),
          ),
          context: context,
          builder: (context) {
            selectedQuantity = 0;
            variantIndex = 0;

            return StatefulBuilder(builder: (context, setState) {
              showLoading() => setState(() {
                    _additem = true;
                  });
              stopLoading() => setState(() {
                    _additem = false;
                  });
              var currentObj =
                  itemData.variant[variantIndex].prices[selectedQuantity];
              return Consumer<UserData>(builder: (context, userData, ch) {
                return Wrap(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 25,
                        height: 2,
                        color: Colors.grey[400],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(8),
                        // padding: EdgeInsets.only(left: 8),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: SizeConfig.w * 0.8,
                              child: Text(
                                itemData.name ?? "Name",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              ),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.h * 0.65,
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: itemData?.variant?.length ?? 0,
                          itemBuilder: (context, bottomIndex) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 12, bottom: 4),
                                    child: Text(
                                      itemData?.variant[bottomIndex]?.title ??
                                          "1 KG",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              color: bottomIndex == variantIndex
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.black),
                                    ),
                                  ),

                                  // isThreeLine: true,
                                  ListView.builder(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      addAutomaticKeepAlives: true,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: itemData?.variant[bottomIndex]
                                              .prices?.length ??
                                          0,
                                      itemBuilder: (context, priceIndex) {
                                        var subtitle = itemData
                                            ?.variant[bottomIndex]
                                            .prices[priceIndex];
                                        bool hasStock = itemData
                                                ?.variant[bottomIndex]?.stock >
                                            0;
                                        bool goodStock = itemData
                                                ?.variant[bottomIndex]?.stock >=
                                            itemData?.variant[bottomIndex]
                                                .prices[priceIndex]?.quantity;
                                        print(
                                            '${itemData?.variant[bottomIndex]?.title}-------------------${itemData?.variant[bottomIndex]?.stock},${itemData?.variant[bottomIndex].prices[priceIndex].quantity}');
                                        return RadioListTile(
                                          // selected:

                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          onChanged: !goodStock
                                              ? null
                                              : (i) {
                                                  setState(() {
                                                    variantIndex = bottomIndex;
                                                    selectedQuantity =
                                                        priceIndex;
                                                    value = i;
                                                  });
                                                  print("this is on chaged" +
                                                      i.toString());
                                                },
                                          value: int.parse(
                                              bottomIndex.toString() +
                                                  priceIndex.toString()),
                                          groupValue: value,

                                          title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                setAText(
                                                  context,
                                                  width: 0.3,
                                                  text: Text(
                                                      "Quantity : " +
                                                          subtitle.quantity
                                                              .toString() +
                                                          "x ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              fontSize:
                                                                  16.5) // +(subtitle.quantity>1?"/ 1":"")
                                                      ),
                                                ),
                                                setAText(
                                                  context,
                                                  width: 0.35,
                                                  text: Text(
                                                      "You Pay: " +
                                                          Helper.getPrice(
                                                              subtitle.price),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5
                                                          .copyWith(
                                                              fontSize: 16.5)
                                                      // +(subtitle.quantity>1?"/ 1":"")
                                                      ),
                                                ),
                                              ]),
                                          subtitle: Padding(
                                            padding: EdgeInsets.only(
                                                top: hasStock ? 2 : 8.0,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    setAText(
                                                      context,
                                                      width: 0.27,
                                                      text: Text("MRP : " +
                                                              Helper.getPrice(
                                                                  itemData
                                                                      ?.variant[
                                                                          bottomIndex]
                                                                      .mrp)
                                                          // +(subtitle.quantity>1?"/ 1":"")
                                                          ),
                                                    ),
                                                    hasStock
                                                        ? Container()
                                                        : Text("out of stock",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red))
                                                  ],
                                                ),
                                                setAText(
                                                  context,
                                                  width: 0.35,
                                                  text: Text("You Save :" +
                                                          Helper.getPrice((subtitle
                                                                      .quantity *
                                                                  itemData
                                                                      ?.variant[
                                                                          bottomIndex]
                                                                      .mrp) -
                                                              (subtitle
                                                                      .quantity *
                                                                  subtitle
                                                                      .price))
                                                      // +(subtitle.quantity>1?"/ 1":"")
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: PinCodeFabGrey()),
                    ),
                    Center(
                      child: _additem
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                // border: BoxBorder(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              margin: EdgeInsets.only(bottom: 50),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              width: SizeConfig.w * 0.92,
                              height: SizeConfig.w * 0.13,
                              child: RawMaterialButton(
                                  fillColor: Theme.of(context).primaryColor,
                                  shape: new CircleBorder(),
                                  elevation: 0.0,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        setAText(
                                          context,
                                          width: 0.45,
                                          text: Text(
                                              "  ${currentObj.quantity} x ${Helper.getPrice(currentObj.price)} = ${Helper.getPrice(currentObj.price * currentObj.quantity)}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white)),
                                        ),
                                        setAText(
                                          context,
                                          width: 0.28,
                                          text: Text("Add Items  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: _additem
                                      ? () {}
                                      : () async {
                                          // setState(() {
                                          if (isLogin) {
                                            Map data = Cart().toMap(
                                              productId: itemData.itemId,
                                              quantity: itemData
                                                  .variant[variantIndex]
                                                  .prices[selectedQuantity]
                                                  .quantity,
                                              variantId: itemData
                                                  .variant[variantIndex].id,
                                              pincode: userData
                                                  .currentUser
                                                  .addresses[userData
                                                      .currentUser.addressIndex]
                                                  .zip,
                                            );
                                            print("data to cart");
                                            print(
                                                "$variantIndex $selectedQuantity ${data.toString()}");
                                            showLoading();
                                            // await Future.delayed(
                                            //     Duration(milliseconds: 600));

                                            Map res = await ApiServices
                                                .postRequestToken(
                                              json.encode(data),
                                              cartEndPoint,
                                            );
                                            if (res["status"]) {
                                              //  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(
                                              //                                       "successfully added to cart")));
                                              print(
                                                  "bottom sheet setting cart");
                                              Provider.of<CartData>(context,
                                                      listen: false)
                                                  .setCartData(res["data"]);
                                              stopLoading();

                                              Navigator.of(context).pop();
                                              itemData?.isCart = true;
                                              Fluttertoast.showToast(
                                                msg:
                                                    "successfully added to cart",
                                                backgroundColor:
                                                    Colors.grey[400],
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 2,
                                              );
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

                                              if (res["message"] ==
                                                  "Pincode is not available for delivery") {
                                                // Navigator.of(context).pop();

                                                Navigator.of(context)
                                                    .popAndPushNamed(
                                                        '/DeliveryCoverage');
                                              } else {
                                                Navigator.of(context).pop();
                                                Fluttertoast.showToast(
                                                  msg: res["message"],
                                                  backgroundColor:
                                                      Colors.grey[400],
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 2,
                                                );
                                              } //else status is false
                                            }
                                          } //login is false

                                          else {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, "/Login");
                                          }
                                        })),
                    ),
                  ],
                );
              });
            });
          });
  // }
}
