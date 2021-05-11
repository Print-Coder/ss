import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/pages/home.dart';

class CartNoItem extends StatelessWidget {
  CartNoItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //refresh
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: SizeConfig.h * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text("Buy Together, Save Together",
                      style: Theme.of(context).textTheme.headline6)),
              SizedBox(
                height: SizeConfig.h * 0.018,
              ),
              Center(
                  child: Text("Group Buying, More Savings",
                      style: Theme.of(context).textTheme.headline6)),
              SizedBox(
                height: SizeConfig.h * 0.1,
              ),
              Image.asset("assets/icons/shopping-cart.png",
                  color: Theme.of(context).primaryColor,
                  height: SizeConfig.h * 0.2),
              //  Icon(Icons.add_shopping_cart, size: 100),
              SizedBox(
                height: SizeConfig.h * 0.1,
              ),
              Center(
                  child: Text("Your Cart is Empty",
                      style: Theme.of(context).textTheme.headline5)),
              SizedBox(
                height: SizeConfig.h * 0.02,
              ),
              Center(
                  child: Text("When you add products, they'll appear",
                      style: Theme.of(context).textTheme.headline6)),
              SizedBox(
                height: SizeConfig.h * 0.08,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      width: SizeConfig.w * 0.6,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Continue Shopping",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
