import 'dart:async';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/models/category.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/pages/home/categorylist.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:ECom/src/pages/productListing/productListing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Widget> rowList = [];

// Future<Item> getNumber({int num = 20}) async {
//   http.Response res = await http.get(Uri.http("dummyresponse.pythonanywhere.com", "/api/$num"));
//   return Item.fromMap(json.decode(res.body));
// }

// Stream<Number> getNumbers(Duration refreshTime) async* {
//   while (true) {
//     await Future.delayed(refreshTime);
//     yield await getNumber();
//   }
// }
  List<Item> _filteredList = [];
  String Query = null;
  // StreamController<List<Item>> _streamController =
  //     StreamController<List<Item>>();
  Future<List<Item>> getsearch() async {
    if (Query != "" && Query != null) {
      Map data = {"name": Query};
      Map category = await ApiServices.postRequest(
          json.encode(data), "api/product-search");

      _filteredList = List<Item>.from(
          (category["items"]?.map((x) => Item.fromMap(x))) ?? []);
      return _filteredList;
    }
  }
  // Stream<List<Item>>   _stream=> _streamController.stream.listen((e){
  //   Map category =_streamController. sink.add( await ApiServices.postRequest(
  //       json.encode({"name": searchQuery}), "api/product-search"));

  //   _filteredList =
  //       List<Item>.from((category["items"]?.map((x) => Item.fromMap(x))) ?? []);
  //   _streamController.sink.add(_filteredList););
  // });

  _filter(String searchQuery) {
    setState(() {
      Query = searchQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar(
          index: 0,
        ),
        appBar: AppBarWithPop(context, "Search",
            needSearch: false, needCart: false, ispop: true),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  // color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                // padding: EdgeInsets.all(5),
                // width: SizeConfig.w * 0.55,
                // height: SizeConfig.w * 0.12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/icons/search.png",
                      width: 23,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: SizeConfig.w * 0.55,
                      child: TextField(
                        //  maxLength: 10,
                        onChanged: _filter,
                        decoration: InputDecoration(
                          //  prefixText: "Enter Coupon Code"
                          labelText: "Search for Products",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          //  labelStyle: TextStyle(
                          //    color: Theme.of(context).primaryColor,
                          //  ),
                          //  helperText: "Enter your 10 digit Mobile Number",
                          //  helperStyle: TextStyle(
                          //      color: Colors.black45,
                          //      fontWeight: FontWeight.w400),
                          //  focusedBorder: UnderlineInputBorder(
                          //    borderSide: BorderSide(
                          //        color: Theme.of(context).primaryColor),
                          //  ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                  // key: ValueKey(snapshot.data),
                  // initialData: snapshot.data,
                  future: getsearch(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Item>> snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Center(
                    //     child: CircularProgressIndicator(),
                    //   );
                    // }
                    // print(" this is filter ${_filteredList.isEmpty}");
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        Query != null) {
                      return Container(
                        height: SizeConfig.h * 0.6,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasData &&
                        Query != "" &&
                        _filteredList.isNotEmpty) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 90,
                              width: SizeConfig.w * 0.7,
                              margin: EdgeInsets.only(
                                  left: 18, right: 18, bottom: 2, top: 2),
                              padding:
                                  EdgeInsets.only(left: 2, top: 16, bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 5,
                                      offset: Offset(2, 2)),
                                ],
                              ),
                              child: InkWell(
                                splashColor: Theme.of(context).primaryColor,
                                focusColor: Theme.of(context).primaryColor,
                                highlightColor:
                                    Theme.of(context).primaryColorLight,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductWidget(
                                              itemData: snapshot.data[index],
                                              // product: widget.product,

                                              routeArgument: RouteArgument(
                                                id: '0',
                                                imageUrl: awsLink +
                                                    snapshot.data[index]
                                                        .pictures[0] +
                                                    ".jpg",
                                                heroTag: "search" +
                                                    snapshot.data[index].itemId,
                                              ))));
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Hero(
                                        tag: "search" +
                                            snapshot.data[index].itemId,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          child: CachedNetworkImage(
                                            height: 120,
                                            width: SizeConfig.w * 0.18,
                                            fit: BoxFit.cover,
                                            imageUrl: awsLink +
                                                snapshot
                                                    .data[index].pictures[0] +
                                                ".jpg",
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/img/loading.gif',
                                              fit: BoxFit.cover,
                                              height: 60,
                                              width: 60,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.image),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Center(
                                        child: Container(
                                          width: SizeConfig.w * 0.65,
                                          // padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            snapshot.data[index].name ?? "Name",
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
                                      )
                                    ]),
                              ));
                          // Text(snapshot.data[index].name);
                        },
                      );
                    } else if ((_filteredList?.isEmpty ?? false) &&
                        Query != null) {
                      return Container(
                          height: SizeConfig.h * 0.5,
                          child: Center(child: Text("No products found")));
                    }

                    if (snapshot.hasError) {
                      return Text("No products found");
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            top: 20,
                            bottom: 15,
                          ),
                          child: Text(
                            "Categories",
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'Quicksand',
                                    ),
                          ),
                        ),
                        Consumer<ProductListData>(builder: (context, menu, ch) {
                          return LayoutBuilder(builder: (context, boxconst) {
                            if (rowList.isEmpty){
                              if(menu.categoryList[0].menuName!="All")
                              menu.categoryList.insert(
                                  0,
                                  HeaderJson(
                                    menuName: "All",
                                    // " this.hrefUrl",
                                    //  this.menuType,
                                    //  this.subMenu1,
                                  ));

                              menu.categoryList?.forEach((pro) {
                                rowList.add(GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    bool isLogin =
                                        prefs.getBool("isLogin") ?? false;
                                    Provider.of<ProductListData>(context,
                                            listen: false)
                                        .setMenu(
                                            menu.categoryList?.indexOf(pro));
if(menu.categoryList?.indexOf(pro)==0){
  Navigator.of(context).pushNamed('/Pages',
      arguments: RouteArgument(id: "0", isLogin: isLogin));
}
else {
  Map productRes = isLogin
      ? await ApiServices.getRequestPincode(
      pro.hrefUrl + "?json=1")
      : await ApiServices.getRequest(
      pro.hrefUrl + "?json=1");
  if (productRes != null) {
    // stopLoading();
    Provider.of<ProductListData>(context,
        listen: false)
        .setProductListData(productRes);
    Provider.of<ProductListData>(context,
        listen: false)
        .setData(
        List<Item>.from((productRes[
        "items"]
            ?.map((x) =>
            Item.fromMap(x))) ??
            []),
        isSubCat: false);
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

  Navigator.of(context)
      .push(MaterialPageRoute(
      builder: (_) =>
          ProductList(
            linker: pro.hrefUrl,
            isLogin: isLogin,
          )));
}   },
                                  child: Container(
                                      height: 25,
                                      // width: 200,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        // border: BoxBorder(),
                                        border: Border.all(width: 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        color: Colors.white,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 8),
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(pro.menuName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                      )),
                                ));
                              });


                            }
                            return Wrap(children: rowList);
                          });
                        }),
                      ],
                    );
                  })
            ],
          ),
        ));
  }
}

//     ],
//   ),
// ),
//     );
//   }
// }
