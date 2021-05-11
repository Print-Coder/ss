import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadProductDetails extends StatelessWidget {
  const LoadProductDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      // margin: EdgeInsets.only(bottom: 125),
      // padding: EdgeInsets.only(bottom: 15),

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Wrap(
            runSpacing: 8,
            children: [
              Divider(
                height: 1,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    child: Text(
                      "ProductName",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    //         child:
                    child: Container(
                      height: 30,
                      width: SizeConfig.w * 0.4,
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                      margin: EdgeInsets.only(left: 8.0, top: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: new DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        iconSize: 20,
                        icon: Container(
                            // width:15,
                            child: Center(
                                child: Icon(Icons.arrow_drop_down,
                                    color: Colors.grey, size: 30))),
                        style: TextStyle(
                            fontSize: 14, color: Theme.of(context).accentColor),
                        value: " 1KG ",
                        items: <String>[' 1KG ', ' 2KG ', ' 3KG ', ' 4KG ']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (v) {
                          print(v);
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: SizeConfig.w * 0.4,
                    padding: const EdgeInsets.only(left: 8.0, top: 2, right: 5),
                    margin: EdgeInsets.only(left: 8.0, top: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).accentColor, width: 1)),
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
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).accentColor),
                      value: "1 @ ₹375",
                      items: <String>[
                        '1 @ ₹375',
                        '2 @ ₹375',
                        '3 @ ₹375',
                        '4 @ ₹375'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (v) {
                        print(v);
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 2.0, top: 8),
                  width: SizeConfig.w * 0.82,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: Text(
                          "MRP: ₹490",
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                      ),
                      SizedBox(width: 3),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: Text(
                          "Save: ₹115",
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(width: 2),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: Text(
                          "You Pay: ₹375",
                          // overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline6,
                          // .copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                      margin: EdgeInsets.only(left: 0.0, top: 8),
                      width: SizeConfig.w * 0.9,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: Text(
                            "Dals and lentils are staple in Indian Cookong. This is unpolished Dal comes in varients",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.w500)),
                      ))),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  shareEarn(context, "SHARE & EARN"),
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: SizeConfig.w * 0.4,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400],
                          highlightColor: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add,
                                  color: Theme.of(context).primaryColorLight),
                              SizedBox(width: 7),
                              SizedBox(
                                width: SizeConfig.w * 0.25,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "ADD TO CART",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),

              Divider(height: 5),
              // Text(Helper.skipHtml(widget.product)),

              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400],
                          highlightColor: Colors.white,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Do You Also Want ...?",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
