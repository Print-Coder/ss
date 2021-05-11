import 'dart:convert';

import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ECom/src/helpers/constants.dart';

import 'package:flutter/material.dart';
import 'faq.dart';
import 'faqBody.dart';
import 'package:flutter/material.dart' as mate;

class FaqScreen extends StatefulWidget {
  String id, name;
  FaqScreen({this.id, this.name});
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen>
    with SingleTickerProviderStateMixin {
  String siteid;
  String empid;
  List<Faq> faqData = [];
  List<Widget> tabsBody = [];
  List<Widget> tabsName = [];
  bool nullisLoading = false;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    // _tabController = getcontroller();
    apiCall();
  }

  TabController getcontroller() {
    return TabController(length: (faqData?.length ?? 0), vsync: this);
  }

  Future<void> apiCall() async {
    setState(() {
      manLoading = true;
    });
    SharedPreferences store = await SharedPreferences.getInstance();
    // print("storing jwt locally");

    // print(siteid);
    List<dynamic> res = await ApiServices.getRequestList(faqEndPoint);
    print(res);

    print("in maintain" + res.toString());
    if (res != null) {
      setState(() {
        faqData = [];
        faqData.addAll(List<Faq>.from(res?.map((x) => Faq.fromMap(x)) ?? []));
        tabsName = [];
        faqData.isNotEmpty && (tabsName?.length ?? 0) <= (faqData?.length ?? 0)
            ? tabsName.addAll(faqData.map((e) => Tab(text: e.title)).toList())
            : null;

        if (faqData.isNotEmpty) {
          _tabController = getcontroller();
        }
      });

      // mantecList = List<String>(manPackList.length);

      setState(() {
        manLoading = false;
      });
    } else {
      setState(() {
        manLoading = false;
      });
    }

    //response is not null

    // login(context);
  }

  bool manLoading = false, isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  showLoading(bool show) {
    setState(() {
      isLoading = show;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    SizeConfig().init(context);

    if (manLoading)
      return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);

          return Future.value(true);
        },
        child: Scaffold(
            bottomNavigationBar: BottomNavBar(
              index: 3,
              isLogin: true,
            ),
            key: _scaffoldKey,
            appBar: AppBarWithPop(context, "Faq",
                needSearch: true, needCart: true, ispop: true),
            body: Center(
              child: CircularProgressIndicator(),
            )),
      );
    else if (faqData.isEmpty) {
      return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);

          return Future.value(true);
        },
        child: Scaffold(
            bottomNavigationBar: BottomNavBar(
              index: 3,
              isLogin: true,
            ),
            key: _scaffoldKey,
            appBar: AppBarWithPop(context, "Faq",
                needSearch: true, needCart: true, ispop: true),
            body: Center(
              child: Text("No Faq found"),
            )),
      );
    }
    setState(() {
      tabsBody = [];
      faqData.isNotEmpty && (tabsBody?.length ?? 0) <= (faqData?.length ?? 0)
          ? tabsBody
              .addAll(faqData.map<Widget>((e) => FaqBody(faqdata: e)).toList())
          : null;
    });
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavBar(
          index: 3,
          isLogin: true,
        ),
        appBar: AppBar(
          bottom: tabsBody?.isNotEmpty ?? false
              ? TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: tabsName.map((e) => e).toList(),
                  controller: _tabController,
                  indicatorColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                )
              : TabBar(tabs: [
                  Tab(
                    text: "a",
                  )
                ]),
          elevation: 0, backgroundColor: Colors.white,
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
                    onPressed: () => Navigator.of(context).pop()),
                Text(
                  "Faq",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ]),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Search');
                },
                child: Image.asset("assets/icons/search.png",
                    width: MediaQuery.of(context).size.width * 0.054,
                    color: Colors.black)),
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).primaryColorLight,
                labelColor: Theme.of(context).primaryColor)
          ],
          bottomOpacity: 1,
        ),
        body: SafeArea(
          child: TabBarView(
            children: tabsBody.map<Widget>((e) => e).toList(),
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
