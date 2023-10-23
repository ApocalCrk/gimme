import 'package:flutter/material.dart';
import 'package:gimme/routes/appRoute.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
