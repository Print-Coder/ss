import 'package:ECom/src/pages/Account/vendorResource.dart';
import 'package:ECom/src/pages/auth/loginAndRegister.dart';
import 'package:ECom/src/pages/auth/otp.dart';
import 'package:ECom/src/pages/auth/deliveryCoverage.dart';
import 'package:ECom/src/pages/auth/AddAddress.dart';
import 'package:ECom/src/pages/cart/cart.dart';
import 'package:ECom/src/pages/cart/cartNoItem.dart';
import 'package:ECom/src/pages/orders/orderConfirmation.dart';
import 'package:ECom/src/pages/orders/orderHistory.dart';
import 'package:ECom/src/pages/orders/orderDetails.dart';
import 'package:ECom/src/pages/productDetails/product.dart';
import 'package:ECom/src/pages/productListing/productListing.dart';
import 'package:flutter/material.dart';
import 'package:ECom/src/pages/category.dart';
import 'package:ECom/src/pages/pages.dart';
import 'package:ECom/src/pages/splash_screen.dart';
import 'package:ECom/src/pages/Account/MyAccount.dart';
import 'package:ECom/src/pages/Account/Support.dart';
import 'package:ECom/src/pages/Account/Profile.dart';
import 'package:ECom/src/pages/Account/earning/MyEarning.dart';
import 'package:ECom/src/pages/Account/ReferYourFriend.dart';
import 'package:ECom/src/pages/Account/address/AllAddress.dart';
import 'package:ECom/src/pages/Account/address/EditAddress.dart';
import 'src/models/route_argument.dart';
import 'package:ECom/src/pages/sasta/sastaDeals.dart';
import 'package:ECom/src/pages/search/searchScreen.dart';
import 'package:ECom/src/pages/group/MyGroup.dart';
import 'package:ECom/src/pages/Account/address/AddNewAddress.dart';
import 'src/pages/auth/register.dart';
import 'src/pages/intro/introduction.dart';
import 'package:ECom/src/pages/Account/termsAndCondition.dart';

import 'package:ECom/src/pages/Account/privacyPolicy.dart';

import 'package:ECom/src/pages/Account/howItWorks.dart';

import 'package:ECom/src/pages/Account/deliveryCoverageWeb.dart';

import 'package:ECom/src/pages/Account/help.dart';
import 'package:ECom/src/pages/Account/aboutUsWeb.dart';
import 'package:ECom/src/pages/Account/cancellationPolicy.dart';
import 'package:ECom/src/pages/Account/returnRefund.dart';
import 'package:ECom/src/pages/Account/faq/faqScreen.dart';
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case '/Debug':
      // return MaterialPageRoute(builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Search':
        return MaterialPageRoute(builder: (_) => SearchScreen());
      // case '/MobileVerification':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/MobileVerification2':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/Login':
      //   return termsAndCondition(builder: (_) => termsAndCondition());

      case '/help':
        return MaterialPageRoute(builder: (_) => Help());
      case '/cancellationPolicy':
        return MaterialPageRoute(builder: (_) => CancellationPolicy());
      case '/faq':
        return MaterialPageRoute(builder: (_) => FaqScreen());
      case '/returnRefund':
        return MaterialPageRoute(builder: (_) => ReturnRefund());
      case '/vendor':
        return MaterialPageRoute(builder: (_) => VendorResource());
      case '/privacyPolicy':
        return MaterialPageRoute(builder: (_) => PrivacyPolicy());
      case '/howItWorks':
        return MaterialPageRoute(builder: (_) => HowItWorks());
      case '/deliveryCoverageWeb':
        return MaterialPageRoute(builder: (_) => DeliveryCoverageWeb());
      case '/aboutUsWeb':
        return MaterialPageRoute(builder: (_) => AboutUsWeb());
      case '/termConditions':
        return MaterialPageRoute(builder: (_) => TermsAndConditions());

      case '/AddAddress':
        return MaterialPageRoute(builder: (_) => AddAddress());
      case '/AddNewAddress':
        return MaterialPageRoute(builder: (_) => AddNewAddress());
      case '/ProductList':
        return MaterialPageRoute(builder: (_) => ProductList());
      case '/Otp':
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case '/Intro':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/OrderConfirmation':
        return MaterialPageRoute(builder: (_) => OrderConfirmation());
      case '/OrderHistory':
        return MaterialPageRoute(builder: (_) => OrderHistory());
      case '/OrderDetails':
        return MaterialPageRoute(builder: (_) => OrderDetails());
      case '/DeliveryCoverage':
        return MaterialPageRoute(builder: (_) => DeliveryCoverage());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/MyAccount':
        return MaterialPageRoute(builder: (_) => MyAccount());
      case '/Mygroup':
        return MaterialPageRoute(builder: (_) => MyGroup());
      case '/Support':
        return MaterialPageRoute(builder: (_) => Support());
      case '/Sasta':
        return MaterialPageRoute(builder: (_) => SastaDeals());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/MyEarnings':
        return MaterialPageRoute(builder: (_) => MyEarnings());
      case '/ReferYourFriend':
        return MaterialPageRoute(builder: (_) => ReferYourFriend());

      case '/AllAddress':
        return MaterialPageRoute(builder: (_) => AllAddress());
      case '/EditAddress':
        return MaterialPageRoute(builder: (_) => EditAddress());
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/CartNoItem':
        return MaterialPageRoute(builder: (_) => CartNoItem());

      case '/Product':
        return MaterialPageRoute(
            builder: (_) =>
                ProductWidget(routeArgument: args as RouteArgument));
      case '/Category':
        return MaterialPageRoute(
            builder: (_) =>
                CategoryWidget(routeArgument: args as RouteArgument));
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/Register':
        return MaterialPageRoute(builder: (_) => Register());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
