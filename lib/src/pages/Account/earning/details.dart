import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'earningData.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:intl/intl.dart';

Widget details(BuildContext context, EarningData earningData) {
  return Container(
    color: Colors.grey[300],
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(earningData?.cashback_type ?? " "),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 15),
            // leading: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     Text("${earningData.cashbackPercent}%",
            //         style: Theme.of(context).textTheme.headline6),
            //   ],
            // ),
            title: Text("${earningData.description}",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black)),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      (!(earningData?.type == "Debit") ? "+ " : "- ") +
                          Helper.getPrice(earningData.cashbackAmount),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: !(earningData?.type == "Debit")
                              ? Theme.of(context).primaryColor
                              : Colors.red)),
                  Text(
                      earningData?.createdon != null
                          ? DateFormat('EEE MMM d yyyy')
                              .format(earningData?.createdon)
                              .toString()
                          : " ",
                      style: Theme.of(context).textTheme.headline6)
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
