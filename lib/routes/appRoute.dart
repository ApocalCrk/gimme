import 'package:flutter/material.dart';
import 'package:gimme/screens/auth/signup_screen.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';
import 'package:gimme/screens/dashboard/generate_qr/qr_screen.dart';
import 'package:gimme/screens/dashboard/subs/subs_generator_screen.dart';
import 'package:gimme/screens/profile/editProfile/editProfile_screen.dart';
import 'package:gimme/screens/profile/profile_screen.dart';
import 'package:gimme/screens/explore/explore_screen.dart';
import 'package:gimme/screens/explore/slicing/qr_scanner.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';
import 'package:gimme/screens/auth/auth_screen.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
import 'package:gimme/screens/workouts/workouts_sreen.dart';


class AppRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String auth = "/auth";
  static const String login = "/auth/signin";
  static const String register = "/auth/signup";
  static const String dashboard = "/dashboard";
  static const String subsGenerator = "/subs";
  static const String qrGenerator = "/subs/generate";
  static const String statistic = "/statistic";
  static const String profile = "/profile";
  static const String editProfile = "/profile/edit";
  static const String explore = "/explore";
  static const String qrScanner = "/explore/qrScanner";
  static const String workouts = "/workouts";


  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const Auth());
      case login:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case subsGenerator:
        return MaterialPageRoute(builder: (_) => const SubsGeneratorScreen());
      case qrGenerator:
        return MaterialPageRoute(builder: (_) => const QrGeneratorScreen());
      case statistic:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case editProfile: 
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case explore:
        return MaterialPageRoute(builder: (_) => const ExploreScreen());
      case qrScanner:
        return MaterialPageRoute(builder: (_) => const BarcodeScannerPageView());
      case workouts:
        return MaterialPageRoute(builder: (_) => const WorkoutsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
    }
  }
}
