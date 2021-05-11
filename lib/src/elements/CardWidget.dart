import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../models/route_argument.dart';
import 'package:ECom/src/pages/widget/PinCodeFabGrey.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/widget/bottomSheet.dart';

// ignore: must_be_immutable
class CardWidget extends StatefulWidget {
  String market;

  String heroTag;
  Item product;
  CardWidget({Key key, this.product, this.market, this.heroTag})
      : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  int value = 00;
  int selectedQuantity, varientIndex;
  // int quantity = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ProductListData>(builder: (context, productList, ch) {
      return Container(
        width: 130,
        margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
        padding: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          // borderRadius: BorderRadius.only(Radius.circular(10)),
          // border: Border.all()
          // boxShadow: [
          //   BoxShadow(
          //       color: Theme.of(context).focusColor.withOpacity(0.1),
          //       blurRadius: 15,
          //       offset: Offset(0, 5)),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image of the card
            Stack(
              // fit: StackFit.loose,
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductWidget(
                                itemData: widget.product,
                                product: awsLink +
                                    widget.product.pictures[0] +
                                    ".jpg",
                                routeArgument: RouteArgument(
                                  id: '0',
                                  imageUrl: awsLink +
                                      widget.product.pictures[0] +
                                      ".jpg",
                                  heroTag: this.widget.heroTag +
                                      widget.product.itemId,
                                ))));
                  },
                  child: Hero(
                    tag: this.widget.heroTag + widget.product.itemId,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: CachedNetworkImage(
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: awsLink + widget.product.pictures[0] + ".jpg",
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 100,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.image),
                      ),
                    ),
                  ),
                ),
                !productList.stockStatus
                    ? Container()
                    : Consumer<UserData>(builder: (context, userData, ch) {
                        return Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child:
                                    // widget?.product?.quantity == 0
                                    //     ?
                                    InkWell(
                                  splashColor: Theme.of(context).primaryColor,
                                  focusColor: Theme.of(context).primaryColor,
                                  highlightColor:
                                      Theme.of(context).primaryColorLight,
                                  onTap: (widget?.product?.stock ?? 1) > 0
                                      ? () {
                                          bool _additem = false;
                                          ProductBottomSheet(
                                              widget.product, context);
                                        }
                                      : () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.add_circle,
                                          size: 30,
                                          color: (widget?.product?.stock ?? 1) >
                                                  0
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey)),
                                )));
                      }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProductWidget(
                              itemData: widget.product,
                              product: widget.market,
                              routeArgument: RouteArgument(
                                id: '0',
                                imageUrl: awsLink +
                                    widget.product.pictures[0] +
                                    ".jpg",
                                heroTag:
                                    this.widget.heroTag + widget.product.itemId,
                              ))));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: 38,
                          child: AutoSizeText(
                            widget.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          Helper.getPrice(
                              widget.product.variant[0].prices[0].price),
                          // "5 ",
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          softWrap: false,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
