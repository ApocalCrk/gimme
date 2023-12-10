// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gimme/data/review.dart';
import 'package:gimme/screens/gym/reviews/review_screen.dart';
import 'package:gimme/screens/gym/detail_screen.dart';
import 'package:gimme/screens/gym/reviews/reviews_screen.dart';
import 'package:gimme/data/Transaction.dart';
import 'package:gimme/screens/profile/slicing/activity_history.dart';
import 'package:gimme/screens/profile/slicing/membership.dart';
import 'package:gimme/screens/profile/slicing/personal_data.dart';
import 'package:gimme/screens/transactions/transactions_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gimme/screens/auth/signup_screen.dart';
import 'package:gimme/screens/dashboard/dashboard.dart';
import 'package:gimme/screens/subs/generate_qr/qr_screen.dart';
import 'package:gimme/screens/subs/subs_generator_screen.dart';
import 'package:gimme/screens/profile/editProfile/editProfile_screen.dart';
import 'package:gimme/screens/profile/profile_screen.dart';
import 'package:gimme/screens/statistic/statistics_screen.dart';
import 'package:gimme/screens/auth/auth_screen.dart';
import 'package:gimme/screens/auth/signin_screen.dart';
import 'package:gimme/screens/maps/maps_screen.dart';
import 'package:gimme/screens/transactions/success_transaction_screen.dart';

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
  static const String personalData = "/profile/personal_data";
  static const String activityHistory = "/profile/activity_history";
  static const String allmembership = "/profile/membership";
  static const String reviews = "/gym/reviews";
  static const String checkout = "/gym/checkout";
  static const String successCheckout = "/gym/checkout/success";
  static const String review = "/gym/review";
  static const String explore = "/explore";

  static Route<dynamic>? generateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {
      case auth:
        return PageTransition(child: const Auth(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case login:
        return PageTransition(child: const SignInScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case register:
        return PageTransition(child: const SignUpScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case dashboard:
        return PageTransition(child: Dashboard(index: settings.arguments as int), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case subsGenerator:
        return PageTransition(child: const SubsGeneratorScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case qrGenerator:
        final id = settings.arguments as int;
        return PageTransition(child: QrGeneratorScreen(id: id), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case statistic:
        return PageTransition(child: const StatisticsScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case profile:
        return PageTransition(child: const ProfileScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case maps:
        return PageTransition(child: const MapsScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case gymDetail:
        return PageTransition(child: GymDetailScreen(data: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case checkout:
        return PageTransition(child: TransactionScreen(dataTransaction: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case reviews:
        return PageTransition(child: ReviewsScreen(data: settings.arguments as Map<String, dynamic>), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case successCheckout:
        return PageTransition(child: DetailTransactionScreen(dataTransaction: settings.arguments as Transaction), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case review:
        return PageTransition(child: ReviewScreen(review: settings.arguments as ReviewGym), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case personalData:
        return PageTransition(child: const PersonalData(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case activityHistory:
        return PageTransition(child: const ActivityHistory(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      case allmembership:
        return PageTransition(child: const MembershipScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
      default:
        return PageTransition(child: const Auth(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 400));
    }
  }
}
