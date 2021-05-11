import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/auth/register.dart';
import 'package:ECom/src/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/helpers/constants.dart';

import 'package:ECom/src/pages/Account/earning/earned.dart';
import 'package:ECom/src/pages/Account/earning/used.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'earningData.dart';

class MyEarnings extends StatefulWidget {
  @override
  _MyEarningsState createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings>
    with SingleTickerProviderStateMixin {
  int _activeTabIndex = 0;
  TabController _tabController;
  List<EarningData> earningData;
  UsedData usedData;
  int balance = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_setActiveTabIndex);
    getEarning();
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() => setState(() {
        _isLoading = false;
      });
  bool _isLoading = false;
  getEarning() async {
    showLoading();
    Map res = await ApiServices.getRequestToken(earningEndPoint);
    print(res);
    if (res != null) if (res["data"] == null) {
      // stopLoading();

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => Register()));
    } else {
      earningData = List<EarningData>.from(
          res["data"]["items"]?.map((x) => EarningData.fromMap(x) ?? []));

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int addIndex = await prefs.getInt('addressIndex');
      // setState(() {
      //   isLogin = true;
      //   isRegister = true;
      // });
      // earningData.forEach((e) => balance += e.cashbackAmount);
      // stopLoading();
    }
    Map summaryres = await ApiServices.getRequestToken(summaryEndPoint);
    print(summaryres);
    if (summaryres != null) if (summaryres["data"] == null) {
      stopLoading();

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => Register()));
    } else {
      usedData = UsedData.fromMap(summaryres["data"]);

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int addIndex = await prefs.getInt('addressIndex');
      // setState(() {
      //   isLogin = true;
      //   isRegister = true;
      // });
      // earningData.forEach((e) => balance += e.cashbackAmount);
      stopLoading();
    }
  }

  // @override
  // void didUpdateWidget(MyEarnings oldwidget) {
  //   _setActiveTabIndex();
  //   super.didUpdateWidget(oldwidget);
  // }
  void _setActiveTabIndex() {
    setState(() {
      print(_activeTabIndex);
      _activeTabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: 3,
        isLogin: true,
      ),
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "My Earnings",
          needSearch: true, needCart: true, ispop: true),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<UserData>(builder: (context, userData, ch) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 10),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/icons/earnings32.png',
                              height: SizeConfig.w * 0.09,
                              color: Theme.of(context).accentColor,
                              fit: BoxFit.cover),
                          SizedBox(
                            width: SizeConfig.w * 0.02,
                          ),
                          SizedBox(
                            width: SizeConfig.w * 0.4,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Your Balance",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          // fontFamily: "Georgia",
                                          fontSize: SizeConfig.w * 0.05)),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.w * 0.02,
                          ),
                          Text(Helper.getPrice(
                                  // userData.currentUser.walletAmount
                                  usedData.balance ?? 0),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                      color: Colors.black,
                                      // fontFamily: "Georgia",
                                      fontSize: SizeConfig.w * 0.055)),
                          //
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, top: SizeConfig.h * 0.04),
                      child: textH5(
                          "Your earnings are based on the total order amount in the group and your referrals. More orders in a group gives more earnings.",
                          textstyle: Theme.of(context).textTheme.headline5,
                          maxLines: 3),
                    ),
                    Container(
                      height: SizeConfig.h * 0.7,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          leading: Container(),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            indicatorPadding: EdgeInsets.only(
                                // left: (_activeTabIndex == 0) ? SizeConfig.w * 0.2 : 0,
                                // right: (_activeTabIndex == 1) ? SizeConfig.w * 0.2:0
                                ),
                            controller: _tabController,
                            indicatorWeight: 3.5,
                            isScrollable: false,
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.yellow,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Total",
                                  style: TextStyle(
                                      color: _activeTabIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Summary",
                                  style: TextStyle(
                                      color: _activeTabIndex == 1
                                          ? Theme.of(context).primaryColor
                                          : Colors.black,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                            // controller: _tabController,
                            indicatorColor: Theme.of(context).primaryColor,
                            indicatorSize: TabBarIndicatorSize.label,
                          ),
                        ),
                        body: TabBarView(
                          controller: _tabController,
                          children: [
                            Earned(
                              earningData: earningData,
                              balance: balance,
                            ),
                            SummaryTAb(
                              usedData: usedData,
                              balance: balance,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
    );
  }
}
