import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SizeConfig.dart';

class BottomNavBar extends StatefulWidget {
  int index;
  bool isLogin;
  BottomNavBar({Key key, this.index, this.isLogin}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = widget.isLogin;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Color before = Theme.of(context).primaryColor;
    Color after = Theme.of(context).accentColor;

    return Container(
      color: Colors.white,
      height: SizeConfig.h * 0.088,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(thickness: 1.2, height: 1.2, color: Colors.grey[300]),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            selectedItemColor: Theme.of(context).primaryColor,
            selectedFontSize: SizeConfig.w * 0.036,
            unselectedFontSize: SizeConfig.w * 0.036,
            iconSize: 22,
            elevation: 0,
            selectedLabelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400),
            unselectedLabelStyle: TextStyle(
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.w400),
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedItemColor: Theme.of(context).accentColor,
            currentIndex: widget.index,
            onTap: (int i) async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              isLogin =
                  widget.isLogin ?? await pref.getBool("isLogin") ?? false;
              switch (i) {
                case 0:
                  Navigator.of(context).pushReplacementNamed('/Pages',
                      arguments: RouteArgument(id: "0", isLogin: true));
                  break;
                case 1:
                  !isLogin
                      ? Navigator.of(context).pushNamed('/Login')
                      : Navigator.of(context).pushNamed('/Pages',
                          arguments: RouteArgument(id: "1", isLogin: true));
                  break;
                case 2:
                  !isLogin
                      ? Navigator.of(context).pushNamed('/Login')
                      : Navigator.of(context).pushNamed('/Pages',
                          arguments: RouteArgument(id: "2", isLogin: true));
                  break;
                case 3:
                  !isLogin
                      ? Navigator.of(context).pushNamed('/Login')
                      : Navigator.of(context).pushNamed('/Pages',
                          arguments: RouteArgument(id: "3", isLogin: true));
                  break;
                // case 4:
                //   Navigator.of(context)
                //       .pushReplacementNamed('/Pages', arguments: 4);
                //   break;
              }
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
                        color: widget.index == 0 ? before : after,
                      ),
                    ),
                  ),
                  // title: SizedBox(),
                  icon: Image.asset("assets/icons/home.png",
                      color: widget.index == 0 ? before : after, height: 20)),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Sasta",
                          style: TextStyle(
                            fontSize: SizeConfig.w * 0.036,
                            color: widget.index == 1 ? before : after,
                          ),
                        ),
                        Icon(
                          Icons.add,
                          size: SizeConfig.w * 0.033,
                          color: widget.index == 1 ? before : after,
                        )
                      ],
                    ),
                  ),
                  icon: Image.asset("assets/icons/discount32.png",
                      color: widget.index == 1 ? before : after, height: 20)),
              // BottomNavigationBarItem(
              //     title: Column(
              //       children: <Widget>[
              //         FittedBox(
              //           fit: BoxFit.fitWidth,
              //           child: Text(
              //             "Specials",
              //             style: Theme.of(context).textTheme.headline6.copyWith(
              //                   fontSize: SizeConfig.w * 0.02,
              //                   color: widget.index== 2 ? before : after,
              //                 ),
              //           ),
              //         ),
              //         widget.index== 2
              //             ? Container(
              //                 height: 2,
              //                 width: SizeConfig.w * 0.2,
              //                 color: Theme.of(context).primaryColor)
              //             : SizedBox()
              //       ],
              //     ),
              //     icon: Image.asset("assets/icons/get-money32.png",
              //         color: widget.index== 2 ? before : after, height: 20)),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "My Group",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 2 ? before : after,
                      ),
                    ),
                  ),
                  icon: new Image.asset("assets/icons/team.png",
                      height: 20, color: widget.index == 2 ? before : after)),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "My Account",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 3 ? before : after,
                      ),
                    ),
                  ),
                  icon: Image.asset("assets/icons/user.png",
                      height: 20, color: widget.index == 3 ? before : after)),
            ],
          ),
        ],
      ),
    );
  }
}
