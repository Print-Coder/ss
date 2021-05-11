import 'package:ECom/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'details.dart';
import 'earningData.dart';
import 'earningData.dart';

class SummaryTAb extends StatelessWidget {
  UsedData usedData;
  int balance;
  SummaryTAb({Key key, this.usedData, this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizedBox sizeText(Text text) {
      return SizedBox(
        // width: SizeConfig.w * 0.25,
        child: FittedBox(
          fit: BoxFit.cover,
          child: text,
        ),
      );
    }

    SizeConfig().init(context);
    if (usedData == null)
      return Center(
        child: Text("No cashback earned yet!"),
      );
    else
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 2),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: SizeConfig.w * 0.3,
                  height: SizeConfig.h * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      sizeText(
                        Text(
                          "Total Earned",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.black, fontSize: 17),
                        ),
                      ),
                      sizeText(
                        Text(
                          "Total Used",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              // .bodyText2
                              .copyWith(color: Colors.black, fontSize: 17),
                        ),
                      ),
                      sizeText(
                        Text(
                          "Balance",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              // .bodyText2
                              .copyWith(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: SizeConfig.h * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Helper.getOrderPrice(
                            (usedData.totalEarned ?? 0)),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        Helper.getOrderPrice((usedData.totalUsed ?? 0)),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        Helper.getOrderPrice((usedData.balance ?? 0)),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 45,
            )
          ],
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 12.0),
        //   child: Row(
        //     children: <Widget>[
        //       Text("Total Earned",
        //           style: Theme.of(context)
        //               .textTheme
        //               .headline3
        //               .copyWith(color: Theme.of(context).primaryColor)),
        //       Text(
        //         "  ₹ ${balance}",
        //         style: Theme.of(context)
        //             .textTheme
        //             .headline4
        //             .copyWith(color: Colors.black),
        //       )
        //     ],
        //   ),
        // ),
        //   ],
        // ),
      );
  }
}
