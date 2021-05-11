import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/appBarWithPop.dart';
import 'details.dart';
import 'earningData.dart';
import 'earningData.dart';

class Earned extends StatelessWidget {
  List<EarningData> earningData = [];
  int balance;
  Earned({Key key, this.earningData, this.balance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (earningData == null || earningData?.length == 0)
      return Center(
        child: Text("No cashback earned yet!"),
      );
    else
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 2),
        // color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              // width: 1,
              height: 1,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey[300],
                    width: 1,
                    height: 0,
                  );
                },
                itemCount: earningData.length,
                itemBuilder: (context, earnIndex) =>
                    details(context, earningData[earnIndex]),
              ),
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
