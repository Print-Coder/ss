import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'local.dart';
import 'package:ECom/src/models/route_argument.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didUpdateWidget(OrderHistory oldwidget) {
  //   _setActiveTabIndex();
  //   super.didUpdateWidget(oldwidget);
  // }

  // void _setActiveTabIndex() {
  //   setState(() {
  //     print(_activeTabIndex);
  //     _activeTabIndex = _tabController.index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          index: 0,
          isLogin: true,
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,

          // Don't show the leading button
          titleSpacing: 0,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context).pushNamed('/Pages',
                      arguments: RouteArgument(id: "3", isLogin: true)),
                ),
                Text(
                  "Order History",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ]),
          actions: <Widget>[
            SizedBox(width: 20),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Search');
                },
                child: Image.asset("assets/icons/search.png",
                    width: 23, color: Colors.black)),
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).primaryColorLight,
                labelColor: Theme.of(context).primaryColor),
          ],
          // bottom: TabBar(
          //   indicatorPadding: EdgeInsets.only(
          //       // left: (_activeTabIndex == 0) ? SizeConfig.w * 0.2 : 0,
          //       // right: (_activeTabIndex == 1) ? SizeConfig.w * 0.2:0
          //       ),
          //   controller: _tabController,
          //   indicatorWeight: 3.5,
          //   isScrollable: false,
          //
          //   unselectedLabelColor: Colors.white,
          //   labelColor: Colors.yellow,
          //   tabs: [
          //     Tab(
          //       child: FittedBox(
          //         fit: BoxFit.fitWidth,
          //         child: Text(
          //           "shopsasta Orders",
          //           style: TextStyle(
          //               color: _activeTabIndex == 0
          //                   ? Theme.of(context).primaryColor
          //                   : Colors.black,
          //               fontSize: 20),
          //         ),
          //       ),
          //     ),
          //     Tab(
          //       child: FittedBox(
          //         fit: BoxFit.fitWidth,
          //         child: Text(
          //           "3rd party Orders",
          //           style: TextStyle(
          //               color: _activeTabIndex == 1
          //                   ? Theme.of(context).primaryColor
          //                   : Colors.black,
          //               fontSize: 20),
          //         ),
          //       ),
          //     ),
          //   ],
          //   // controller: _tabController,
          //   indicatorColor: Theme.of(context).primaryColor,
          //   indicatorSize: TabBarIndicatorSize.label,
          // ),
        ),
        body:
            // TabBarView(
            //   controller: _tabController,
            //   children: [
            LocalOrder(),
      ),
    );
  }
}
