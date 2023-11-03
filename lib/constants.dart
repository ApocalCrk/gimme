import 'package:flutter/material.dart';
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
class LabelTextConstant{
  static const String homePageAppBarTitle = "Modul QR, Scanner, Camera";
  static const String scanQrPlaceHolderLabel = "Scan Something & click to copy to clipboard";
  static const String txtonCopyingClipBoard = "Qr code disalin ke clipboard";
  static const String txtonInvalidQRCode = "QR Code tidak valid";
}
