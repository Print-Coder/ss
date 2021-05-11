import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget searchIcon(BuildContext context) {
  SizeConfig().init(context);
  return Image.asset("assets/icons/search.png",
      width: SizeConfig.w * 0.054, color: Colors.black);
}

Widget setDefaultText(BuildContext context, {String text}) {
  SizeConfig().init(context);
  return SizedBox(
    width: SizeConfig.w * 0.8,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: text ??
          Text(
            "Set this as my default delivery address",
            style: Theme.of(context)
                .textTheme
                .headline5
                // .copyWith(fontSize: 12)
                .copyWith(fontSize: 16),
          ),
    ),
  );
}

Widget setAText(BuildContext context, {Text text, double width}) {
  SizeConfig().init(context);
  return SizedBox(
    width: SizeConfig.w * (width ?? 0.8),
    child: FittedBox(
      fit: BoxFit.fitWidth,
      child: text ??
          Text(
            "Set this as my default delivery address",
            style: Theme.of(context)
                .textTheme
                .headline5
                // .copyWith(fontSize: 12)
                .copyWith(fontSize: 16),
          ),
    ),
  );
}

Widget shareEarn(BuildContext context, String text) {
  SizeConfig().init(context);
  return Container(
      margin: EdgeInsets.only(
          // top: 25,
          ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(5),
      width: SizeConfig.w * 0.40,
      child: Row(
        children: <Widget>[
          Image.asset('assets/icons/share.png',
              height: 20, color: Theme.of(context).primaryColorLight),
          SizedBox(width: 5),
          SizedBox(
            width: SizeConfig.w * 0.30,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text ?? "SHARE & EARN",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ));
}
