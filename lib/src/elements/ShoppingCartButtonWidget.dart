import 'package:ECom/src/models/userData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/route_argument.dart';
// import '../repository/user_repository.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/pages/home.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  _ShoppingCartButtonWidgetState createState() =>
      _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState extends State<ShoppingCartButtonWidget> {
  bool isLogin;
  @override
  void initState() {
    // _con.listenForCartsCount();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogin = prefs.getBool("isLogin") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, userdata, ch) {
      return Consumer<CartData>(builder: (context, cartData, ch) {
        return FlatButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            isLogin = prefs.getBool("isLogin") ?? false;

            userdata?.currentUser?.name == null && !isLogin
                ? Navigator.of(context).pushNamed('/Login')
                : Navigator.of(context).pushNamed('/Cart');
          },
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Image.asset("assets/icons/shopping-bag.png",
                  width: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.black),
              Container(
                child: AutoSizeText(
                  ((cartData?.currentCart?.products?.length ?? 0) > 9
                      ? "9+"
                      : (cartData?.currentCart?.products?.length ?? 0)
                          .toString()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10, color: Theme.of(context).primaryColorLight),
                ),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: this.widget.labelColor, shape: BoxShape.circle,
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                // constraints: BoxConstraints(
                //     minWidth: 16, maxWidth: 19, minHeight: 16, maxHeight: 18),
              ),
            ],
          ),
        );
      });
    });
  }
}
