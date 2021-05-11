import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/constants.dart';

class CategoryListLoad extends StatefulWidget {
  CategoryListLoad({Key key}) : super(key: key);

  @override
  _CategoryListLoadState createState() => _CategoryListLoadState();
}

class _CategoryListLoadState extends State<CategoryListLoad> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      margin: EdgeInsets.only(left: 4, top: 0),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: productCategory?.length ?? 0,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  index = i;
                });
              },
              child: Container(
                  //  width: 50,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                          child: Text(productCategory[i],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontFamily: 'Quicksand',
                                    fontSize: 14,
                                    color: i == index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).accentColor,
                                  ))),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 15,
                        width: 2,
                        child: Container(
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
