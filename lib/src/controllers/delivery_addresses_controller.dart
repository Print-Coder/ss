import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/cart.dart';
import '../repository/settings_repository.dart' as settingRepo;

class DeliveryAddressesController extends ControllerMVC with ChangeNotifier {
  // List<model.Address> addresses = <model.Address>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Cart cart;

  DeliveryAddressesController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForAddresses();
    listenForCart();
  }

  void listenForAddresses({String message}) async {
 
  }

  void listenForCart() async {
    
  }

 
}
