import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/Account/profile.dart';
import 'package:ECom/src/pages/auth/loginAndRegister.dart';
import 'package:ECom/src/pages/cart/cartNoItem.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'myaccountLoad.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/home.dart';

class Help extends StatefulWidget {
  Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String mainName;
  String phoneNo;
  @override
  void initState() {
    super.initState();
    // getUserData();
  }

  //   "name": "Sowmya",
  // "firstname": "Sowmya",
  // "lastname": "Chowdam",
  // "

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavBar(
            index: 3,
            isLogin: true,
          ),
          backgroundColor: Colors.white,
          appBar: AppBarWithPop(context, "Help",
              needSearch: true, needCart: true, ispop: true),
          body:
              //  _isLoading
              //     ? Shimmer.fromColors(
              //         baseColor: Colors.grey[400],
              //         highlightColor: Colors.white,
              //         child: LoadingMyAccount(),
              //       )
              // :
              ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 18,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "About Us",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/aboutUsWeb'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Delivery Coverage",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed('/deliveryCoverageWeb'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "How It Works",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/howItWorks'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Faq",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/faq'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Vendor Resources",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/vendor'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Privacy Policy",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/privacyPolicy'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Cancellation Policy",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed('/cancellationPolicy'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Return Refund",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/returnRefund'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/terms-and-conditions.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Terms & Conditions",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () => Navigator.of(context).pushNamed('/termConditions'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          )),
    );
  }
}
// -
// -
// -
// -
// -
// - assets/icons/.png
