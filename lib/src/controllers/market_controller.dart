import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MarketController extends ControllerMVC {
  // Market market;
  String market;
  // List<Gallery> galleries = <Gallery>[];
  // List<Product> products = <Product>[];
  // List<Category> categories = <Category>[];
  // List<Product> trendingProducts = <Product>[];
  // List<Product> featuredProducts = <Product>[];
  // List<Review> reviews = <Review>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  MarketController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
}
