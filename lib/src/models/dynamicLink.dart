import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class DynamicLinkService {
  Future<Map<bool, String>> handleDynamicLinks() async {
    // ======================= dynamic link block  comment  for ios ========================================
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data?.link != null)
      return {
        (data?.link?.queryParameters["isProduct"]) == "true":
            data?.link?.pathSegments?.last ?? null
      };
    else {
      return {false: "null"};
    }

    // ======================= dynamic link block   comment for ios ========================================

    // return {false: "null"};  uncomment for ios
  }

  Map<bool, String> handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (data?.link != null)
      return {
        (data?.link?.queryParameters["isProduct"]) == "true":
            data?.link?.pathSegments?.last ?? null
      };
    else {
      return {false: "null"};
    }
  }

  Future<String> createReferLink(String code) async {
    if (Platform.isAndroid) {
      // Android-specific code

      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://shopsasta.page.link',
        link: Uri.parse(
            "https://dev.shopsasta.com/refercode/$code?isProduct=false"),
        androidParameters: AndroidParameters(
          packageName: 'com.shopsasta.app',
        ),

        // Other things to add as an example. We don't need it now
        iosParameters: IosParameters(
          bundleId: 'com.shopsasta.app',
          // minimumVersion: '1.0.1',
          appStoreId: '1561768165',
        ),
        // googleAnalyticsParameters: GoogleAnalyticsParameters(
        //   campaign: 'example-promo',
        //   medium: 'social',
        //   source: 'orkut',
        // ),
        // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        //   providerToken: '123456',
        //   campaignToken: 'example-promo',
        // ),
        // socialMetaTagParameters: SocialMetaTagParameters(
        //   title: 'Example of a Dynamic Link',
        //   description: 'This link works whether app is installed or not!',

        // ),The Referal Code for registeration is SSAEAF9A7.Share and earn Cashbacks. Shossasta Application :
        //The Referal Code for registeration is SSAEAF9A7.Share and earn Cashbacks. Shossasta Application :https://shopsasta.page.link/mEQV8o3ePxqPCNEr7
      );

      final Uri dynamicUrl = await parameters.buildUrl();
      final ShortDynamicLink short = await parameters.buildShortLink();
      // print("this is dynamic" + short.shortUrl.data.uri.pathSegments.last);
      print("this is short ${short.shortUrl.path}");

      return short.shortUrl.toString();
    } else if (Platform.isIOS) {
      // iOS-specific code
      //
      return "https://itunes.apple.com/in/app/shopsasta/id1561768165";
    }
  }

  Future<String> createProductLink(String linker) async {
    if (Platform.isAndroid) {
      // Android-specific code
      //
      final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://shopsasta.page.link',
        link: Uri.parse(
            "https://dev.shopsasta.com/detail/$linker?isProduct=true"),
        androidParameters: AndroidParameters(
          packageName: 'com.shopsasta.app',
        ),

        // Other things to add as an example. We don't need it now
        iosParameters: IosParameters(
          bundleId: 'com.shopsasta.app',
          // minimumVersion: '1.0.1',
          appStoreId: 'm1561768165',
        ),
        // googleAnalyticsParameters: GoogleAnalyticsParameters(
        //   campaign: 'example-promo',
        //   medium: 'social',
        //   source: 'orkut',
        // ),
        // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        //   providerToken: '123456',
        //   campaignToken: 'example-promo',
        // ),
        // socialMetaTagParameters: SocialMetaTagParameters(
        //   title: 'Example of a Dynamic Link',
        //   description: 'This link works whether app is installed or not!',

        // ),The Referal Code for registeration is SSAEAF9A7.Share and earn Cashbacks. Shossasta Application :
        //The Referal Code for registeration is SSAEAF9A7.Share and earn Cashbacks. Shossasta Application :https://shopsasta.page.link/mEQV8o3ePxqPCNEr7
      );

      final Uri dynamicUrl = await parameters.buildUrl();
      final ShortDynamicLink short = await parameters.buildShortLink();
      // print("this is dynamic" + short.shortUrl.data.uri.pathSegments.last);
      print("this is short ${short.shortUrl.path}");

      return short.shortUrl.toString();
    } else if (Platform.isIOS) {
      // iOS-specific code
      return "https://itunes.apple.com/in/app/shopsasta/id1561768165";
    }
  }
}
