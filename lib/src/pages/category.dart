import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/route_argument.dart';

class CategoryWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CategoryWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // TODO add layout in configuration file
  String layout = 'grid';
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        // leading: new IconButton(
        //   icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
        //   onPressed: () => scaffoldKey?.currentState?.openDrawer(),
        // ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "category",
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 0)),
        ),
        actions: <Widget>[
          1 < 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.5, vertical: 15),
                  child: SizedBox(
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  ),
                )
              : ShoppingCartButtonWidget(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).primaryColorDark),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(Duration(milliseconds: 1500)),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Text(
                  "Welcome To Category",
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
