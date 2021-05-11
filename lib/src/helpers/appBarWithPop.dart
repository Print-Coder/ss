import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSize AppBarWithPop(BuildContext context, String titleText,
    {bool needSearch = true,
    bool needCart = true,
    bool ispop = true,
    double width,
    bool fcm = false}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      elevation: 0, backgroundColor: Colors.white,
      automaticallyImplyLeading: false,

      // Don't show the leading button
      titleSpacing: 0,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Theme.of(context).primaryColor,
              onPressed: () => fcm??false
                  ? SystemChannels.platform.invokeMethod('SystemNavigator.pop')
                  : ispop
                      ? Navigator.of(context).pop()
                      : Navigator.of(context)
                          .pushReplacementNamed('/Pages', arguments: 0),
            ),
            width != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * (width ?? 0.3),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        titleText,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontFamily: "QuickSand",
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  )
                : Text(
                    titleText,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontFamily: "QuickSand",
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
          ]),
      actions: <Widget>[
        needSearch
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Search');
                },
                child: Image.asset("assets/icons/search.png",
                    width: MediaQuery.of(context).size.width * 0.054,
                    color: Colors.black))
            : SizedBox(width: 20),
        needCart
            ? new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).primaryColorLight,
                labelColor: Theme.of(context).primaryColor)
            : SizedBox(width: 20),
      ],
    ),
  );
}
