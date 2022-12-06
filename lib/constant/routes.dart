import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itus_manager/ui/screens/home_screen.dart';
import 'package:itus_manager/ui/screens/login_screen.dart';
import 'package:itus_manager/ui/screens/profile_screen.dart';
import 'package:itus_manager/ui/screens/recover_password_screen.dart';

import '../ui/screens/current_user_info_screen.dart';
import '../ui/screens/query_screen.dart';


class Routes{
  static String loginScreen= "loginScreen";
  static String profileScreen= "profileScreen";
  static String recoverPasswordScreen= "recoverPasswordScreen";
  static String homeScreen= "homeScreen";
  static String queryScreen= "queryScreen";
  static String currentUserInfoScreen= "currentUserInfoScreen";

  Map<String, WidgetBuilder> routes(){
    return {
      loginScreen: (context) =>   const LoginScreen(),
      profileScreen: (context) =>   const ProfileScreen(),
      recoverPasswordScreen: (context) =>   const RecoverPasswordScreen(),
      homeScreen: (context) =>   const HomeScreen(),
      queryScreen: (context) =>   const QueryScreen(),
      currentUserInfoScreen: (context) =>   const CurrentUserInfoScreen(),
    };
  }



}