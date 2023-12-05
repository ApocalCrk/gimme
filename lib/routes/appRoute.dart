// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gimme/screens/gym/addreview_screen.dart';
import 'package:gimme/screens/gym/detail_screen.dart';
import 'package:gimme/screens/gym/reviews_screen.dart';
import 'package:gimme/screens/transactions/transactions_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gimme/screens/auth/signup_screen.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';
import 'package:gimme/screens/dashboard/generate_qr/qr_screen.dart';
import 'package:gimme/screens/dashboard/subs/subs_generator_screen.dart';
import 'package:gimme/screens/profile/editProfile/editProfile_screen.dart';
import 'package:gimme/screens/profile/profile_screen.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';
import 'package:gimme/screens/auth/auth_screen.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
import 'package:gimme/screens/dashboard/maps/maps_screen.dart';
import 'package:gimme/screens/transactions/success_transaction_screen.dart';
import 'package:gimme/screens/workout/workout_screen.dart';

class AppRoute {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String auth = "/auth";
  static const String login = "/auth/signin";
  static const String register = "/auth/signup";
  static const String dashboard = "/dashboard";
  static const String subsGenerator = "/subs";
  static const String qrGenerator = "/subs/generate";
  static const String statistic = "/statistic";
  static const String maps = "/maps";
  static const String gymDetail = "/gym/detail";
  static const String profile = "/profile";
  static const String editProfile = "/profile/edit";
  static const String reviews = "/gym/reviews";
  static const String checkout = "/gym/checkout";
  static const String successCheckout = "/gym/checkout/success";
  static const String review = "/gym/review";
  static const String workout = "/workout";

  static Route<dynamic>? generateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {
      case auth:
        return PageTransition(child: const Auth(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case login:
        return PageTransition(child: const SignInScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case register:
        return PageTransition(child: const SignUpScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case dashboard:
        return PageTransition(child: const Dashboard(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case subsGenerator:
        return PageTransition(child: const SubsGeneratorScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case qrGenerator:
        return PageTransition(child: const QrGeneratorScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case statistic:
        return PageTransition(child: const StatisticsScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case profile:
        return PageTransition(child: const ProfileScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case editProfile: 
        return PageTransition(child: const EditProfileScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case maps:
        return PageTransition(child: const MapsScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case gymDetail:
        final id = settings.arguments as int;
        return PageTransition(child: GymDetailScreen(id: id), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case checkout:
        return PageTransition(child: TransactionScreen(dataTransaction: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case reviews:
        final id = settings.arguments as int;
        return PageTransition(child: ReviewsScreen(id: id), type: PageTransitionType.rightToLeftWithFade, duration: const Duration(milliseconds: 400));
      case successCheckout:
        return PageTransition(child: DetailTransactionScreen(dataTransaction: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case review:
        return PageTransition(child: AddReviewScreen(review: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case workout: 
      // final id = settings.arguments as int;
        return PageTransition(child: WorkoutsScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      default:
        return PageTransition(child: const Auth(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
    }
  }
}
