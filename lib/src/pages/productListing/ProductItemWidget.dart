import 'dart:convert';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/widget/bottomSheet.dart';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/widget/PinCodeFabGrey.dart';

class ProductItemWidget extends StatefulWidget {
  final String heroTag;
  // final Product product;
  bool stockStatus;
  final String product;

  final Item productData;
  ProductItemWidget(
      {Key key, this.product, this.stockStatus, this.productData, this.heroTag})
      : super(key: key);
  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int value;
  int selectedQuantity, variantIndex;
  String secondDrop;
  int quantity = 0;
  @override
  Widget build(BuildContext context) {
    print("ptoduct  id" + widget.stockStatus.toString());
    secondDrop = ((widget.productData?.variant[widget.productData?.variantIndex]
                    ?.prices[widget.productData?.quantIndex]?.quantity) ??
                1)
            .toString() +
        " @ " +
        Helper.getDropDown((widget
                    .productData
                    ?.variant[widget.productData?.variantIndex]
                    ?.prices[widget.productData?.quantIndex]
                    ?.price) ??
                1)
            .toString();
    var variant = widget.productData.variant[widget.productData.variantIndex];
    SizeConfig().init(context);
    return Container(
      height: 165,
      padding: EdgeInsets.only(left: 12, top: 16, bottom: 16),
      // decoration: BoxDecoration(
      color: Theme.of(context).primaryColorLight,
      //   boxShadow: [
      //     BoxShadow(
      //         color: Theme.of(context).focusColor.withOpacity(0.1),
      //         blurRadius: 5,
      //         offset: Offset(0, 2)),
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            splashColor: Theme.of(context).primaryColor,
            focusColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColorLight,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductWidget(
                          itemData: widget.productData,
                          product: widget.product,
                          routeArgument: RouteArgument(
                            id: '0',
                            imageUrl: awsLink +
                                widget.productData.pictures[0] +
                                ".jpg",
                            heroTag: widget.heroTag + widget.productData.itemId,
                          ))));
            },
            child: Hero(
              tag: widget.heroTag + widget.productData.itemId,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 120,
                  width: SizeConfig.w * 0.17,
                  fit: BoxFit.cover,
                  imageUrl: awsLink + widget.productData.pictures[0] + ".jpg",
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
          ),
          SizedBox(width: 10),
          Container(
            width: SizeConfig.w * 0.76,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    // padding: EdgeInsets.only(left: 8),
                    child: InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      focusColor: Theme.of(context).primaryColor,
                      highlightColor: Theme.of(context).primaryColorLight,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductWidget(
                                    itemData: widget.productData,
                                    product: widget.product,
                                    routeArgument: RouteArgument(
                                      id: '0',
                                      imageUrl: awsLink +
                                          widget.productData.pictures[0] +
                                          ".jpg",
                                      heroTag: widget.productData.itemId,
                                    ))));
                      },
                      child: Text(
                        widget.productData.name ?? "Name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: SizeConfig.w * 0.3,
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                      margin: EdgeInsets.only(left: 0.0, top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 0.5)),
                      child: new DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        iconSize: 20,
                        icon: Container(
                            // width:15,
                            child: Center(
                                child: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey, size: 30))),
                        key: Key(widget.product),
                        style: TextStyle(
                            fontSize: 13, color: Theme.of(context).accentColor),
                        value: variant?.title ?? "1 KG",
                        items: widget.productData.variant
                            .map((e) => e.title)
                            .toList()
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                              value: value,
                              child:
                                  //  SizedBox(
                                  //     width: SizeConfig.w * 0.2,
                                  //     child:
                                  new FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(value),
                              )
                              // ),
                              );
                        }).toList(),
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            widget.productData.variantIndex = widget
                                .productData.variant
                                .map((e) => e.title)
                                .toList()
                                .indexOf(v);
                            Provider.of<ProductListData>(context, listen: false)
                                .setvariant(widget?.productData);

                            secondDrop =
                                (variant?.prices[0]?.quantity).toString() +
                                    " @ " +
                                    Helper.getDropDown(widget
                                            .productData
                                            ?.variant[
                                                widget.productData.variantIndex]
                                            .prices[0]
                                            .price)
                                        .toString();
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 30,
                      width: SizeConfig.w * 0.4,
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                      margin: EdgeInsets.only(left: 8.0, top: 5, right: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 0.5)),
                      child: new DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        iconSize: 20,
                        icon: Container(
                          // width:15,
                          child: Center(
                            child: Icon(Icons.arrow_drop_down,
                                color: Colors.grey, size: 30),
                          ),
                        ),
                        key: Key(widget.product),
                        style: TextStyle(
                            fontSize: 14, color: Theme.of(context).accentColor),
                        value: secondDrop,
                        items: widget.productData
                            .variant[widget.productData.variantIndex].prices
                            .map((value) {
                          return new DropdownMenuItem<String>(
                            value: (value.quantity).toString() +
                                " @ " +
                                (Helper.getDropDown(value.price)),
                            child:

                                //  Container()
                                SizedBox(
                                    // width: SizeConfig.w * 0.33,
                                    child: new FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                (value.quantity).toString() +
                                    " @ ₹" +
                                    value.price.toString() +
                                    " ea",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).accentColor),
                              ),
                            )),
                          );
                        }).toList(),
                        onChanged: (v) {
                          print(v.split("@")[1]);
                          setState(() {
                            secondDrop = v;
                            print(secondDrop);
                            widget.productData.quantIndex = widget.productData
                                .variant[widget.productData.variantIndex].prices
                                .indexWhere((price) =>
                                    price.price ==
                                    double.parse(
                                        v.split(" ")[2].trim().split("₹")[1]));

                            print(widget.productData.quantIndex);
                          });
                          Provider.of<ProductListData>(context, listen: false)
                              .setQuantIndex(widget?.productData);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: SizeConfig.w * 0.73,
                  margin: EdgeInsets.only(left: 2.0, top: 5),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //widget?.productData?.variant[bottomIndex].mrp) - (subtitle.quantity * subtitle.price
                        Text(
                          "MRP: " + Helper.getPrice(variant.mrp),
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Save: " +
                              Helper.getPrice((variant.mrp -
                                      variant
                                          .prices[widget.productData.quantIndex]
                                          .price)
                                  .abs()),
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "You Pay: " +
                              Helper.getPrice(variant
                                  .prices[widget.productData.quantIndex].price),
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: SizeConfig.w * 0.7,
                  child: Consumer<UserData>(builder: (context, userData, ch) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.w * 0.35,
                          // child:

                          //  FittedBox(
                          //   fit: BoxFit.fitWidth,
                          //   child: Text("749 people bought",
                          //       // overflow: TextOverflow.ellipsis,
                          //       maxLines: 2,
                          //       style: Theme.of(context).textTheme.bodyText2),
                          // ),
                        ),
                        // !widget?.productData?.isCart ||
                        //         widget?.productData.quantity == 0
                        //     ?
                        !widget.stockStatus
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(right: 2),
                                color: Colors.white,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 36,
                                    color: (widget?.productData?.stock ?? 1) > 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  ),
                                  onTap: (widget?.productData?.stock ?? 1) > 0
                                      ? () async {
                                          value = int.parse(
                                              0.toString() + 0.toString());
                                          bool _additem = false;
                                          ProductBottomSheet(
                                              widget.productData, context);
                                        }
                                      : () {},
                                ))
                      ],
                    );
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
