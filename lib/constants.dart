import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String url = 'gimme.noturminesv.my.id';
const String endpoint = '/api/v1';

const Color primaryColor = Color(0xFF60CEF8);
const Color primary2Color = Color(0xFFAFB2EC);
const Color secondaryColor = Color(0xFF707070);
const Color successColor = Color(0xFF7CB87B);
const Color warningColor = Color(0xFFF3DFAE);
const Color errorColor = Color(0xFFF3AEBA);
const Color sideColor = Color(0xFFD0ECFB);
const Color lowSuccessColor = Color(0xFFCCF3AE);
const Color lowPrimaryColor = Color(0xFFAED6F3);
const Color lowPrimary2Color = Color.fromARGB(255, 192, 195, 243);
const Color lowSecondaryColor = Color.fromRGBO(5, 5, 5, 0.08);

Widget sizedBoxDefault = const SizedBox(height: 20);
var dataUser = {};
Map<String, dynamic> tempDataPlan = {};

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

Widget popUpImage(BuildContext context, String url) {
  return Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExtendedImage.network(url).image,
          fit: BoxFit.cover
        )
      ),
    ),
  );
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
      result = ".$result";
      count = 0;
    }
  }
  return result;
}

int generateIDTransaction() {
  var now = DateTime.now();
  var id = now.millisecondsSinceEpoch;
  return id;
}

class Notify {
  final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  String title;
  String body;
  String channelKey;

  Notify({
    required this.title,
    required this.body,
    required this.channelKey,
  });

  Future<bool> instantNotify() async {
    return awesomeNotifications.createNotification(
      content: NotificationContent(
        id: Random().nextInt(999999),
        channelKey: channelKey,
        title: title,
        body: body,
      ),
    );
  }
}

String getTimeOnDate(String date) {
  var dateSplit = date.split("T");
  var dateSplit2 = dateSplit[1].split(".");
  return dateSplit2[0];
}

String checkUser(String date) {
  var dateSplit = date.split("T");
  var dateSplit2 = dateSplit[0].split("-");
  DateTime now = DateTime.now();
  DateTime newDate = DateTime(int.parse(dateSplit2[0]), int.parse(dateSplit2[1]), int.parse(dateSplit2[2].split(" ")[0]));
  var difference = now.difference(newDate).inDays;
  if (difference > 330) {
    return "Professional User";
  } else {
    return "New User";
  }
}

String formatStringDate(String date) {
  var dateSplit = date.split("T");
  var dateSplit2 = dateSplit[0].split("-");
  var dateSplit3 = dateSplit2[2].split(" ");
  var month = "";
  switch (dateSplit2[1]) {
    case "01":
      month = "Jan";
      break;
    case "02":
      month = "Feb";
      break;
    case "03":
      month = "Mar";
      break;
    case "04":
      month = "Apr";
      break;
    case "05":
      month = "May";
      break;
    case "06":
      month = "Jun";
      break;
    case "07":
      month = "Jul";
      break;
    case "08":
      month = "Aug";
      break;
    case "09":
      month = "Sep";
      break;
    case "10":
      month = "Oct";
      break;
    case "11":
      month = "Nov";
      break;
    case "12":
      month = "Dec";
      break;
  }
  return "$month ${dateSplit3[0]}, ${dateSplit2[0]}";
}

const Map<int, Map<dynamic, String>> defaultShortcut = {
  1: {
    "icon": "assets/images/icon/gym.png",
    "title": "Gym",
    "Color": "0xFFAED6F3",
    "id_workout": "1",
    "exercise_name": "Barbell Press",
    "kalori": "355",
    "duration": "1"
  },
  2: {
    "icon": "assets/images/icon/diet.png",
    "title": "Diet",
    "Color": "0xFFAFB2EC",
    "id_workout": "2",
    "exercise_name": "Mountain Climber",
    "kalori": "355",
    "duration": "1"
  },
  3: {
    "icon": "assets/images/icon/yoga.png",
    "title": "Yoga",
    "Color": "0xFFCCF3AE",
    "id_workout": "1",
    "exercise_name": "Plate Pressout",
    "kalori": "355",
    "duration": "1"
  },
  4: {
    "icon": "assets/images/icon/cardio.png",
    "title": "Cardio",
    "Color": "0xFFF3AEBA",
    "id_workout": "1",
    "exercise_name": "Hanging Leg Raise",
    "kalori": "355",
    "duration": "1"
  },
};

const List<Map<String, dynamic>> contact = [
  {
    "name": "Ferdy Firmansyah",
    "instagram": "ferdyfrms"
  },
  {
    "name": "Trisna Utama",
    "instagram": "trisnautamaa"
  },
  {
    "name": "Fathur Rosi",
    "instagram": "fathurrosi_14"
  },
  {
    "name": "Simon Adrian Agis",
    "instagram": "simon.agis"
  },
  {
    "name": "Hagai Suranta Perangin-angin",
    "instagram": "hagaisuranta"
  },
];