import 'package:ECom/src/pages/home/homeTitle.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/route_argument.dart';

class HomeLoadWidget extends StatelessWidget {
  List<String> titleName = [
    "All Groceries",
    "Deals of the Day",
    "Best Seller",
    "HouseHolds",
    "Healthier Food",
  ];
  List<Widget> loadBody;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) {
        return Container();
      },
      itemCount: titleName.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              child: HomeTitle(
                title: titleName[index],
              ),
            ),
            LoadCardWidget(),
          ],
        );
      },
    );
  }
}

class LoadCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 173,
      padding: const EdgeInsets.only(left: 3.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 130,
            margin: EdgeInsets.only(left: 0, right: 1, top: 0, bottom: 0),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: Image.asset(
                        'assets/img/loading.gif',
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add_circle,
                                    size: 30,
                                    color: Theme.of(context).primaryColor)))),
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
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
                              child: Text(
                                "Name",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontSize: 13.5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "₹ 00",
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.center,
                              softWrap: false,
                              style: Theme.of(context).textTheme.headline,
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
        },
      ),
    );
  }
}
