import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';

class LoginScreen extends StatefulWidget {
  bool isHome;
  LoginScreen({this.isHome = false});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didUpdateWidget(LoginScreen oldwidget) {
  //   _setActiveTabIndex();
  //   super.didUpdateWidget(oldwidget);
  // }
  void _setActiveTabIndex() {
    // setState(() {
    //   print(_activeTabIndex);
    //   _activeTabIndex = _tabController.index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithPop(context, "Login & Register",
          ispop:
              (widget.isHome != null || widget.isHome == true) ? false : true,
          needSearch: false,
          needCart: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.h * 0.26,
              child: Center(
                child: Image.asset(
                  'assets/icons/SHOPSASTA_200X45.png',
                  width: SizeConfig.w * 0.5,
                ),
                //  Text("shopsasta",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headline5
                //         .copyWith(
                //             fontFamily: "Georgia",
                //             fontSize: SizeConfig.w * 0.09)
                //         .merge(
                //           TextStyle(
                //               letterSpacing: 1.3,
                //               color: Theme.of(context).primaryColor),
                //         )),
              ),
            ),
            // Text(
            //   "LOGIN & REGISTER",
            //   style: TextStyle(
            //       color: Theme.of(context).primaryColor, fontSize: 20),
            // ),
            // Container(
            //   // height: 2,
            //   width: SizeConfig.w * 0.55,
            //   // color: Theme.of(context).primaryColor,
            // ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.h * 0.025,
                  left: SizeConfig.w * 0.05,
                  right: SizeConfig.w * 0.05),
              // height: SizeConfig.h * 0.70,
              child: Login(),
            ),
          ],
        ),
      ),
    );
  }
}
