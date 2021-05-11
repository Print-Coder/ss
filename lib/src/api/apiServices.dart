import 'dart:convert';

import 'package:ECom/src/helpers/constants.dart';
import 'package:ECom/src/helpers/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as hp;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const headers = {'Content-Type': 'application/json'};

  static Future postRequest(var data, String endPoint) async {
    Map res = {};
    await hp
        .post(baseUrl + endPoint, body: data, headers: headers)
        .then((response) {
      print("after then of http" + response.toString());
      if (response != null) {
        res = json.decode(response.body);
        print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: res["message"],
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = null;
        } //
      }
    }).catchError((error) {
      // print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    // print("at end" + res.toString());
    return res;
    //
  }

  static Future putRequest(var data, String endPoint) async {
    Map res = {};
    await hp
        .put(baseUrl + endPoint, body: data, headers: headers)
        .then((response) {
      print("after then of http" + response.toString());
      if (response != null) {
        res = json.decode(response.body);
        print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: res["message"],
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = null;
        } //
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    // print("at end" + res.toString());
    return res;
    //
  }

  static Future postRequestToken(
    var data,
    String endPoint,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = await prefs.getString('token');
    print(token);
    var headersToken = {
      'Content-Type': 'application/json',
      'x-auth': token,
    };
    Map res = {};
    print("apapappapap api url for cart add ${data}   " + baseUrl + endPoint);
    await hp
        .post(baseUrl + endPoint, body: data, headers: headersToken)
        .then((response) {
      print("after post  http" + response.body);
      if (response != null) {
        res = json.decode(response.body);
        // print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          // print("insode satus not 400");
          Fluttertoast.showToast(
            msg: res["message"],
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = null;
        } //
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    // print("at end" + res.toString());
    return res;
    //
  }

  static Future postRequestListToken(
    var data,
    String endPoint,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = await prefs.getString('token');
    print(token);
    var headersToken = {
      'Content-Type': 'application/json',
      'x-auth': token,
    };
    List<dynamic> res = [];
    await hp
        .post(baseUrl + endPoint, body: data, headers: headersToken)
        .then((response) {
      print("after post  http" + response.body);
      if (response != null) {
        res = json.decode(response.body);
        // print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: "Server is not responding",
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = null;
        } //
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    // print("at end" + res.toString());
    return res;
    //
  }
  static Future getRequestList(
   
    String endPoint,
  ) async {
   
    var headersToken = {
      'Content-Type': 'application/json',
    
    };
    List<dynamic> res = [];
    await hp
        .get(baseUrl + endPoint,  headers: headersToken)
        .then((response) {
      print("after post  http" + response.body);
      if (response != null) {
        res = json.decode(response.body);
        // print("after decode" + res.toString());

        if (response.statusCode == 400) {
          //status-1
          print("insode satus not 400");
          Fluttertoast.showToast(
            msg: "Server is not responding",
            backgroundColor: Colors.grey[400],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
          );

          res = null;
        } //
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    // print("at end" + res.toString());
    return res;
    //
  }

  static Future<Map<dynamic, dynamic>> getRequest(
    String endPoint,
  ) async {
    Map res = {};
    await hp.get(baseUrl + endPoint, headers: headers).then((response) {
      if (response != null) {
        res = json.decode(response.body);
        // print("response json decode" + res.toString());

        if (response.statusCode == 400) {
          res = null;
        } //
      }
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    //
    print(res);
    return res;
  }

  static Future<Map<dynamic, dynamic>> getRequestPincode(
    String endPoint,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String pincode = await prefs.getString('pinCode');
    print("for categry get $pincode $endPoint");
    Map res = {};
    await hp
        .get(baseUrl + endPoint + "&pincode=$pincode", headers: headers)
        .then((response) {
      if (response != null) {
        res = json.decode(response.body);
        print("response json decode" + res.toString());

        if (response.statusCode == 400) {
          res = null;
        } //
      }
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Server is not responding!!!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    //
    // print(res);
    return res;
  }

  static Future<Map<dynamic, dynamic>> getRequestToken(String endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = await prefs.getString('token');
    print(token);
    Map<String, String> headersToken = {
      // "Content-Type": "application/json",
      "x-auth": token,
    };
    // print(token);
    Map res = {};

    await hp.get(baseUrl + endPoint, headers: headersToken).then((response) {
      // .then((response) {
      print("inside  method of get request api hit");
      // print("response---D" + res.toString());
      if (response != null) {
        res = json.decode(response.body);
        // print("response json decode" + res.toString());

        if (response.statusCode == 400) {
          res = null;
        } //
        //   // }
      }
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Check your Internet Connection!",
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
      );
      res = null;
    });
    //
    // print(res);
    return res;
  }

  static Future<Map<dynamic, dynamic>> delRequestToken(String endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = "";
    token = await prefs.getString('token');
    var headersToken = {
      // 'Content-Type': 'application/json',
      'x-auth': token,
    };
    // print(token);
    Map res = {};

    await hp.delete(baseUrl + endPoint, headers: headersToken).then((response) {
      // .then((response) {
      print("inside  method of get request api hit");
      // print("response---D" + res.toString());
      if (response != null) {
        res = json.decode(response.body);
        // print("response json decode" + res.toString());

        if (response.statusCode == 400) {
          res = null;
        } //
        //   // }
      }
    }).catchError((e) {
      print(e);
      // Fluttertoast.showToast(
      //   msg: "Server is not responding",
      //   backgroundColor: Colors.grey[400],
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 2,
      // );
      res = null;
    });
    //
    // print(res);
    return res;
  }
}
