import 'package:flutter/material.dart';
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color primaryColor = Color(0xFF60CEF8);
const Color primary2Color = Color(0xFFAFB2EC);
const Color secondaryColor = Color(0xFF707070);
const Color successColor = Color(0xFF7CB87B);
const Color warningColor = Color(0xFFF3DFAE);
const Color errorColor = Color(0xFFF3AEBA);
const Color sideColor = Color(0xFFD0ECFB);
const Color lowSuccessColor = Color(0xFFCCF3AE);
const Color lowPrimaryColor = Color(0xFFAED6F3);
const Color lowSecondaryColor = Color.fromRGBO(5, 5, 5, 0.08);

Widget sizedBoxDefault = const SizedBox(height: 20);
var dataUser = {};

class SharedPref {
  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static readPrefStr(String key) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(key);
  }

  static getAllData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getKeys();
  }
}

class ScrollB extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Map<int, Map<dynamic, String>> convertJsonToMap(String jsonString) {
  var decoded = gson.decode(jsonString);
  Map<int, Map<dynamic, String>> resultMap = {};
  decoded.forEach((key, value) {
    int intKey = int.parse(key);
    Map<dynamic, String> stringValueMap = {};

    value.forEach((innerKey, innerValue) {
      stringValueMap[innerKey] = innerValue.toString();
    });

    resultMap[intKey] = stringValueMap; 
  });

  return resultMap;
}

String moneyFormat(int number) {
  String money = number.toString();
  String result = "";
  int count = 0;
  for (int i = money.length - 1; i >= 0; i--) {
    count++;
    result = money[i] + result;
    if (count == 3 && i != 0) {
      result = "." + result;
      count = 0;
    }
  }
  return result;
}

const Map<int, Map<dynamic, String>> defaultShortcut = {
  1: {
    "icon": "assets/images/icon/gym.png",
    "title": "Gym",
    "Color": "0xFFAED6F3",
    "route": "/gym"
  },
  2: {
    "icon": "assets/images/icon/diet.png",
    "title": "Diet",
    "Color": "0xFFAFB2EC",
    "route": "/diet"
  },
  3: {
    "icon": "assets/images/icon/yoga.png",
    "title": "Yoga",
    "Color": "0xFFCCF3AE",
    "route": "/yoga"
  },
  4: {
    "icon": "assets/images/icon/cardio.png",
    "title": "Cardio",
    "Color": "0xFFF3AEBA",
    "route": "/cardio"
  },
};