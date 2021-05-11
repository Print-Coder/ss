import 'dart:convert';
import 'package:ECom/src/helpers/autoText.dart';
import 'package:ECom/src/models/dynamicLink.dart';
import 'package:ECom/src/pages/widget/widgets.dart';
import 'package:ECom/src/pages/home.dart';
import 'package:ECom/src/api/apiServices.dart';
import 'package:ECom/src/helpers/helper.dart';
import 'package:ECom/src/pages/cart/api/CartData.dart';
import 'package:ECom/src/pages/widget/pincodeFab.dart';
import 'package:ECom/src/pages/widget/bottomSheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'package:ECom/src/elements/CardsCarouselWidget.dart';
import 'package:ECom/src/elements/CircularLoadingWidget.dart';
import 'package:ECom/src/elements/ShoppingCartButtonWidget.dart';
import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/helpers/bottomNavBar.dart';
import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/models/cart.dart';
import 'package:ECom/src/models/productListApi.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:ECom/src/models/userData.dart';
import 'package:ECom/src/pages/home/customAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/elements/BotttomCardsCarouselWidget.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'api/productDetailData.dart';
import 'loadProductDetail.dart';
import 'package:ECom/src/pages/widget/PinCodeFabGrey.dart';
import 'package:ECom/src/pages/widget/pincodeFab.dart';

// import '../repository/user_repository.dart';
//Cauliflower is avilable at cheapest Price.You can Share and Earn Cashback.Here is the link for the product
// ignore: must_be_immutable https://shopsasta.page.link/7aXSbi5cS3vDdZ7X9
class ProductWidget extends StatefulWidget {
  bool fromDeep = false;
  Item itemData;
  String linker;
  RouteArgument routeArgument;
  String product;
  ProductWidget(
      {Key key,
      this.linker,
      this.itemData,
      this.product,
      this.fromDeep = false,
      this.routeArgument})
      : super(key: key);

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends State<ProductWidget> {
  int quantity = 0;
  // ProductController _con;
  // int variantIndex = 0;
  // _ProductWidgetState() : super(ProductController()) {
  //   _con = controller;
  // }
  ProductDetailData proData;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String endPoint;

  int value = 00;
  int selectedQuantity, variantIndex;
  @override
  void initState() {
    // _con.listenForProduct(productId: widget.routeArgument.id);
    // _con.listenForCart();
    // _con.listenForFavorite(productId: widget.routeArgument.id);
    endPoint = "detail/" + (widget?.itemData?.linker ?? widget?.linker);
    print(endPoint ?? " productdetail");
    getProductData(endPoint, refresh: false);
  }

  showLoading() => setState(() {
        _isLoading = true;
      });
  stopLoading() {
    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  bool isLogin, stockStatus;
  bool _isLoading = false;
  getProductData(String endPoint, {bool refresh}) async {
    refresh ? print("refreshing") : showLoading();
    // await Future.delayed(Duration(milliseconds: 1000));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLogin = prefs.getBool("isLogin") ?? false;
    Map res = isLogin
        ? await ApiServices.getRequestPincode(endPoint + producDataEndPoint)
        : await ApiServices.getRequest(endPoint + producDataEndPoint);
    if (res != null) {
      // print("res is not null ${res["status"] ?? "k"}");

      print("status is true");
      widget.itemData = Item.fromMap(res);
      itemData = widget.itemData;
// widget.product
      secondDrop = ((itemData?.variant[itemData?.variantIndex]
                      ?.prices[itemData?.quantIndex]?.quantity) ??
                  1)
              .toString() +
          " @ " +
          (Helper.getDropDown(itemData?.variant[itemData?.variantIndex]
                      ?.prices[itemData?.quantIndex]?.price) ??
                  1)
              .toString();
      print(secondDrop);
      // Provider.of<ProductListData>(context, listen: false)
      //     .setItemData(widget.itemData);
      stopLoading();
    } //status is true
    else {
      stopLoading();
    } //status is not true
  }

  Item itemData;
  final CarouselController _controller = CarouselController();

  String secondDrop, firstDrop;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: () {
          print("prosuct");
          if (widget.product != null || widget.linker != null)
            Navigator.pop(context);
          else
            Navigator.pushReplacementNamed(context, "/Pages", arguments: 0);
          return Future.value(true);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavBar(
              index: 0,
              isLogin: isLogin,
            ),
            key: scaffoldKey,
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(SizeConfig.h * 0.31),
            //   child: AppBar(
            //     automaticallyImplyLeading: false,
            //     titleSpacing: 0,
            //     title: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: <Widget>[
            //           IconButton(
            //             icon: Icon(Icons.arrow_back),
            //             color: Theme.of(context).primaryColor,
            //             onPressed: () => Navigator.of(context).pop(),
            //           ),
            //           FittedBox(
            //             fit: BoxFit.fitWidth,
            //             child: Text(
            //               "Product Details",
            //               style: Theme.of(context).textTheme.headline5.copyWith(
            //                     fontFamily: "Georgia",
            //                     color: Theme.of(context).primaryColor,
            //                   ),
            //             ),
            //           ),
            //         ]),
            //     flexibleSpace: Container(
            //       height: SizeConfig.h * 0.31,
            //       margin: EdgeInsets.only(top: SizeConfig.h * 0.094),
            //       child: Center(
            //         child: Hero(
            //           tag: widget.routeArgument.heroTag,
            //           child: CachedNetworkImage(
            //             height: SizeConfig.h * 0.31,
            //             fit: BoxFit.contain,
            //             imageUrl: widget.routeArgument.imageUrl,
            //             placeholder: (context, url) => Image.asset(
            //               'assets/img/loading.gif',
            //               fit: BoxFit.cover,
            //             ),
            //             errorWidget: (context, url, error) => Icon(Icons.image),
            //           ),
            //         ),
            //       ),
            //     ),
            //     backgroundColor: Theme.of(context).primaryColorLight,
            //     elevation: 0,
            //     actions: <Widget>[
            //       SizedBox(width: 20),
            //       GestureDetector(
            //           onTap: () {
            //             Navigator.of(context).pushNamed('/Search');
            //           },
            //           child: Image.asset("assets/icons/search.png",
            //               width: 23, color: Colors.black)),
            //       new ShoppingCartButtonWidget(
            //           iconColor: Theme.of(context).primaryColorLight,
            //           labelColor: Theme.of(context).primaryColor),
            //     ],
            //   ),
            // ),
            body: RefreshIndicator(
              onRefresh: () => getProductData(endPoint, refresh: true),
              child: _isLoading
                  ? LoadProductDetails()
                  : CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          floating: false,
                          automaticallyImplyLeading: false,
                          titleSpacing: 0,
                          title: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: widget.product != null ||
                                              widget.linker != null
                                          ? () => Navigator.of(context).pop()
                                          : () =>
                                              Navigator.pushReplacementNamed(
                                                  context, "/Pages",
                                                  arguments: 0),
                                    ),
                                    SizedBox(
                                      // width: SizeConfig.w * 0.45,
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "Product Details",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.045,
                                                fontWeight: FontWeight.w800,
                                                fontFamily: "QuickSand",
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          expandedHeight: SizeConfig.h * 0.31,
                          pinned: true,
                          flexibleSpace: Container(
                            // height: SizeConfig.h * 0.31,
                            margin: EdgeInsets.only(top: SizeConfig.h * 0.13),
                            child: Center(
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: widget?.routeArgument?.heroTag ??
                                        widget.linker,
                                    child: Center(
                                      child: CarouselSlider(
                                        carouselController: _controller,
                                        options: CarouselOptions(
                                          enableInfiniteScroll: false,
                                          autoPlay: false,
                                          // autoPlayInterval: Duration(seconds: 5),
                                          // height: 100,
                                          viewportFraction: 1,
                                        ),
                                        items: widget.itemData.pictures
                                            .map((String slide) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return CachedNetworkImage(
                                                // height: SizeConfig.h * 0.31,
                                                fit: BoxFit.fitHeight,
                                                imageUrl:
                                                    awsLink + slide + ".jpg",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  'assets/img/loading.gif',
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.image),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  widget.itemData.pictures.length > 1
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: IconButton(
                                              icon: Icon(Icons.arrow_back_ios),
                                              onPressed: () {
                                                print("back");
                                                _controller.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  // curve: Curves.easeIn
                                                );
                                              }))
                                      : Container(),
                                  widget.itemData.pictures.length > 1
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              icon:
                                                  Icon(Icons.arrow_forward_ios),
                                              onPressed: () =>
                                                  _controller.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    // curve: Curves.easeIn
                                                  )),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColorLight,
                          elevation: 0,
                          actions: <Widget>[
                            SizedBox(width: 20),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Search');
                                },
                                child: Image.asset("assets/icons/search.png",
                                    width: 23, color: Colors.black)),
                            new ShoppingCartButtonWidget(
                                iconColor: Theme.of(context).primaryColorLight,
                                labelColor: Theme.of(context).primaryColor),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Wrap(
                              runSpacing: 8,
                              children: [
                                Divider(
                                  height: 1,
                                  thickness: 1,
                                ),
                                Center(
                                  child: Text(
                                    widget.itemData.name ?? "Name",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.black),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: SizeConfig.w * 0.33,
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2, right: 5),
                                      margin:
                                          EdgeInsets.only(left: 8.0, top: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color:
                                                  Theme.of(context).accentColor,
                                              width: 1)),
                                      child: new DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        iconSize: 20,
                                        icon: Container(
                                            // width:15,
                                            child: Center(
                                                child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.grey,
                                                    size: 30))),
                                        key: Key(widget.product),
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).accentColor),
                                        value: itemData
                                                ?.variant[
                                                    itemData?.variantIndex]
                                                ?.title ??
                                            "1 KG",
                                        items: itemData.variant
                                            .map((e) => e.title)
                                            .toList()
                                            .map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: new Text(value)),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          print(v);
                                          setState(() {
                                            itemData.quantity = 0;
                                            itemData.variantIndex = itemData
                                                .variant
                                                .map((e) => e.title)
                                                .toList()
                                                .indexOf(v);
                                            Provider.of<ProductListData>(
                                                    context,
                                                    listen: false)
                                                .setvariant(itemData);

                                            secondDrop = (itemData
                                                        ?.variant[itemData
                                                            .variantIndex]
                                                        ?.prices[0]
                                                        ?.quantity)
                                                    .toString() +
                                                " @ " +
                                                (Helper.getDropDown(itemData
                                                        ?.variant[itemData
                                                            .variantIndex]
                                                        .prices[0]
                                                        .price))
                                                    .toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: SizeConfig.w * 0.47,
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2, right: 5),
                                      margin:
                                          EdgeInsets.only(left: 8.0, top: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color:
                                                  Theme.of(context).accentColor,
                                              width: 1)),
                                      child: new DropdownButton<String>(
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        iconSize: 20,
                                        icon: Container(
                                          // width:15,
                                          child: Center(
                                            child: Icon(Icons.arrow_drop_down,
                                                color: Colors.grey, size: 30),
                                          ),
                                        ),
                                        key: Key(widget.product),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).accentColor),
                                        value: secondDrop,
                                        items: itemData
                                            .variant[itemData.variantIndex]
                                            .prices
                                            .map((value) {
                                          return new DropdownMenuItem<String>(
                                            value: (value.quantity).toString() +
                                                " @ " +
                                                (Helper.getDropDown(
                                                    value.price)),
                                            child:

                                                //  Container()
                                                SizedBox(
                                                    // width: SizeConfig.w * 0.33,
                                                    child: new FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                (value.quantity).toString() +
                                                    " @ " +
                                                    Helper.getDropDown(
                                                        value.price),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            )),
                                          );
                                        }).toList(),
                                        onChanged: (v) {
                                          // print(v.split("@")[1]);
                                          setState(() {
                                            itemData.quantity = 0;
                                            secondDrop = v;
                                            print(itemData
                                                .variant[itemData.variantIndex]
                                                .prices[0]
                                                .price);
                                            // print(double.parse(
                                            //     v.split("@ ₹")[1].trim()));
                                            itemData.quantIndex = itemData
                                                .variant[itemData.variantIndex]
                                                .prices
                                                .indexWhere((price) =>
                                                    price.price ==
                                                    double.parse(v
                                                        .split(" ")[2]
                                                        .trim()
                                                        .split("₹")[1]));
                                          });
                                          Provider.of<ProductListData>(context,
                                                  listen: false)
                                              .setQuantIndex(itemData);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2.0, top: 8),
                                    width: SizeConfig.w * 0.82,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "MRP: " +
                                                Helper.getPrice(itemData
                                                    .variant[
                                                        itemData.variantIndex]
                                                    .mrp),
                                            // overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            "Save: " +
                                                Helper.getPrice((itemData
                                                            .variant[itemData
                                                                .variantIndex]
                                                            .mrp -
                                                        itemData
                                                            .variant[itemData
                                                                .variantIndex]
                                                            .prices[itemData
                                                                .quantIndex]
                                                            .price)
                                                    .abs()),
                                            // overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            "You Pay: " +
                                                Helper.getPrice(itemData
                                                    .variant[
                                                        itemData.variantIndex]
                                                    .prices[itemData.quantIndex]
                                                    .price),
                                            // overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                // SizedBox(
                                //   height: 50,
                                // ),
                                Consumer<UserData>(
                                    builder: (context, userData, ch) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Center(
                                        child: InkWell(
                                            splashColor:
                                                Theme.of(context).primaryColor,
                                            focusColor:
                                                Theme.of(context).primaryColor,
                                            highlightColor: Theme.of(context)
                                                .primaryColorLight,
                                            onTap: () async {
                                              String link =
                                                  await DynamicLinkService()
                                                      .createProductLink(
                                                          itemData.linker);

                                              userData?.referalCode != null
                                                  ? Share.share(
                                                      "${itemData.name} is available at best price ₹${itemData.variant[itemData.variantIndex].prices[itemData.quantIndex].price}. Find best deals on Grocery everyday on ShopSasta. Get cashbacks and Save. Share with friends and family and earn. FREE Home Delivery. Install App and use my referral code ${userData.referalCode ?? " "} while signing up $link")
                                                  : Share.share(
                                                      "${itemData.name} is available at best price ₹${itemData.variant[itemData.variantIndex].prices[itemData.quantIndex].price}. Find best deals on Grocery everyday on ShopSasta. Get cashbacks and Save. Share with friends and family and earn. FREE Home Delivery. $link");

                                              // '${itemData.name} is avilable at cheapest Price.You can Share and Earn Cashback.Here is the link for the product ');
                                            },
                                            //Cauliflower is avilable at cheapest Price.You can Share and Earn Cashback.Here is the link for the product https://shopsasta.page.link/JMVz2Fbuq64dWe4j7
                                            child: shareEarn(
                                                context, "SHARE & EARN")),
                                      ),
                                      Consumer<ProductListData>(builder:
                                          (context, productListData, ch) {
                                        return !productListData.stockStatus ??
                                                false
                                            ? Container(
                                                width: SizeConfig.w * 0.35)
                                            : Center(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    bool _additem = false;
                                                    // showLoading();

                                                    ProductBottomSheet(
                                                        itemData, context);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      width: SizeConfig.w * 0.4,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.add,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight),
                                                          SizedBox(width: 7),
                                                          SizedBox(
                                                            width:
                                                                SizeConfig.w *
                                                                    0.25,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                              child: Text(
                                                                "ADD TO CART",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              );
                                      })
                                    ],
                                  );
                                }),

                                itemData?.offerdesc != null &&
                                        itemData?.offerdesc != ""
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, top: 8),
                                            width: SizeConfig.w * 0.82,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "Offers",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 0.0, top: 8),
                                                  child: textST3(
                                                    itemData?.offerdesc
                                                        ?.replaceAll(
                                                            RegExp('#'), ''),
                                                    // "Good projskdfjdgh dhgff sdfgh fdgh sd hgd dgh fg lk;sdfj sadkjf sdkfj asdlkf;j jklsdf sdkfj sdfjk kjkl ;lkj duct with best available price",
                                                    maxLines: 3,
                                                    fontWeight: FontWeight.w400,
                                                    textstyle: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        height: 1.1),
                                                  ),
                                                ),
                                              ],
                                            )))
                                    : Container(),
                                itemData?.simpledesc != null &&
                                        itemData?.simpledesc != ""
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, top: 8),
                                            width: SizeConfig.w * 0.82,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "About this item",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.0, top: 8),
                                                    child: textST3(
                                                      itemData?.simpledesc
                                                          ?.replaceAll(
                                                              RegExp('#'), ''),
                                                      // "Good projskdfjdgh dhgff sdfgh fdgh sd hgd dgh fg lk;sdfj sadkjf sdkfj asdlkf;j jklsdf sdkfj sdfjk kjkl ;lkj duct with best available price",
                                                      maxLines: 3,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textstyle: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          height: 1.1),
                                                    ))
                                              ],
                                            )))
                                    : SizedBox(),

                                itemData?.brand_desc != null &&
                                        itemData?.brand_desc != ""
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 0.0, top: 8),
                                            width: SizeConfig.w * 0.82,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "About this brand",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.0, top: 8),
                                                    child: textST3(
                                                      itemData?.brand_desc
                                                          ?.replaceAll(
                                                              RegExp('#'), ''),
                                                      // "Good projskdfjdgh dhgff sdfgh fdgh sd hgd dgh fg lk;sdfj sadkjf sdkfj asdlkf;j jklsdf sdkfj sdfjk kjkl ;lkj duct with best available price",
                                                      maxLines: 3,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textstyle: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          height: 1.1),
                                                    ))
                                              ],
                                            )))
                                    : SizedBox(),

                                Divider(height: 5),
                                // Text(Helper.skipHtml(itemData)),
                                // widget.product != null
                                //     ?
                                widget.fromDeep
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0,
                                            left: 20,
                                            right: 20,
                                            bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    "Do You Also Want ...?",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // if (settingsRepo.deliveryAddress.value?.address != null)
                                            //   Padding(
                                            //     padding: const EdgeInsets.only(top: 12),
                                            //     child: Text(
                                            //       near_to + " " + (settingsRepo.deliveryAddress.value?.address),
                                            //       style: Theme.of(context).textTheme.caption,
                                            //     ),
                                            //   ),
                                          ],
                                        ),
                                      ),
                                // : Container(),
                                // widget.product != null
                                //     ?
                                widget.fromDeep
                                    ? Container()
                                    : BottomCardsCarouselWidget(
                                        EComList: catList,
                                        heroTag: 'home_top_ECom2')
                                // : Container(),
                                // ReviewsListWidget(
                                //   reviewsList: _con.product.productReviews,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: 50),
                          ],
                        ))
                      ],
                    ),
            ),
            floatingActionButton: PinCodeFab()));
  }
}
