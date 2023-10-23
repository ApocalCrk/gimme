import 'package:flutter/material.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';
import 'package:gimme/screens/dashboard/generate_qr/qr_screen.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';
import 'package:gimme/screens/dashboard/subs/subs_generator_screen.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';

class AppRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String dashboard = "/dashboard";
  static const String subsGenerator = "/subs";
  static const String qrGenerator = "/subs/generate";
  static const String statistic = "/statistic";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case subsGenerator:
        return MaterialPageRoute(builder: (_) => const SubsGeneratorScreen());
      case qrGenerator:
        return MaterialPageRoute(builder: (_) => const QrGeneratorScreen());
      case statistic:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Dashboard());
    }
  }
}
