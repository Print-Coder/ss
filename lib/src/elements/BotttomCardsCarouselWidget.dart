import 'dart:math';

import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/constants.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
// import '../models/market.dart';
import '../models/route_argument.dart';
import 'CardWidget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BottomCardsCarouselWidget extends StatefulWidget {
  List<String> EComList;
  String heroTag;

  BottomCardsCarouselWidget({Key key, this.EComList, this.heroTag})
      : super(key: key);

  @override
  _BottomCardsCarouselWidgetState createState() =>
      _BottomCardsCarouselWidgetState();
}

class _BottomCardsCarouselWidgetState extends State<BottomCardsCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.EComList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Consumer<ProductListData>(builder: (context, category, ch) {
            List<Item> produtList = category.items ?? [];
            return Container(
              color: Colors.white,
              height: 173,
              // padding: const EdgeInsets.only(left: 3.0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Container(color: Colors.grey[300], width: 1);
                },
                scrollDirection: Axis.horizontal,
                itemCount: produtList.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                      product: produtList[index],
                      market: widget.EComList.elementAt(
                          index % widget.EComList.length),
                      heroTag: widget.heroTag +
                          index.toString() +
                          Random().nextInt(100).toString());
                },
              ),
            );
          });
  }
}
