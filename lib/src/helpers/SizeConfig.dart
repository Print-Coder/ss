import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static double h, w;


  void init(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }
}
