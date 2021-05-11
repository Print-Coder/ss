import 'dart:math';

import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:ECom/src/pages/productListing/productListing.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/constants.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
// import '../models/market.dart';
import '../models/route_argument.dart';
import 'CardWidget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardsCarouselWidget extends StatefulWidget {
  List<String> EComList;
  String heroTag;
  List<Item> productList;
  CardsCarouselWidget({Key key,
  this.productList,
   this.EComList, this.heroTag}) : super(key: key);

  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.EComList.isEmpty
        ? CardsCarouselLoaderWidget()
        :  Container(
              color: Colors.white,
              height: 173,
              padding: const EdgeInsets.only(left: 3.0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Container(color: Colors.grey[300], width: 1);
                },
                scrollDirection: Axis.horizontal,
                itemCount: widget.productList.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                      product: widget.productList[index % widget.productList.length],
                      market: widget.EComList[index % widget.EComList.length],
                      heroTag: widget.heroTag +
                          Random().nextInt(100).toString());
                },
              ),
            );
         
  }
}
