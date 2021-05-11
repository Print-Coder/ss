import 'package:ECom/src/helpers/SizeConfig.dart';
import 'package:ECom/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final CarouselController _controller = CarouselController();

  List<String> cashBackBullet = [
    "Community Buying - Cashback",
    "No- Rush Delivery - Cashback",
    "Referral - Cashback",
    "Special Event - Cashback"
  ];

  List<String> slideImage = [
    "assets/icons/intro1.png",
    "assets/icons/intro2.png",
    "assets/icons/intro3.png",
    "assets/icons/intro4.png",
    "assets/icons/intro5.png",
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TextStyle headlineStyle = Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.black, fontSize: SizeConfig.w * 0.04),
        subTitle = Theme.of(context).textTheme.headline5.copyWith(
            // color: Colors.black,

            fontSize: SizeConfig.w * 0.045),
        bodyStyle = Theme.of(context).textTheme.headline6.copyWith(
            // color: Colors.black,

            fontSize: SizeConfig.w * 0.04);
    Text cashBask = Text("Cashback", style: subTitle);
    Text howit = Text("How it Works?", style: subTitle);
    List<Column> introCol = [
      // new Slide(
      //   //1 slide
      //   widgetTitle:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Text("Buy Together. Save Together", style: headlineStyle)),
          SizedBox(
            height: SizeConfig.h * 0.014,
          ),
          Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child:
                  Text("Community Buying. More Savings", style: headlineStyle),
            ),
          ),
          // SizedBox(
          //   height: SizeConfig.h * 0.1,
          // ),
          Center(
            child: Image.asset(slideImage[0],
                // color:Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain),
          ),
          Center(
            child: Text("Our Mission", style: subTitle),
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Enable and Reward Community Group Buying!",
                  style: bodyStyle),
            ),
          ),
          SizedBox(
            height: SizeConfig.h * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("You shop, we give you cashback:",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black)),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: cashBackBullet.length,
            itemBuilder: (context, bulletIndex) => Padding(
              padding: EdgeInsets.only(left: SizeConfig.w * 0.13),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "\u2022 ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black)),
                    TextSpan(
                      text: cashBackBullet[bulletIndex],
                      style: bodyStyle,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),

      //   backgroundColor: Colors.white,
      // ),

      //--------------------------------------------------------

      // new Slide(
      //   //2 slide
      //   widgetTitle:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(cashBackBullet[0], style: headlineStyle),
          ),

          // SizedBox(
          //   height: SizeConfig.h * 0.1,
          // ),
          Center(
            child: Image.asset(slideImage[1],
                // color:Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: cashBask,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "You will get cashback on your orders when everyone in your community buys more",
                style: bodyStyle),
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: howit,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "You will get anywhere from 1% - 3% cashback on your orders based on the total order amount from your community in a given week from Mon - Sun.\n\nYou can track your cashbask details in your \"My Group\" page.",
                style: bodyStyle),
          ),
        ],
      ),
      //   centerWidget: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[

      //       ]),
      //   backgroundColor: Colors.white,
      // ),
      //--------------------------------------------------------
      // new Slide(
      //   //3 slide
      //   widgetTitle:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(cashBackBullet[1], style: headlineStyle),
          ),

          // SizedBox(
          //   height: SizeConfig.h * 0.1,
          // ),
          Center(
            child: Image.asset(slideImage[2],
                // color:Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: cashBask,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "You will get additional cashback when you select \"No-Rush Delivery\" during checkout",
                style: bodyStyle),
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: howit,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "All \"No-Rush Delivery\" orders will be delivered the following week. This allow us to group all deliveries in your community so we reward you with additional cashback.\n\nYou can track your cashbask details in your \"My Earnings\" page.",
                style: bodyStyle),
          ),
        ],
      ),
      //   centerWidget: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[

      //       ]),
      //   backgroundColor: Colors.white,
      // ),
      // new Slide(
      //   //4 slide
      //   widgetTitle:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(cashBackBullet[2], style: headlineStyle),
          ),

          // SizedBox(
          //   height: SizeConfig.h * 0.1,
          // ),
          Center(
            child: Image.asset(slideImage[3],
                // color:Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain),
          ),
          Padding(
              padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
              child: cashBask),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "You will get cashback when you refer friends & family to shopsasta.",
                style: bodyStyle),
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: howit,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "You will get cashback for each order placed by your referral.\n\nYou can track your cashbask details in your \"My Earnings\" page.",
                style: bodyStyle),
          ),
        ],
      ),

      //   backgroundColor: Colors.white,
      // ),
      // new Slide(
      //   //5 slide
      //   widgetTitle:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(cashBackBullet[3], style: headlineStyle),
          ),

          // SizedBox(
          //   height: SizeConfig.h * 0.1,
          // ),
          Center(
            child: Image.asset(slideImage[4],
                // color:Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * 0.25,
                // width: MediaQuery.of(context).size.width * 0.2,
                fit: BoxFit.contain),
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: cashBask,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text("You will earn extra cashback during special events.",
                style: bodyStyle),
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: howit,
          ),
          SizedBox(
            height: SizeConfig.h * 0.012,
          ),
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.w * 0.05),
            child: Text(
                "shopsasta will announce extra cshback details during special events.\n\nYou can track your cashbask details in your \"My Earnings\" page.",
                style: bodyStyle),
          ),
        ],
      ),
      // centerWidget: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[

      //     ]),
      //   backgroundColor: Colors.white,
      // ),
    ];
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    // carouselController: _controller,
                    enableInfiniteScroll: false,
                    height: MediaQuery.of(context).size.height * 0.98,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    onPageChanged: (i, r) {
                      setState(() {
                        _current = i;
                      });
                    },
                    aspectRatio: 0.95,
                    autoPlay: false,
                    pauseAutoPlayOnTouch: true,
                  ),
                  items: introCol.map<Widget>((c) {
                    return WillPopScope(
                      onWillPop: () {
                        // SystemChannels.platform
                        //     .invokeMethod('SystemNavigator.pop');
                        return Future.value(false);
                      },
                      child: Builder(builder: (BuildContext context) {
                        return Container(
                            height: SizeConfig.h * 0.65,
                            margin: EdgeInsets.only(top: SizeConfig.h * 0.04),
                            child:
                                //  AspectRatio(aspectRatio: 9 / 2, child:
                                c
                            // )
                            );
                        // Column(
                        //   children: <Widget>[
                        //     Center(
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(
                        //           c
                        //               .split(RegExp(r'(%2F)..*(%2F)'))[1]
                        //               .split("?")[0]
                        //               .split("-")[1]
                        //               .replaceAll(RegExp(r"%20"), " "),
                        //           style: TextStyle(fontSize: 25),
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //       height: MediaQuery.of(context).size.height * 0.75,
                        //       child: ClipRRect(
                        //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        //           child: CachedNetworkImage(
                        //             imageUrl: c,
                        //             placeholder: (context, url) =>
                        //                 Center(child: CircularProgressIndicator()),
                        //           )),
                        //     ),
                        //   ],
                        // );
                      }),
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: SizeConfig.h * 0.0018,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: SizeConfig.w,
                        margin: EdgeInsets.only(bottom: 8, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: introCol.map<Widget>((col) {
                            int index = introCol.indexOf(col);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Theme.of(context).primaryColor
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacementNamed(
                            '/Pages',
                            arguments: RouteArgument(id: "0", isLogin: false)),
                        child: Container(
                          // padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: SizeConfig.w * 0.6,
                          height: SizeConfig.h * 0.052,
                          child: Center(
                            child: Text("Get Started",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ),
                      _current == introCol.length - 1
                          ? Container(
                              child: FlatButton(
                                onPressed: () => {},
                                child: Text("Skip",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontSize: 15, color: Colors.white)),
                              ),
                            )
                          : FlatButton(
                              onPressed: () => _controller.animateToPage(
                                introCol.length,
                              ),
                              //  _controller.nextPage(
                              //       duration: Duration(milliseconds: 300),
                              //       // curve: Curves.easeIn
                              //     ),
                              child: Text("Skip",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 15, color: Colors.black)),
                            )
                      //
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

// List<Slide> slides = new List();

//   @override
//   void initState() {
//     super.initState();

//     slides.add(
//       new Slide(
//         widgetTitle: Center(child: Text( "New, innovative approach to general knowledge for school students",)),
//         centerWidget: Center(child: Image.asset("assets/int.svg",height: 500,width:400,fit:BoxFit.contain)),
//         styleDescription: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         //title: "ERASER",
//         // widgetDescription: Image.asset("assets/chicken.svg",height: 90,fit:BoxFit.contain),
//         // description:
//         //     "New, innovative approach to general knowledge for school students",
//         // pathImage: "assets/images/p1.png",

//         backgroundColor: Colors.greenAccent,
//       ),
//     );
//     slides.add(
//       new Slide(
//         styleDescription: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         // title: "PENCIL",
//         description:
//             "Captivating experience with refreshing topics, interesting stories and detailed answers",
//         pathImage: "assets/images/p2.png",
//         heightImage: 400,
//         widthImage: 400,
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//    return new IntroSlider(
//       slides: this.slides,
//     );
//   }
// }

class IntroSreenStae extends StatelessWidget {
  List<Slide> slides = new List();
  List<String> cashBackBullet = [
    "Community Buying - Cashback",
    "No- Rush Delivery - Cashback",
    "Referral - Cashback",
    "Special Event - Cashback"
  ];
  List<String> slideImage = [
    "assets/icons/intro1.png",
    "assets/icons/intro2.png",
    "assets/icons/intro3.png",
    "assets/icons/intro4.png",
    "assets/icons/intro5.png",
  ];

  void onDonePress() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => Subscription()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return Future.value(true);
      },
      child: IntroSlider(
        // colorSkipBtn:Theme.of(context).primaryColor ,
        styleNameSkipBtn: TextStyle(color: Colors.black),
        styleNamePrevBtn: TextStyle(color: Colors.black),
        styleNameDoneBtn: TextStyle(color: Colors.black),
        borderRadiusDoneBtn: 5,
        renderDoneBtn: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          width: SizeConfig.w * 0.5,
          height: 40,
          child: Text("Get Sarted",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 12, color: Colors.white)),
        ),
        colorActiveDot: Theme.of(context).primaryColor,
        // renderNextBtn: Container(
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).primaryColor,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   margin: EdgeInsets.only(top: SizeConfig.h * 0.1),
        //   width: SizeConfig.w * 0.5,
        //   height: 40,
        //   child: FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: Text("NEXT",
        //         style: Theme.of(context)
        //             .textTheme
        //             .headline6
        //             .copyWith(fontSize: 17, color: Colors.white)),
        //   ),
        // ),
        isShowDoneBtn: true,
        isShowPrevBtn: false,
        slides: [],
        onDonePress: this.onDonePress,
      ),
    );
  }
}
