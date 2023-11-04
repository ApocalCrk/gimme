import 'package:flutter/material.dart';
import 'package:gimme/routes/appRoute.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<App> createState() => _AppScreen();
}

class _AppScreen extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    return MaterialApp(
      scrollBehavior: ScrollB(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
