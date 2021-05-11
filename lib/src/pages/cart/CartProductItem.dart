import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'api/CartData.dart';

class CartProductItem extends StatefulWidget {
  final String heroTag;
  // final Product product;
  final String product;
  Product cartData;
  CartProductItem({Key key, this.product, this.heroTag, this.cartData})
      : super(key: key);
  @override
  _CartProductItemState createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  int quantity = 0;
  String secondDrop;
  var requiredvariant, requiredProduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    requiredvariant = widget.cartData?.variant;
    requiredProduct = widget.cartData;

    SizeConfig().init(context);
    return Consumer<UserData>(builder: (context, userData, ch) {
      // List<Item> produtList = category.items ?? [];
      return Consumer<ProductListData>(builder: (context, productListData, ch) {
        // Item itemData = productListData.items
        //     .firstWhere((e) => e.itemId == widget?.cartData?.productId);

        return Container(
          height: SizeConfig.h * 0.19,
          padding: EdgeInsets.only(left: 12, top: 16, bottom: 0),
          decoration: BoxDecoration(
            color:
                // Colors.black,
                Theme.of(context).primaryColorLight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // InkWell(
              //   splashColor: Theme.of(context).primaryColor,
              //   focusColor: Theme.of(context).primaryColor,
              //   highlightColor: Theme.of(context).primaryColorLight,
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (_) => ProductWidget(
              //                 linker: widget.cartData.name.toLowerCase(),
              //                 product: widget.product,
              //                 ProductName: widget.productName,
              //                 routeArgument: RouteArgument(
              //                   id: '0',
              //                   param: widget.product,
              //                   heroTag: widget.heroTag,
              //                 ))));
              //   },
              //   child: Hero(
              //     tag: widget.heroTag + widget.product,
              // child:
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProductWidget(
                              linker: widget.cartData.linker,
                            ))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: CachedNetworkImage(
                    height: SizeConfig.h * 0.15,
                    width: SizeConfig.w * 0.17,
                    fit: BoxFit.cover,
                    imageUrl: awsLink + widget.cartData.pictures[0] + ".jpg",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.image),
                  ),
                ),
              ),
              //   ),
              // ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 9),
                width: SizeConfig.w * 0.76,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.w * 0.7,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductWidget(
                                              linker: widget.cartData.linker,
                                            ))),
                                child: Text(
                                  widget.cartData.name ?? "Name",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14),
                                ),
                              ),
                              // ),
                            ),
                            SizedBox(
                              width: SizeConfig.w * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    // height: 30,
                                    width: SizeConfig.w * 0.2,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 1),
                                    margin: EdgeInsets.only(left: 0.0, top: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).accentColor,
                                            width: 0.5)),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          requiredvariant?.title ?? "1 KG",
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.w * 0.24,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                          key: Key(widget.cartData.variantId),
                                          onTap: () async {
                                            // setState(() {
                                            if (widget?.cartData?.quantity >= 1)
                                              widget?.cartData?.quantity -= 1;
                                            // if (itemData?.quantity >= 1)
                                            //   itemData?.quantity -= 1;
                                            // });
                                            print("cart variant id");
                                            // print(widget.cartData.);
                                            Map data;
                                            if (widget.cartData.cartId
                                                .contains("sasta")) {
                                              data = Cart().toSastaMap(
                                                price: widget.cartData.variant
                                                    .sastaPrice,
                                                productId:
                                                    widget.cartData.productId,
                                                quantity: -1,
                                                variantId:
                                                    widget.cartData.variantId,
                                                pincode: userData
                                                    .currentUser
                                                    .addresses[userData
                                                        .currentUser
                                                        .addressIndex]
                                                    .zip,
                                              );
                                            } else {
                                              data = Cart().toMap(
                                                productId:
                                                    widget.cartData.productId,
                                                quantity: -1,
                                                variantId:
                                                    widget.cartData.variantId,
                                                pincode: userData
                                                    .currentUser
                                                    .addresses[userData
                                                        .currentUser
                                                        .addressIndex]
                                                    .zip,
                                              );
                                            }
                                            print(data);
                                            Map res = await ApiServices
                                                .postRequestToken(
                                              json.encode(data),
                                              cartEndPoint,
                                            );
                                            if (res["status"]) {
                                              //  Provider.of<ProductListData>(context,
                                              //         listen: false)
                                              //     .setQuantity(itemData);
                                              Provider.of<CartData>(context,
                                                      listen: false)
                                                  .setCartData(res["data"]);
                                            } else {
                                              widget?.cartData?.quantity += 1;
                                              // itemData?.quantity += 1;
                                              Fluttertoast.showToast(
                                                msg: res["message"],
                                                backgroundColor:
                                                    Colors.grey[400],
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 2,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            // padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              // border: BoxBorder(),
                                              border: Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2)),
                                              // color: i == index
                                              //     ? Theme.of(context).primaryColor
                                              //     : Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 28,
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                  widget?.cartData?.quantity
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            // setState(() {
                                            if (widget?.cartData?.quantity >= 1)
                                              widget?.cartData?.quantity += 1;
                                            // });
                                            // setState(() {
                                            // if (itemData?.quantity >= 1)
                                            //   itemData?.quantity += 1;
                                            // });

                                            Map data;
                                            if (widget.cartData.cartId
                                                .contains("sasta")) {
                                              data = Cart().toSastaMap(
                                                price: widget.cartData.variant
                                                    .sastaPrice,
                                                productId:
                                                    widget.cartData.productId,
                                                quantity: 1,
                                                variantId:
                                                    widget.cartData.variantId,
                                                pincode: userData
                                                    .currentUser
                                                    .addresses[userData
                                                        .currentUser
                                                        .addressIndex]
                                                    .zip,
                                              );
                                            } else {
                                              data = Cart().toMap(
                                                productId:
                                                    widget.cartData.productId,
                                                quantity: 1,
                                                variantId:
                                                    widget.cartData.variantId,
                                                pincode: userData
                                                    .currentUser
                                                    .addresses[userData
                                                        .currentUser
                                                        .addressIndex]
                                                    .zip,
                                              );
                                            }
                                            Map res = await ApiServices
                                                .postRequestToken(
                                              json.encode(data),
                                              cartEndPoint,
                                            );
                                            if (res["status"]) {
                                              //  Provider.of<ProductListData>(context,
                                              //         listen: false)
                                              //     .setQuantity(itemData);
                                              Provider.of<CartData>(context,
                                                      listen: false)
                                                  .setCartData(res["data"]);
                                            } else {
                                              if (widget?.cartData?.quantity >
                                                  1)
                                                widget?.cartData?.quantity -= 1;
                                              // if (itemData?.quantity > 1)
                                              //   itemData?.quantity -= 1;
                                              Fluttertoast.showToast(
                                                msg: res["message"],
                                                backgroundColor:
                                                    Colors.grey[400],
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 2,
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            // padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              // border: BoxBorder(),
                                              border: Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2)),
                                              // color: i == index
                                              //     ? Theme.of(context).primaryColor
                                              //     : Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      // margin: EdgeInsets.only(right: 23),
                                      // key: Key(widget.cartData.variantId),
                                      padding: EdgeInsets.all(3),
                                      // decoration: BoxDecoration(
                                      //   shape: BoxShape.circle,
                                      //   border: Border.all(
                                      //     width: 1,
                                      //     color: Theme.of(context).accentColor,
                                      //   ),
                                      // ),
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        child: Image.asset(
                                          'assets/icons/rubbish.png',
                                          fit: BoxFit.cover,
                                          color: Theme.of(context).accentColor,
                                          // height: 60,
                                          // width: 60,
                                        ),
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              // insetPadding:  EdgeInsets.all(20),
                                              titlePadding: EdgeInsets.fromLTRB(
                                                  15, 30, 0, 10),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20, 5, 20, 0),
                                              // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                                              title: Text('Delete Item',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5),
                                              content: Text(
                                                  'Are you Sure you want to remove this item?',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text('No',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6),
                                                ),
                                                FlatButton(
                                                  key: Key(widget
                                                      .cartData.variantId),
                                                  onPressed: () async {
                                                    Map data;
                                                    if (widget.cartData.cartId
                                                        .contains("sasta")) {
                                                      data = Cart().toSastaMap(
                                                        price: widget.cartData
                                                            .variant.sastaPrice,
                                                        productId: widget
                                                            .cartData.productId,
                                                        quantity: -widget
                                                            .cartData.quantity,
                                                        variantId: widget
                                                            .cartData.variantId,
                                                        pincode: userData
                                                            .currentUser
                                                            .addresses[userData
                                                                .currentUser
                                                                .addressIndex]
                                                            .zip,
                                                      );
                                                    } else {
                                                      data = Cart().toMap(
                                                        productId: widget
                                                            .cartData.productId,
                                                        quantity: -widget
                                                            .cartData.quantity,
                                                        variantId: widget
                                                            .cartData.variantId,
                                                        pincode: userData
                                                            .currentUser
                                                            .addresses[userData
                                                                .currentUser
                                                                .addressIndex]
                                                            .zip,
                                                      );
                                                    }

                                                    widget?.cartData?.quantity =
                                                        0;
                                                    // itemData?.quantity = 0;
                                                    // Provider.of<ProductListData>(context,
                                                    //         listen: false)
                                                    //     .setQuantity(itemData);
                                                    print(data);
                                                    Map res = await ApiServices
                                                        .postRequestToken(
                                                      json.encode(data),
                                                      cartEndPoint,
                                                    );

                                                    Provider.of<CartData>(
                                                            context,
                                                            listen: false)
                                                        .setCartData(
                                                            res["data"]);
                                                    Navigator.of(context).pop();
                                                    Fluttertoast.showToast(
                                                      msg: "Product Deleted",
                                                      backgroundColor:
                                                          Colors.grey[400],
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 3,
                                                    );
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        // left: 15,
                        right: 15,
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                  "MRP: " +
                                      Helper.getPrice(requiredProduct.mrp),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FittedBox(
                              child: Text(
                                "You Pay: " +
                                    Helper.getPrice(requiredProduct.price),
                                // overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FittedBox(
                              child: Text(
                                "Save: " +
                                    Helper.getPrice(
                                        (requiredProduct?.mrp ?? 0.0) -
                                            (requiredProduct?.price ?? 0.0)),
                                // overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                            // SizedBox(
                            //   width: 0,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  "Deliver By: ${(widget?.cartData?.deliveryType == "shop-sasta" ? "shopsasta" : widget?.cartData?.deliveryType) ?? "shopsasta"} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: SizeConfig.w * 0.032)),
                          TextSpan(
                              text:
                                  " ${(widget.cartData.shippingPrice > 0) ? "(Shipping Price:" + (widget.cartData.shippingPrice.toString()) + ")" : ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: SizeConfig.w * 0.028)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
