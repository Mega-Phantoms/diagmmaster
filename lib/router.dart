import 'package:flutter/material.dart';
import 'package:researchapp/constants.dart';
import 'package:researchapp/ui/screens/sub_cases.dart';
import 'package:researchapp/ui/screens/view_cases.dart';
import 'package:researchapp/ui/screens/homescreen.dart';
import 'package:researchapp/ui/screens/loginscreen.dart';
import 'package:researchapp/ui/screens/settings.dart';
import 'package:researchapp/ui/screens/signupscrren.dart';
import 'package:researchapp/ui/screens/splashscreen.dart';
import 'package:researchapp/ui/screens/view_patients.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => Home());
      case LOGIN_PAGE:
        return MaterialPageRoute(builder: (_) => Login());
      case SIGNUP_PAGE:
        return MaterialPageRoute(builder: (_) => SignUp());
      case SETTINGS:
        return MaterialPageRoute(builder: (_) => Settings());
      case VIEW_PATIENTS:
        return MaterialPageRoute(builder: (_) => ViewPatients());
      case VIew_CASES:
        return MaterialPageRoute(builder: (_) => ViewCases());
      case VIEW_SUB_CASES:
        return MaterialPageRoute(builder: (_) => SubCases());
      // case ADD_CASE:
      //   return MaterialPageRoute(builder: (_) => AddCase());
      default:
        return null;
    }
  }
}
