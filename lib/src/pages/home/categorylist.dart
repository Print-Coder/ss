import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/models/category.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/pages/productListing/productListing.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class CategoryList extends StatefulWidget {
  bool isSub = false;

  CategoryList({Key key, this.isSub}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int index = 0, subIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ProductListData>(builder: (context, menu, ch) {
      return Container(
        height: 25,
        // padding: EdgeInsets.only(left: SizeConfig.w * 0.005),
        margin: EdgeInsets.only(left: 0, top: 0),
        child: Column(
          children: <Widget>[
            widget.isSub
                ? Container()
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Builder(builder: (
                        context,
                      ) {
                        if(menu.categoryList[0].menuName!="All")
                        menu.categoryList.insert(
                            0,
                            HeaderJson(
                              menuName: "All",
                              // " this.hrefUrl",
                              //  this.menuType,
                              //  this.subMenu1,
                            ));
                        return ListView.separated(

                            // padding: ,
                            separatorBuilder: (context, sepearatedIndecx) {
                              return Center(
                                child: Container(
                                  height: SizeConfig.w * 0.04,
                                  width: 2,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                            // shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: menu.categoryList?.length ?? 0,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  bool isLogin =
                                      prefs.getBool("isLogin") ?? false;

                                  Provider.of<ProductListData>(context,
                                          listen: false)
                                      .setMenu(i);
                                  setState(() {
                                    index = i;
                                  });
                                  if(i==0){
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (_) => ProductList(
                                    //       linker:
                                    //       menu.categoryList[i].hrefUrl,
                                    //       isLogin: true,
                                    //     )));
                                  }
                                  else{
                                  Map productRes = isLogin
                                      ? await ApiServices.getRequestPincode(
                                          menu.categoryList[i].hrefUrl +
                                              "?json=1")
                                      : await ApiServices.getRequest(
                                          menu.categoryList[i].hrefUrl +
                                              "?json=1");
                                  if (productRes != null) {
                                    // stopLoading();
                                    Provider.of<ProductListData>(context,
                                            listen: false)
                                        .setProductListData(productRes);
                                    Provider.of<ProductListData>(context,
                                            listen: false)
                                        .setData(
                                            List<Item>.from((productRes["items"]
                                                    ?.map((x) =>
                                                        Item.fromMap(x))) ??
                                                []),
                                            isSubCat: false);
                                  }
                                  // else {
                                  //   // stopLoading();
                                  //   Fluttertoast.showToast(
                                  //     msg: "Server is not responding",
                                  //     backgroundColor: Colors.grey[400],
                                  //     toastLength: Toast.LENGTH_LONG,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 2,
                                  //   );
                                  // }

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => ProductList(
                                            linker:
                                                menu.categoryList[i].hrefUrl,
                                            isLogin: true,
                                          )));}
                                },
                                child: Container(
                                    //  width: 50,
                                    // color: Colors.red,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    // margin: EdgeInsets.symmetric(horizontal: 4),
                                    child: Center(
                                        child: textST1(
                                            menu.categoryList[i].menuName,
                                            textstyle: TextStyle(
                                              fontFamily: 'Quicksand',
                                              color: i ==0
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .accentColor,
                                            )))),
                              );
                            });
                      }),
                    ),
                  ),
            !widget.isSub
                ? Container()
                : Consumer<ProductListData>(builder: (context, category, ch) {
                    return Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, sepearatedIndecx) {
                            return Center(
                              child: Container(
                                height: SizeConfig.w * 0.04,
                                width: 2,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                          // shrinkWrap: true,
                          addAutomaticKeepAlives: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: menu.categoryList[category.selectedMenu]
                                  ?.subMenu1?.length ??
                              0,
                          itemBuilder: (context, si) {
                            var subMenuObj = menu
                                .categoryList[category.selectedMenu]
                                ?.subMenu1[si];
                            return GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                bool isLogin =
                                    prefs.getBool("isLogin") ?? false;
                                Provider.of<ProductListData>(context,
                                        listen: false)
                                    .setSubMenu(si);
                                Map productRes = isLogin
                                    ? await ApiServices.getRequestPincode(
                                        subMenuObj.hrefUrl + "?json=1")
                                    : await ApiServices.getRequest(
                                        subMenuObj.hrefUrl + "?json=1");
                                if (productRes != null) {
                                  // stopLoading();
                                  Provider.of<ProductListData>(context,
                                          listen: false)
                                      .setProductListData(productRes);
                                  Provider.of<ProductListData>(context,
                                          listen: false)
                                      .setData(
                                          List<Item>.from((productRes["items"]
                                                  ?.map((x) =>
                                                      Item.fromMap(x))) ??
                                              []),
                                          isSubCat: true);
                                } else {
                                  // stopLoading();
                                  Fluttertoast.showToast(
                                    msg: "Server is not responding",
                                    backgroundColor: Colors.grey[400],
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                  );
                                }
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => ProductList(
                                //           linker: subMenuObj.hrefUrl,
                                //         )));
                              },
                              child: Container(
                                  //  width: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  // margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: Center(
                                      child: textST1(
                                          subMenuObj?.subMenu1Name == ""
                                              ? "subMenu"
                                              : subMenuObj.subMenu1Name,
                                          textstyle: TextStyle(
                                            fontFamily: 'Quicksand',
                                            color: si == menu.selectedSubMenu
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).accentColor,
                                          )))),
                            );
                          }),
                    );
                  }),
          ],
        ),
      );
    });
  }
}
