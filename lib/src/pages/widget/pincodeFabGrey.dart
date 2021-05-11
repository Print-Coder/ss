import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/pages/Account/address/AllAddress.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinCodeFabGrey extends StatefulWidget {
  int timer;
  PinCodeFabGrey({Key key, this.timer}) : super(key: key);

  @override
  _PinCodeFabGreyState createState() => _PinCodeFabGreyState();
}

class _PinCodeFabGreyState extends State<PinCodeFabGrey> {
  bool _show = false, isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = false;
    timerForPin();
  }

  timerForPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool("isLogin") ?? false;
    });
    // setState(() {
    //   _show = false;
    // });
    // await Future.delayed(Duration(milliseconds: 800));
    // setState(() {
    //   _show = true;
    // });
    setState(() {
      _show = true;
    });
    await Future.delayed(Duration(seconds: 20), () {
      if (mounted)
        setState(() {
          _show = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (!isLogin)
        ? Container()
        : !_show
            ? Container()
            : Consumer<UserData>(builder: (context, userData, ch) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  width: SizeConfig.w * 0.92,
                  height: 40.0,
                  color: Theme.of(context).primaryColorLight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Image.asset(
                          'assets/icons/location1.png',
                          height: 16,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: SizeConfig.w * 0.3),
                            child: Text(
                              userData
                                  .currentUser
                                  .addresses[
                                      userData?.currentUser?.addressIndex ?? 0]
                                  .area,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          Text(
                              " - " +
                                  userData
                                      .currentUser
                                      .addresses[
                                          userData?.currentUser?.addressIndex ??
                                              0]
                                      .zip,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor))
                        ],
                      ),
                      Spacer(),
                      FlatButton(
                          child: Text(
                            "Change",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onPressed: () =>
                              //  showDialog(
                              //       context: context,
                              //       builder: (context) => AlertDialog(
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(8)),
                              //         // insetPadding:  EdgeInsets.all(20),
                              //         titlePadding:
                              //             EdgeInsets.fromLTRB(15, 30, 0, 10),
                              //         contentPadding:
                              //             EdgeInsets.fromLTRB(20, 5, 20, 0),
                              //         // backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                              //         title: Text('Change the Default Address?',
                              //             style: Theme.of(context)
                              //                 .textTheme
                              //                 .headline5),
                              //         content: Text('Your Cart will be cleared!!!',
                              //             style: Theme.of(context)
                              //                 .textTheme
                              //                 .headline6),
                              //         actions: <Widget>[
                              //           FlatButton(
                              //             onPressed: () =>
                              //                 Navigator.of(context).pop(false),
                              //             child: Text('No',
                              //                 style: Theme.of(context)
                              //                     .textTheme
                              //                     .headline6),
                              //           ),
                              //           FlatButton(
                              // onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllAddress(
                                            fromChange: true,
                                          )))

                          //   },
                          //   child: Text('Yes'),
                          // ),

                          )
                    ],
                  ),
                );
              });
  }
}
