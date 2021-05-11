import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:flutter/material.dart';

class AddAddressButton extends StatelessWidget {
  @required
  bool showIcon;
  AddAddressButton({Key key, this.showIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      focusColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColorLight,
      onTap: () => showIcon
          ? Navigator.of(context).pushNamed("/AddNewAddress")
          : Navigator.of(context).pushNamed("/AllAddress"),
      child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor,
            border: Border.all(
              width: 1,
              color: Theme.of(context).accentColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: showIcon ? EdgeInsets.all(5) : EdgeInsets.only(bottom: 3),
          width: showIcon ? SizeConfig.w * 0.9 : 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showIcon
                  ? Icon(Icons.add_circle_outline,
                      size: 28, color: Theme.of(context).accentColor)
                  : Container(),
              SizedBox(width: showIcon ? 5 : 0),
              Text(showIcon ? "Add New Address" : "Change",
                  style: showIcon
                      ? Theme.of(context).textTheme.headline5
                      : TextStyle()
                  // .copyWith(color: Colors.white),
                  )
            ],
          )),
    );
  }
}
