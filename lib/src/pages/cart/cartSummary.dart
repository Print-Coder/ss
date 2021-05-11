import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  CartData cartSummary;
  CartSummary({Key key, this.cartSummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Cart Summary",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.black, fontSize: 15),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Cart Value",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  Helper.getPrice(cartSummary.subTotal),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0, right: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text(
          //         "Total Savings",
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyText1
          //             .copyWith(color: Colors.black, fontSize: 14),
          //       ),
          //       Text(
          //         "- " + Helper.getPrice(cartSummary?.totalSaving ?? 0.0),
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyText1
          //             .copyWith(color: Colors.red, fontSize: 14),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Delivery Fee",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  Helper.getPrice(cartSummary?.totalShippingPrice ?? 0),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          cartSummary.iswallet & ((cartSummary?.walletAmount ?? 0) > 0)
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Cashback Discount",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            // color: Theme.of(context).primaryColor,
                            fontSize: 14),
                      ),
                      Text(
                        "-" + Helper.getPrice(cartSummary?.walletAmount ?? 0),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.red, fontSize: 15),
                      ),
                    ],
                  ),
                )
              : Container(),
          cartSummary.isCouponApplied
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Coupon Discount",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            // color: Theme.of(context).primaryColor,
                            fontSize: 14),
                      ),
                      Text(
                        "-" + Helper.getPrice(cartSummary?.discount ?? 0),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  ),
                )
              : Container(),

          Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total to Pay",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
                Text(
                  Helper.getPrice(cartSummary?.totalPrice ?? 0),
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).dividerColor,
          ),
          // SizedBox(height: 20,),
        ],
      ),
    );
  }
}
