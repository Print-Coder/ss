import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/models/dynamicLink.dart';
import 'package:ECom/src/models/orderData.dart';
import 'package:ECom/src/pages/orders/orderDetailsFCM.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/category.dart';
import 'package:ECom/src/pages/home/customAppBar.dart';
import 'package:ECom/src/pages/productListing/productListing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/pages/home/homeTitle.dart';
import 'package:ECom/src/pages/home/categorylist.dart';
import 'package:ECom/src/pages/home/categorylistLoad.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:overlay_support/overlay_support.dart' as overlay;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../elements/CardsCarouselWidget.dart';
import '../elements/LoadCardWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import 'auth/register.dart';
import 'cart/api/CartData.dart';
import 'home/customAppBar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:ECom/src/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/widget/pincodeFab.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:overlay_support/overlay_support.dart' as overlay;
import 'orders/orderDetails.dart';
import 'orders/orderDetailsFCMRefund.dart';
import 'orders/orderDetailsRefund.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

bool isRegister = false;

class _HomeWidgetState extends State<HomeWidget> with WidgetsBindingObserver {
  List<Item> productList;
  List<HeaderJson> categoryList = [];
  int index = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // (Provider.of<ProductListData>(context, listen: false).items?.isEmpty)
    //     ?
    List<OrderData> OrderList = [];

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      SizeConfig().init(context);
      print("on message");
      print(message ?? "null");
      if (message["data"]["orderid"] != null) {
        overlay.showSimpleNotification(
          Text(message["notification"]["title"] ?? "Order Update"),
          // leading: NotificationBadge(totalNotifications: _totalNotifications),
          subtitle: Row(
            children: [
              SizedBox(
                width: SizeConfig.w * 0.65,
                child: textH6(message["notification"]["body"] ?? "Order Update",
                    textstyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    maxLines: 2),
              ),
              FlatButton(
                child: Text(
                  "Open",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white, fontSize: 18),
                ),
                onPressed: () async {
                  Map OrderListRes = await ApiServices.postRequestToken(
                      '''{}''', getOrderEndPoint);
                  if (OrderListRes != null &&
                      message["data"]["orderid"] != null) {
                    OrderList = List<OrderData>.from((OrderListRes["items"]
                            ?.map((x) => OrderData.fromMap(x))) ??
                        []);
                    print(message ?? "null");
// if(OrderList.contains((element)=>element.or))
                    OrderData currentItem = OrderList.firstWhere(
                        (e) => e.orderDataId == message["data"]["orderid"]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                currentItem.status.toLowerCase() == "refunded"
                                    ? OrderDetailsRefund(orderData: currentItem)
                                    : OrderDetails(orderData: currentItem)));
                  }
                },
              )
            ],
          ),
          slideDismiss: true,
          background: Theme.of(context).primaryColor,
          duration: Duration(seconds: 5),
        );
      }
    }, onLaunch: (Map<String, dynamic> message) async {
      print("inside launch of notification");
      print("launch $message ");

      if (message["data"]["orderid"] != null) {
        Map OrderListRes =
            await ApiServices.postRequestToken('''{}''', getOrderEndPoint);
        if (OrderListRes != null && message["data"]["orderid"] != null) {
          OrderList = List<OrderData>.from(
              (OrderListRes["items"]?.map((x) => OrderData.fromMap(x))) ?? []);
          // SharedPreferences pref = await SharedPreferences.getInstance();
          // String messageId = pref.getString("messageId") ?? "not";
          // print("thi is meddage id " +
          //     messageId +
          //     " " +
          //     pref.getString("messageId"));

          // if (messageId == message["data"]["google.sent_time"].toString()) {
          //   print("inside message id");
          //   return;
          // } else {
          // await Future.delayed(Duration(milliseconds: 500)).then(
          //     (c) =>
          OrderData currentItem = OrderList.firstWhere(
              (e) => e.orderDataId == message["data"]["orderid"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => currentItem.status.toLowerCase() == "refunded"
                      ? OrderDetailsFCMRefund(
                          orderData: currentItem,
                        )
                      : OrderDetailsFCM(orderData: currentItem))
              // )
              //             .then((c) async {
              //   pref.setString("messageId", "already");
              // })

              );
          // }
        }
        // showDialog( 0:161846506821249
        //           context: context,
        //           builder: (context) => AlertDialog(title: Text(message["data"]["jatin"])));
      }
    }, onResume: (Map<String, dynamic> message) async {
      print("inside resume of notification" + message.toString());
      if (message["data"]["orderid"] != null) {
        Map OrderListRes =
            await ApiServices.postRequestToken('''{}''', getOrderEndPoint);
        if (OrderListRes != null && message["data"]["orderid"] != null) {
          OrderList = List<OrderData>.from(
              (OrderListRes["items"]?.map((x) => OrderData.fromMap(x))) ?? []);
          // showDialog(
          //     context: context,
          //     builder: (context) =>
          //         AlertDialog(title: Text(message["data"]["orderid"])));
          // SharedPreferences pref = await SharedPreferences.getInstance();
          // String messageId = pref.getString("messageIdResume") ?? "not";
          // if (messageId == message["data"]["google.sent_time"].toString()) {
          //   print("inside message id");
          //   return;
          // }
          OrderData currentItem = OrderList.firstWhere(
              (e) => e.orderDataId == message["data"]["orderid"]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => currentItem.status.toLowerCase() == "refunded"
                      ? OrderDetailsFCMRefund(orderData: currentItem)
                      : OrderDetailsFCM(orderData: currentItem)));
          //             .then((c) async {
          //   pref.setString("messageIdResume",
          //       message["data"]["google.sent_time"].toString());
          // });
        }
        // showDialog(
        //           context: context,
        //           builder: (context) => AlertDialog(title: Text(message["data"]["jatin"])));
      }
    });
    getProductList(refresh: false)
        // : null
        ;

    // WidgetsBinding.instance.addObserver(this);
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   WidgetsBinding.instance.removeObserver(this);
  // }

//------------------- dynamic link block start----------------------//
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   super.didChangeAppLifecycleState(state);

  //   FirebaseDynamicLinks.instance.onLink(
  //     onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //       print(
  //           "dynamic link inside on link ${dynamicLink.link.pathSegments.last}");

  //       switch (state) {
  //         case AppLifecycleState.resumed:
  //           Map<bool, String> arg =
  //               DynamicLinkService().handleDeepLink(dynamicLink);
  //           print("resumed ${arg}");

  //           if (arg.keys.toList()[0]) {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (_) => ProductWidget(
  //                           linker: arg[true],
  //                         )));

  //             print("arg is not null${arg[true]}");
  //           } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
  //             SharedPreferences pref = await SharedPreferences.getInstance();
  //             print(arg[false]);
  //             pref.setString("regReferal", arg[false]);
  //           }
  //           break;
  //         case AppLifecycleState.inactive:
  //           print("inactive ${dynamicLink.link.pathSegments.last}");

  //           break;
  //         case AppLifecycleState.paused:
  //           print("paused ${dynamicLink.link.pathSegments.last}");

  //           Map<bool, String> arg =
  //               await DynamicLinkService().handleDynamicLinks();

  //           if (arg.keys.toList()[0]) {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (_) => ProductWidget(
  //                           linker: arg[true],
  //                         )));

  //             print("arg is not null${arg[true]}");
  //           } else if (arg.keys.toList()[0] == false && arg[false] != "null") {
  //             SharedPreferences pref = await SharedPreferences.getInstance();
  //             pref.setString("regReferal", arg[false]);
  //           }
  //           break;
  //         case AppLifecycleState.detached:
  //           print("detached ${dynamicLink.link.pathSegments.last}");

  //           break;
  //       }
  //     },
  //     onError: (OnLinkErrorException e) async {
  //       print('Link Failed: ${e.message}');
  //     },
  //   );
  // }
//-------------------dynamic link block start----------------------//

//
  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  Map<String, Map<String, List<Item>>> homeJson = {
    "All Groceries": {},
    "Deals of the Day": {},
    "Best Seller": {},
    "HouseHolds": {},
    "Healthier Food": {},
  };
  Map<String, String> homeJsonUrl = {
    "All Groceries": "",
    "Deals of the Day": "",
    "Best Seller": "",
    "HouseHolds": "",
    "Healthier Food": "",
  };
  List<String> recItem;
  bool isLogin;
  getProductList({bool refresh}) async {
    refresh ? print("refresh is true") : showLoading();
    // await Future.delayed(Duration(milliseconds: 1000));
    // if (isLogin) {
    //   print(
    //       "is login is true and this is the pincode=${Provider.of<UserData>(context, listen: false).currentUser.addresses[Provider.of<UserData>(context, listen: false).currentUser.addressIndex].zip}");
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool("isLogin") ?? false;
    Map userRes;
    Map<dynamic, dynamic> cartRes = {};
    print("inside home $isLogin");
    categoryList = [];
    Map category = isLogin
        ? await ApiServices.getRequestPincode(getCategoryEndPoint)
        : await ApiServices.getRequest(getCategoryEndPoint);

    String token = await prefs.getString('token');

    // String isLoginSp = await prefs.getString('isLogin');
    // print("login sp");
    // print(isLoginSp); nn
    // setState(() {
    //   isLogin = isLoginSp != null && isLoginSp == "true";
    // });
    ///////////-----------------for categories and product ----------------------

    List<Product> currentcart = [];
    if (category != null) {
      Provider.of<ProductListData>(context, listen: false)
          .setStock(category["homepageJson"]["stockStatus"] ?? false);
      //  if(!  category["homepageJson"]["stockStatus"]  )  Fluttertoast.showToast(
      //       msg: "Your Area is not in serviceable.",
      //       backgroundColor: Colors.grey[400],
      //       toastLength: Toast.LENGTH_LONG,
      //       gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 2,
      //     );
      category["headerJson"]
          .forEach((x) => categoryList.add(HeaderJson.fromMap(x)));
      // print("for home page --$category");
      homeJson["All Groceries"] = {
        category["homepageJson"]["data"]["allGroceries"]["name"]:
            List<Item>.from((category["homepageJson"]["data"]["allGroceries"]
                        ["products"]
                    ?.map((x) => Item.fromMap(x))) ??
                [])
      };
      homeJsonUrl["All Groceries"] =
          category["homepageJson"]["data"]["allGroceries"]["url"] ?? "";
      homeJson["Deals of the Day"] = {
        category["homepageJson"]["data"]["dealOfTheDay"]["name"]:
            List<Item>.from((category["homepageJson"]["data"]["dealOfTheDay"]
                        ["products"]
                    ?.map((x) => Item.fromMap(x))) ??
                [])
      };
      homeJsonUrl["Deals of the Day"] =
          category["homepageJson"]["data"]["dealOfTheDay"]["url"] ?? "";

      homeJson["Best Seller"] = {
        category["homepageJson"]["data"]["bestSeller"]["name"]: List<Item>.from(
            (category["homepageJson"]["data"]["bestSeller"]["products"]
                    ?.map((x) => Item.fromMap(x))) ??
                [])
      };
      homeJsonUrl["Best Seller"] =
          category["homepageJson"]["data"]["bestSeller"]["url"] ?? "";

      homeJson["HouseHolds"] = {
        category["homepageJson"]["data"]["houseHolds"]["name"]: List<Item>.from(
            (category["homepageJson"]["data"]["houseHolds"]["products"]
                    ?.map((x) => Item.fromMap(x))) ??
                [])
      };
      homeJsonUrl["HouseHolds"] =
          category["homepageJson"]["data"]["allGroceries"]["url"] ?? "";

      // https://shopsasta.page.link/Apy1ouJUjn3v9siY8
      homeJson["Healthier Food"] = {
        category["homepageJson"]["data"]["healthierFood"]["name"]:
            List<Item>.from((category["homepageJson"]["data"]["healthierFood"]
                        ["products"]
                    ?.map((x) => Item.fromMap(x))) ??
                [])
      };
      homeJsonUrl["Healthier Food"] =
          category["homepageJson"]["data"]["houseHolds"]["url"] ?? "";
      // print(category["homepageJson"]["data"]["bannersMobile"]);
      recItem = List<String>.from(category["homepageJson"]["data"]
                  ["bannersMobile"]
              .map((x) => x["pictures"].toString()) ??
          []);

      // productList =
      //     List<Item>.from((res["items"]?.map((x) => Item.fromMap(x))) ?? []);

      Provider.of<ProductListData>(context, listen: false).setData(
          List<Item>.from((category["homepageJson"]["data"]["allGroceries"]
                      ["products"]
                  ?.map((x) => Item.fromMap(x))) ??
              []),
          isSubCat: false);

      Provider.of<ProductListData>(context, listen: false)
          .setCategory(categoryList);
    } //status is true for product header

    else {
      // stopLoading();
      // Fluttertoast.showToast(
      //   msg: "Server is not responding",
      //   backgroundColor: Colors.grey[400],
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 2,
      // );
    }

    ///////////-----------------for login check----------------------

    if (token != null) {
      Map res;
      print(" $token ");
      try {
        userRes = await ApiServices.getRequestToken(userAddEndPoint);
      } catch (e) {
        await prefs.remove('token');

        Fluttertoast.showToast(
          msg: "Server is not responding",
          backgroundColor: Colors.grey[400],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
        );
      }

      if (userRes != null) if (userRes["addresses"] != null &&
          (userRes["addresses"] ?? []).isEmpty) {
        // stopLoading();
        setState(() {
          isLogin = false;
        });
        stopLoading();

        // Navigator.of(context).pushNamed('/Intro');
      } //user login but didn't register , make islogin false and go to intro
      else if (userRes["status"] != null &&
          (userRes["status"] == false ?? true)) {
        await prefs.remove('token');

        setState(() {
          isLogin = false;
        });
        stopLoading();
      } else {
        //has token and address
        setState(() {
          isLogin = true;
        });
        var userProvider = Provider.of<UserData>(context, listen: false);
        userProvider.setUser(userRes);
        // setState(() {
        //   isLogin = true;
        //   isRegister = true;
        // // });
        // // stopLoading();

        // await prefs.setString(
        //     'pinCode',
        // userRes["addresses"]
        //     .any((a) => a["setDefault"] == true)["pinCode"]);
        cartRes = await ApiServices.getRequestToken(cartEndPoint);
        //----------------------------------------------cart---------------
        if (cartRes["status"]) {
          currentcart = List<Product>.from(
              (cartRes["data"]["products"]?.map((x) => Product.fromMap(x))) ??
                  []);

          Provider.of<CartData>(context, listen: false)
              .setCartData(cartRes["data"] ?? {});
        } else {
          // stopLoading();

          Provider.of<CartData>(context, listen: false).setCartData(cartRes);
        }

        // ---------------------------
      }
    } //no token so go to Intro
    else {
      setState(() {
        isLogin = false;
      });
      stopLoading();

      print("token is  null");
      // Navigator.of(context).pushNamed('/Intro');
    }

    stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Shimmer.fromColors(
                        baseColor: Colors.grey[400],
                        highlightColor: Colors.white,
                        child: CategoryListLoad()),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Image.asset(
                          'assets/img/loading.gif',
                          height: 100,
                          width: SizeConfig.w * 0.8,
                          fit: BoxFit.fitWidth,
                          // width: double.infinity,
                          // height: 140,
                        ),
                      ),
                    ),
                    HomeLoadWidget()
                  ]),
            ),
          )
        : Consumer<UserData>(builder: (context, userData, ch) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(SizeConfig.h * 0.11),
                  child: AppBar(
                    flexibleSpace: Container(
                      // margin: EdgeInsets.only(top: SizeConfig.h * 0.037),
                      // padding: EdgeInsets.only(left: SizeConfig.w * 0.035),
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
                      //   ),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: SizeConfig.w * 0.045),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Text("shopsasta",
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .headline5
                                //         .copyWith(
                                //           fontWeight: FontWeight.w800,
                                //           fontFamily: "QuickSand",
                                //           fontSize: SizeConfig.w * 0.062,
                                //         )
                                //         .merge(
                                //           TextStyle(
                                //               letterSpacing: 1.3,
                                //               color: Theme.of(context)
                                //                   .primaryColor),
                                //         )),
                                Image.asset(
                                  'assets/icons/SHOPSASTA_200X45.png',
                                  width: SizeConfig.w * 0.29,
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      // showSearch(context: context, delegate: ProductSearch());
                                      Navigator.of(context)
                                          .pushNamed('/Search');
                                    },
                                    child: searchIcon(context)),
                                new ShoppingCartButtonWidget(
                                    iconColor:
                                        Theme.of(context).primaryColorLight,
                                    labelColor: Theme.of(context).primaryColor),
                              ],
                            ),
                          ),
                          CategoryList(
                            isSub: false,
                          ),
                          Divider(
                              thickness: 1.2,
                              height: 1.2,
                              color: Colors.grey[300]),
                        ],
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ),
                body: RefreshIndicator(
                  onRefresh: () => getProductList(refresh: true),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: HomeSliderWidget(slides: recItem),
                          ),
                          Consumer<ProductListData>(
                              builder: (context, productListData, ch) {
                            return !(productListData?.stockStatus ?? true)
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
                          // All Groceries
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, sepearatedIndecx) {
                                return Container(height: 10);
                              },
                              itemCount: homeJson.length,
                              itemBuilder: (context, homeIndex) {
                                if (homeJson.values
                                        .toList()[homeIndex]
                                        .values
                                        .toList()[0]
                                        ?.isNotEmpty ??
                                    true)
                                  return Column(children: <Widget>[
                                    HomeTitle(
                                      viewAllPressed: () async {
                                        // Provider.of<ProductListData>(context,
                                        //         listen: false)
                                        //     .setData(homeJson.values
                                        //         .toList()[homeIndex]);
                                        Map productRes = isLogin
                                            ? await ApiServices
                                                .getRequestPincode(homeJsonUrl
                                                        .values
                                                        .toList()[homeIndex] +
                                                    "?json=1")
                                            : await ApiServices.getRequest(
                                                homeJsonUrl.values
                                                        .toList()[homeIndex] +
                                                    "?json=1");
                                        if (productRes != null) {
                                          // stopLoading();
                                          // Provider.of<ProductListData>(contexss
                                          print("befor view all the items are" +
                                              homeJsonUrl.values
                                                  .toList()[homeIndex]);
                                          print(productRes["items"].toString());
                                          Provider.of<ProductListData>(context,
                                                  listen: false)
                                              .setProductListData(productRes);
                                          Provider.of<ProductListData>(context,
                                                  listen: false)
                                              .setData(
                                                  List<Item>.from(
                                                      (productRes["items"]?.map(
                                                              (x) =>
                                                                  Item.fromMap(
                                                                      x))) ??
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

                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => ProductList(
                                                      linker: homeJsonUrl.values
                                                          .toList()[homeIndex],
                                                      isCat: "false",
                                                      isLogin: isLogin,
                                                    )));
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //         builder: (_) => ProductList(

                                        //             )));
                                        // Navigator.of(context)
                                        //     .pushNamed("/ProductList");
                                      },
                                      title: homeJson.values
                                          .toList()[homeIndex]
                                          .keys
                                          .toList()[0],
                                    ),
                                    CardsCarouselWidget(
                                        productList: homeJson.values
                                            .toList()[homeIndex]
                                            .values
                                            .toList()[0],
                                        EComList: catList,
                                        heroTag:
                                            homeJson.keys.toList()[homeIndex]),
                                    homeIndex == homeJson.length - 1
                                        ? SizedBox(
                                            height: 50,
                                          )
                                        : Container()
                                  ]);
                                else {
                                  return Container();
                                }
                              }),
                        ]),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: PinCodeFab(),
              ),
            );
          });
  }
}
