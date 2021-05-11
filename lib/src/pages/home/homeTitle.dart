import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/autoText.dart';

class HomeTitle extends StatelessWidget {
  String title;
  Function viewAllPressed;
  HomeTitle({Key key, this.viewAllPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: textH6(title,
                    textstyle: TextStyle(
                      fontFamily: 'Quicksand',
                    ),
                    fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: viewAllPressed,
                child: textST2(
                  "View All",
                  textstyle: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Theme.of(context).accentColor,
                  ),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
