import 'dart:ui';

import 'package:ECom/src/helpers/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  List<String> slides = [];

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 500));
    // return HomeSliderLoaderWidget();
    return Stack(
      // alignment: ,
      fit: StackFit.passthrough,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            height: 100,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
                // _alignmentDirectional = Helper.getAlignmentDirectional(
                //     widget.slides.elementAt(index).textPosition);
              });
            },
          ),
          items: widget?.slides == null || (widget?.slides?.isEmpty ?? false)
              ? [
                  Image.asset(
                    'assets/img/banner.jpg',
                    fit: BoxFit.fitWidth,
                  )
                ]
              : widget.slides.map((String slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CachedNetworkImage(
                        imageUrl: slide,
                        //  Image.asset(
                        //   'assets/img/banner.jpg',
                        // height: 140,
                        // width: double.infinity,
                        fit: BoxFit.fitWidth,
                        // Helper.getBoxFit(slide.imageFit),
                        // imageUrl: "https://image.freepik.com/free-vector/online-market-web-banner-hand-holding-smart-phone-ordering-products-grocery-shopping-food-delivery-concept_48369-18136.jpg",
                        placeholder: (context, url) => Center(
                          child: Image.asset(
                            'assets/img/loading.gif',
                            height: 100,
                            fit: BoxFit.fitWidth,
                            // width: double.infinity,
                            // height: 140,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Image.asset(
                            'assets/img/banner.jpg',
                            height: 100,
                            fit: BoxFit.fitWidth,
                            // width: double.infinity,
                            // height: 140,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
        ),
      ],
    );
  }
}
