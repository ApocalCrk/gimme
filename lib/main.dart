import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gimme/routes/AppRoute.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/screens/auth/auth_screen.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'gimme-channel',
          channelName: 'Gimme',
          channelDescription:
              'Notification channel for gimme app',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white),
    ],
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppScreen();
}

class _AppScreen extends State<App> {
  String checkToken = "";

  @override
  void initState() {
    super.initState();
    checkTokenPref();
  }

  checkTokenPref() async {
    var token = await SharedPref.readPrefStr("uid");
    if (token != null) {
      var start = await SharedPref.readPrefStr("shortcuts");
      Map<int, Map<dynamic, String>> dataTemp = convertJsonToMap(start);
      var dataUserTemp = {
        "name": await SharedPref.readPrefStr("name"),
        "username": await SharedPref.readPrefStr("username"),
        "email": await SharedPref.readPrefStr("email"),
        "uid": await SharedPref.readPrefStr("uid"),
        "photoURL": await SharedPref.readPrefStr("photoURL"),
        "dateofbirth": await SharedPref.readPrefStr("dateofbirth"),
        "phoneNumber": await SharedPref.readPrefStr("phoneNumber"),
        "address": await SharedPref.readPrefStr("address"),
        "height": await SharedPref.readPrefStr("height"),
        "weight": await SharedPref.readPrefStr("weight"),
        "created_at": await SharedPref.readPrefStr("created_at"),
        "shortcuts": dataTemp
      };
      setState(() {
        dataUser = dataUserTemp;
        checkToken = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return MaterialApp(
      scrollBehavior: ScrollB(),
      title: "Gimme",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoute.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Montserrat"
      ),
      home: checkToken == "" ? const Auth() : const Dashboard()
    );
  }
}
