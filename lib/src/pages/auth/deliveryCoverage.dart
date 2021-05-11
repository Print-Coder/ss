import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:ECom/src/models/route_argument.dart';

class DeliveryCoverage extends StatelessWidget {
  bool isAddress;
  String pincode;
  String area;
  DeliveryCoverage({Key key, this.pincode, this.area, this.isAddress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<UserData>(builder: (_, userData, ch) {
      var userObject = userData?.currentUser ?? null;
      var userzip;

      if (userObject != null)
        userzip = userData
            ?.currentUser?.addresses[userData?.currentUser?.addressIndex];

      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithPop(context, "Delivery Coverage",
              needSearch: false, needCart: false, ispop: true),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: SizeConfig.h * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.h * 0.1,
                      ),
                      Image.asset("assets/icons/delivery-man.png",
                          height: SizeConfig.h * 0.2),
                      //  Icon(Icons.add_shopping_cart, size: 100),
                      SizedBox(
                        height: SizeConfig.h * 0.05,
                      ),
                      Container(
                          // margin: EdgeInsets.only(top: 25, bottom: 25),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // padding: EdgeInsets.all(5),
                          width: SizeConfig.w * 0.55,
                          height: SizeConfig.w * 0.12,
                          child: Center(
                            child: Text(
                              pincode ??
                                  (userObject != null
                                      ? userzip.zip
                                      : userzip.pincode),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    color: Colors.black,
                                    //  fontWeight: FontWeight.w300,
                                    // fontSize: SizeConfig.w * 0.025
                                  ),
                            ),
                          )),
                      SizedBox(
                        height: SizeConfig.h * 0.05,
                      ),
                      Center(
                        child: SizedBox(
                          width: SizeConfig.w * 0.8,
                          child: Text(
                              "We are not delivering in this PIN code yet. We  will notify when we start serving in your area",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.h * 0.05,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Your Area -",
                                  style: Theme.of(context).textTheme.headline5),
                              TextSpan(
                                text: area ??
                                    (userObject != null
                                        ? userzip.area
                                        : userzip.area),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.h * 0.05,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () => isAddress ?? false
                              ? Navigator.of(context).pushReplacementNamed(
                                  '/Pages',
                                  arguments:
                                      RouteArgument(id: "0", isLogin: true))
                              : Navigator.of(context).pop(),
                          // Navigator.of(context).pushNamed("/MyAccount"),
                          child: Container(
                              padding: EdgeInsets.all(10),
                              color: Theme.of(context).primaryColor,
                              width: SizeConfig.w * 0.6,
                              child: Center(
                                child: Text(
                                  "Explore",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
