import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/home/customAppBar.dart';
import 'package:ECom/src/pages/home/categorylist.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProductItemWidget.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/widget/pincodeFab.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProductList extends StatefulWidget {
  // final GlobalKey<ScaffoldState> parentScaffoldKey;
  // List<Item> productList;
  String isCat;
  String linker;
  @required
  bool isLogin;
  ProductList(
      {Key key,
      // this.productList,
      this.isLogin,
      this.isCat,
      this.linker})
      : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Item> productList = [];
  String catEndpoint;
  int pages, page;
  // HomeController _con;

  // _ProductListState() : super(HomeController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  ScrollController controller;

  void _scrollListener() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool("isLogin") ?? false;
    // print("inside controller" + controller.position.extentAfter.toString());
    // if (widget.isCat != "false")
    if (controller.position.extentAfter == 0.0) {
      if (page < pages) {
        page += 1;
        Map productRes = isLogin
            ? await ApiServices.getRequestPincode(
                catEndpoint + "?json=1&page=$page")
            : await ApiServices.getRequest(catEndpoint + "?json=1&page=$page");

        if (productRes != null) {
          stopLoading();
          // print("after pagnation for $page");
          // print(productRes);
          Provider.of<ProductListData>(context, listen: false)
              .setProductListData(productRes);
          Provider.of<ProductListData>(context, listen: false).addData(
              List<Item>.from(
                  (productRes["items"]?.map((x) => Item.fromMap(x))) ?? []));
          Provider.of<ProductListData>(context, listen: false)
              .increasePage(page);
        } else {
          stopLoading();
          Fluttertoast.showToast(
            msg: "Server is not responding",
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
          );
        }
      }
    }
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  bool isLogin;
  getProduct(String endPoint, bool isSubCat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLogin = prefs.getBool("isLogin") ?? false;
    // showLoading();
    Map productRes = isLogin
        ? await ApiServices.getRequestPincode(endPoint + "?json=1")
        : await ApiServices.getRequest(endPoint + "?json=1");
    if (productRes != null) {
      stopLoading();

      productList = List<Item>.from(
          (productRes["items"]?.map((x) => Item.fromMap(x))) ?? []);
      Provider.of<ProductListData>(context, listen: false)
          .setProductListData(productRes);
      Provider.of<ProductListData>(context, listen: false)
          .setData(productList, isSubCat: isSubCat);
    } else {
      stopLoading();
      Fluttertoast.showToast(
        msg: "Server is not responding",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
    }
  }

  int index = 0;
  List<String> productCategory = [
    "All",
    "Grocery",
    "Spices",
    "Oils",
    "Dry Fruits& Nuts",
    "Household"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(
          index: 0,
          isLogin: isLogin,
        ),
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "Products",
            needSearch: true, needCart: true, ispop: false),
        body: Consumer<ProductListData>(builder: (context, category, ch) {
          // if (category.isSubCategory)
          catEndpoint = widget.linker != null
              ? widget.linker
              : widget.isCat == "false"
                  ? ""
                  : category.categoryList[category.selectedMenu]
                      .subMenu1[category.selectedSubMenu].hrefUrl;

          pages = category?.productListData?.pages ?? 0;
          page = category?.productListData?.page ?? 0;
          if (category?.items?.isEmpty ?? true) {
            return RefreshIndicator(
              onRefresh: () => Future.delayed(Duration(seconds: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.isCat == null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: CategoryList(
                            isSub: true,
                          ),
                        )
                      : Container(),
                  Divider(thickness: 1.2, height: 1.2, color: Colors.grey[300]),
                  Consumer<ProductListData>(
                      builder: (context, productListData, ch) {
                    return !productListData.stockStatus
                        ? Container(
                            alignment: Alignment.center,
                            width: SizeConfig.w,
                            height: 30.0,
                            color:
                                // Colors.redAccent,

                                Colors.white,
                            child: Center(
                                child: AutoSizeText(
                              "We are not delivering in your area yet",
                              maxLines: 1,
                              style: TextStyle(
                                  color:
                                      // Colors.white),

                                      Colors.redAccent),
                            )))
                        : Container();
                  }),
                  Container(
                    height: SizeConfig.h * 0.7,
                    child: Center(
                      child: Text("No Products yet!"),
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
              onRefresh: !category.isSubCategory
                  ? () => widget.linker != null
                      ? getProduct(widget.linker, false)
                      : Future.delayed(Duration(milliseconds: 20))
                  : () => getProduct(
                      category.categoryList[category.selectedMenu]
                          .subMenu1[category.selectedSubMenu].hrefUrl,
                      true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.isCat == null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 1.0),
                          child: CategoryList(
                            isSub: true,
                          ),
                        )
                      : Container(),
                  Divider(thickness: 1.2, height: 1.2, color: Colors.grey[300]),
                  Consumer<ProductListData>(
                      builder: (context, productListData, ch) {
                    return !productListData.stockStatus
                        ? Container(
                            alignment: Alignment.center,
                            width: SizeConfig.w,
                            height: 30.0,
                            color:
                                // Colors.redAccent,

                                Colors.white,
                            child: Center(
                                child: AutoSizeText(
                              "We are not delivering in your area yet",
                              maxLines: 1,
                              style: TextStyle(
                                  color:
                                      // Colors.white),

                                      Colors.redAccent),
                            )))
                        : Container();
                  }),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      controller: controller,
                      padding: EdgeInsets.symmetric(vertical: 1),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: category?.items?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return Divider(
                            thickness: 1, height: 1.2, color: Colors.grey[300]);
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ProductItemWidget(
                              stockStatus: category?.stockStatus ?? false,
                              productData: category?.items[index],
                              heroTag: 'details_featured_product',
                              product: productImg
                                  .elementAt(index % productImg.length),
                            ),
                            index == category?.items?.length - 1
                                ? SizedBox(
                                    height: 50,
                                  )
                                : Container()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ));
        }),
        floatingActionButton: PinCodeFab());
  }
}
