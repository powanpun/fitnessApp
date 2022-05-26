import 'package:fitnessapp/datamodels/challenges_model.dart';
import 'package:fitnessapp/datamodels/workout_model.dart';
import 'package:fitnessapp/screens/auth/forgot_password.dart';
import 'package:fitnessapp/screens/auth/login.dart';
import 'package:fitnessapp/screens/auth/signup.dart';
import 'package:fitnessapp/screens/dashboard/bottom_navigation/bottom_navigation.dart';
import 'package:fitnessapp/screens/dashboard/recommendation/recommendation_page.dart';
import 'package:fitnessapp/screens/setting/setting.dart';
import 'package:fitnessapp/screens/workout/workout.dart';
import 'package:fitnessapp/screens/workout/workout_detail_page.dart';
import 'package:flutter/material.dart';

const String loginPageRoute = "loginPage";
const String signupPageRoute = "signupPage";
const String forgotPasswordRoute = "forgotPasswordPage";
const String bottomNavigationRoute = "bottomNavigationPage";
const String workoutRoute = "workoutPage";
const String workoutDetailPageRoute = "workoutDetailPage";
const String recommendationPageRoute = "recommendationPage";
const String settingPageRoute = "settingPage";

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginPageRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case signupPageRoute:
        return MaterialPageRoute(builder: (context) => const Signup());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case settingPageRoute:
        return MaterialPageRoute(builder: (context) => const SettingPage());
      case bottomNavigationRoute:
        return MaterialPageRoute(
            builder: (context) => const NavigationHandlerPage());
      case recommendationPageRoute:
        return MaterialPageRoute(
            builder: (context) => const RecommendationPage());
      case workoutRoute:
        if (args is ChallengesModel) {
          return MaterialPageRoute(
              builder: (context) => WorkoutPage(data: args));
        }
        return throw ("error on args on workout page");

      case workoutDetailPageRoute:
        if (args is List<WorkoutModel>) {
          return MaterialPageRoute(
              builder: (context) => WorkoutDetailPage(
                    data: args,
                  ));
        }
        return throw ("error on args on worout detail page");

      default:
        throw ("Route name does not exist");
    }
  }
}
