import 'package:flutter/material.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';

class RadioCart extends StatelessWidget {
  int payment_id, valueint;
  String radioText;
  Function radioClick;
  Function textClick;
  RadioCart({
    Key key,
    this.payment_id,
    this.valueint,
    this.radioText,
    this.radioClick,
    this.textClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: valueint,
          groupValue: payment_id,
          onChanged: radioClick,
        ),
        GestureDetector(
          onTap: textClick,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              radioText,
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
