import 'package:flutter/material.dart';

class FittedText extends StatelessWidget {
   FittedText({Key key,this.text}) : super(key: key);
  Text text;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: text,
    );
  }
}
