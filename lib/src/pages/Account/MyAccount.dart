import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/Account/profile.dart';
import 'package:ECom/src/pages/Account/support.dart';
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

class MyAccount extends StatefulWidget {
  MyAccount({Key key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithPop(context, "My Account",
            needSearch: true, needCart: true, ispop: false),
        body:
            //  _isLoading
            //     ? Shimmer.fromColors(
            //         baseColor: Colors.grey[400],
            //         highlightColor: Colors.white,
            //         child: LoadingMyAccount(),
            //       )
            // :
            Consumer<UserData>(builder: (context, userData, ch) {
          return ListView(
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
                    'assets/icons/user1.png',
                    height: 36,
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    userData.currentUser.name ?? "Name",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: SizeConfig.w * 0.05),
                  ),
                  subtitle: Text(
                    userData.currentUser.phone ?? "9000889990",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: SizeConfig.w * 0.035),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Profile(
                                name: userData.currentUser.name,
                                email: userData.currentUser.email,
                              )));
                    },
                    icon: Image.asset("assets/icons/pencil.png",
                        height: 18, color: Theme.of(context).accentColor),
                  )),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/myorders32.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "My Orders",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/OrderHistory');
                },
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
                  'assets/icons/earnings32.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "My Earnings",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/MyEarnings');
                },
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
                  'assets/icons/location1.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "My Address",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/AllAddress');
                },
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
                  'assets/icons/referral24.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Refer your friends",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/ReferYourFriend');
                },
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
                  'assets/icons/support32.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Support",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Support(
                            userObject: userData.currentUser,
                          )));
                },
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
                  'assets/icons/information.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Help",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.of(context).pushNamed('/help'),
              ),
              Divider(
                thickness: 1,
              ),

              // Divider(
              //   thickness: 1,
              // ),
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                dense: true,
                leading: Image.asset(
                  'assets/icons/logout.png',
                  height: 25,
                  color: Theme.of(context).accentColor,
                ),
                title: Text(
                  "Logout",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: SizeConfig.w * 0.05),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      // insetPadding:  EdgeInsets.all(20),
                      titlePadding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                      contentPadding: EdgeInsets.fromLTRB(40, 5, 40, 0),
                      backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                      title: Text('Logout from shopsasta?',
                          style: TextStyle(color: Colors.white)),
                      // content: Text('Your Credentials will be vanished!',
                      //     style: TextStyle(color: Colors.white)),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            SharedPreferences ap =
                                await SharedPreferences.getInstance();
                            await ap.remove("token");
                            // await ap.remove("isLogin");
                            await ap.setBool("isLogin", false);
                            await ap.remove("email");
                            await ap.remove("userName");
                            await ap.remove('pinCode');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen(isHome: true)));
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          );
        }),
      ),
    );
  }
}
// -
// -
// -
// -
// -
// - assets/icons/.png
