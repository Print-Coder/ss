import 'package:ECom/src/models/productListApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/helpers/custom_trace.dart';
import 'src/models/setting.dart';
import 'src/models/category.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'package:provider/provider.dart';
import 'src/models/userData.dart';
import 'src/pages/cart/api/CartData.dart';
import 'package:overlay_support/overlay_support.dart' as overlay;

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  FirebaseCrashlytics.instance. = tru

  // await GlobalConfiguration().loadFromAsset("configurations");
  // print(CustomTrace(StackTrace.current,
  //     message: "base_url: ${GlobalConfiguration().getValue('base_url')}"));
  // print(CustomTrace(StackTrace.current,
  //     message:
  //         "api_base_url: ${GlobalConfiguration().getValue('api_base_url')}"));

  runApp(MyApp());

  // var platform = MethodChannel('com.shopsasta.app');
  // await platform.invokeMethod('setnotificationManager');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // settingRepo.initSettings();
    // settingRepo.getCurrentLocation();
    // userRepo.getCurrentUser();
    super.initState();
  }

  bool dark = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // return ValueListenableBuilder(
    //     valueListenable: settingRepo.setting,
    //     builder: (context, Setting _setting, _) {
    //       return
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductListData()),
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => CartData()),
      ],
      child: OverlaySupport(
        child: MaterialApp(

            // navigatorKey: settingRepo.navigatorKey,
            title: "shopsasta",
            initialRoute: '/Splash',
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            locale: Locale("HI"),

            // supportedLocales: S.delegate.supportedLocales,
            theme: !dark
                ? ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    fontFamily: 'Roboto',
                    appBarTheme: AppBarTheme(
                        elevation: 0,
                        textTheme: TextTheme(
                          headline5: TextStyle(
                            color: Color.fromRGBO(2, 155, 151, 1),
                          ),
                          headline6: TextStyle(
                            color: Color.fromRGBO(2, 155, 151, 1),
                          ),
                          headline4: TextStyle(
                            color: Color.fromRGBO(2, 155, 151, 1),
                          ),
                        )),
                    accentColor: Colors.grey[600],
                    // Color.fromRGBO(2, 155, 151, 1),
                    primaryColorLight: Colors.white,
                    primaryColorDark: Colors.yellow,
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        elevation: 0, foregroundColor: Colors.white),
                    brightness: Brightness.light,
                    primaryColor: Color.fromRGBO(2, 155, 151, 1),
                    //  Color.fromRGBO(15,145,210,1),
                    dividerColor: Colors.grey[300],
                    focusColor: Colors.black,
                    hintColor: Colors.black38,
                    textTheme: TextTheme(
                      headline5: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.grey[700],
                          height: 1.2),
                      headline4: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                          height: 1.3),
                      headline3: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[700],
                          height: 1.3),
                      headline2: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                          height: 1.4),
                      headline1: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700],
                          height: 1.4),
                      subtitle1: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                          height: 1.3),
                      headline6: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[800],
                          height: 1.3),
                      bodyText2: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                          height: 1.5),
                      bodyText1: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                          height: 1.3),
                      caption: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                          height: 1.2),
                    ),
                  )
                : ThemeData(
                    fontFamily: 'ProductSans',
                    primaryColorLight: Colors.white,
                    brightness: Brightness.dark,
                    scaffoldBackgroundColor: Color(0xFF2C2C2C),
                    accentColor: config.Colors().mainDarkColor(1),
                    dividerColor: config.Colors().primaryColor(0.1),
                    hintColor: config.Colors().secondDarkColor(1),
                    focusColor: config.Colors().accentDarkColor(1),
                    textTheme: TextTheme(
                      headline5: TextStyle(
                          fontSize: 22.0,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.3),
                      headline4: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.3),
                      headline3: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.3),
                      headline2: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: config.Colors().mainDarkColor(1),
                          height: 1.4),
                      headline1: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w300,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.4),
                      subtitle1: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.3),
                      headline6: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: config.Colors().mainDarkColor(1),
                          height: 1.3),
                      bodyText2: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.2),
                      bodyText1: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: config.Colors().secondDarkColor(1),
                          height: 1.3),
                      caption: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          color: config.Colors().secondDarkColor(0.6),
                          height: 1.2),
                    ),
                  )),
      ),
    );
  }
}
