import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/customIcon.dart';
import 'package:ECom/src/models/orderData.dart';
import 'package:ECom/src/pages/Account/MyAccount.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../elements/DrawerWidget.dart';
import 'package:ECom/src/pages/cart/cartNoItem.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import 'auth/loginAndRegister.dart';
import 'group/MyGroup.dart';
import 'orders/orderDetails.dart';
import 'productListing/productListing.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../helpers/autoText.dart';
// import '../pages/map.dart';
// import '../pages/notifications.dart';
// import '../pages/orders.dart';
// import 'messages.dart';
import 'package:ECom/src/pages/sasta/sastaDeals.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  bool isLogin;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.isLogin,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  bool isLogin;
  SharedPreferences prefs;
  @override
  initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _selectTab(widget.currentTab);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
    });
    isLogin =
        widget?.routeArgument?.isLogin ?? prefs?.getBool("isLogin") ?? false;
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
    });
    isLogin =
        widget?.routeArgument?.isLogin ?? prefs?.getBool("isLogin") ?? false;

    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = !isLogin ? LoginScreen() : SastaDeals();
          break;
        case 2:
          widget.currentPage = !isLogin ? LoginScreen() : MyGroup();
          break;
        // case 3:
        //   widget.currentPage =
        //         HomeWidget(parentScaffoldKey: widget.scaffoldKey);
        //   break;
        case 3:
          widget.currentPage = !isLogin
              ? LoginScreen()
              : MyAccount(); //FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
      }
    });
  }

  PersistentTabController _controller;
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/home.png", height: 20),
        title: "Home",
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/discount32.png", height: 20),
        title: ("SASTA"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/get-money32.png", height: 20),
        title: ("Super Savers"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
        // activeColorAlternate: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CustomIcon.group),
        title: ("My Group"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("My Account"),
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Color before = Theme.of(context).primaryColor;
    Color after = Theme.of(context).accentColor;
    int index = widget.currentTab;
    return WillPopScope(
      onWillPop: index == 0
          ? Helper.of(context).exitFromAppp
          : () {
              Navigator.of(context)
                  .pushReplacementNamed('/Pages', arguments: 0);
              return Future.value(true);
            },
      child: Scaffold(
        key: widget.scaffoldKey,
        body: widget.currentPage,
        bottomNavigationBar: Container(
          color: Colors.white,
          height: SizeConfig.w * 0.17,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Divider(thickness: 1.2, height: 1.2, color: Colors.grey[300]),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,

                selectedItemColor: Theme.of(context).primaryColor,
                selectedFontSize:
                    //12,
                    SizeConfig.w * 0.036,
                unselectedFontSize:
                    //10,
                    SizeConfig.w * 0.036,
                iconSize: SizeConfig.w * 0.04,
                // SizeConfig.w * 0.05,
                elevation: 0,
                selectedLabelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400),
                unselectedLabelStyle: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.w400),
                backgroundColor: Colors.transparent,
                selectedIconTheme: IconThemeData(size: SizeConfig.w * 0.02),
                unselectedItemColor: Theme.of(context).accentColor,
                currentIndex: index,
                onTap: (int i) {
                  this._selectTab(i);
                },
                // this will be set when a new tab is tapped
                items: [
                  BottomNavigationBarItem(
                      title: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: SizeConfig.w * 0.036,
                            //SizeConfig.w * 0.028,
                            color: index == 0 ? before : after,
                          ),
                        ),
                      ),
                      // title: SizedBox(),
                      icon: Image.asset("assets/icons/home.png",
                          color: index == 0 ? before : after, height: 20)),
                  BottomNavigationBarItem(
                      title: FittedBox(
                        fit: BoxFit.fitWidth,
                        child:
                            // Flexible(
                            //   child:
                            Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Sasta",
                              style: TextStyle(
                                fontSize: SizeConfig.w * 0.036,

                                // SizeConfig.w * 0.028,
                                color: index == 1 ? before : after,
                              ),
                            ),
                            Icon(
                              Icons.add,
                              size: SizeConfig.w * 0.033,
                              color: index == 1 ? before : after,
                            )
                          ],
                        ),
                        // ),
                      ),
                      icon: Image.asset("assets/icons/discount32.png",
                          color: index == 1 ? before : after, height: 20)),
                  // BottomNavigationBarItem(
                  //     title: Column(
                  //       children: <Widget>[
                  //         FittedBox(
                  //           fit: BoxFit.fitWidth,
                  //           child: Text(
                  //             "Specials",
                  //             style: Theme.of(context).textTheme.headline6.copyWith(
                  //                   fontSize: SizeConfig.w * 0.02,
                  //                   color: index == 2 ? before : after,
                  //                 ),
                  //           ),
                  //         ),
                  //         index == 2
                  //             ? Container(
                  //                 height: 2,
                  //                 width: SizeConfig.w * 0.2,
                  //                 color: Theme.of(context).primaryColor)
                  //             : SizedBox()
                  //       ],
                  //     ),
                  //     icon: Image.asset("assets/icons/get-money32.png",
                  //         color: index == 2 ? before : after, height: 20)),
                  BottomNavigationBarItem(
                      title: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "My Group",
                          style: TextStyle(
                            fontSize: SizeConfig.w * 0.036,

                            // SizeConfig.w * 0.028,
                            color: index == 2 ? before : after,
                          ),
                        ),
                      ),
                      icon: new Image.asset("assets/icons/team.png",
                          height: 20, color: index == 2 ? before : after)),
                  BottomNavigationBarItem(
                      title: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "My Account",
                          style: TextStyle(
                            fontSize: SizeConfig.w * 0.036,

                            // SizeConfig.w * 0.028,
                            color: index == 3 ? before : after,
                          ),
                        ),
                      ),
                      icon: Image.asset("assets/icons/user.png",
                          height: 20, color: index == 3 ? before : after)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
