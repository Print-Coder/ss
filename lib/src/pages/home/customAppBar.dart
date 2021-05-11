import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/pages/widget/widgets.dart';

PreferredSize customAppBar(BuildContext context) {
  SizeConfig().init(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey[300]),
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset(
        'assets/icons/SHOPSASTA_200X45.png',
        width: SizeConfig.w * 0.29,
      ),
      //  Text("shopsasta",
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline5
      //         .copyWith(
      //                         fontWeight: FontWeight.w800,

      //           fontFamily: "QuickSand",
      //           fontSize: 20,
      //         )
      //         .merge(
      //           TextStyle(
      //               letterSpacing: 1.3, color: Theme.of(context).primaryColor),
      //         )),

      actions: <Widget>[
        SizedBox(width: 20),
        GestureDetector(
            onTap: () {
              // showSearch(context: context, delegate: ProductSearch());
              Navigator.of(context).pushNamed('/Search');
            },
            child: searchIcon(context)),
        new ShoppingCartButtonWidget(
            iconColor: Theme.of(context).primaryColorLight,
            labelColor: Theme.of(context).primaryColor),
      ],
    ),
  );
}
