import 'package:amir_chikan/presentation/Global_widget/bottomNavigationbar.dart';
import 'package:amir_chikan/screens/AuthScreen/Phone_Auth_page.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/home_page_screen.dart';
import 'package:amir_chikan/screens/Mycart/Screens/Mycard_Sreen.dart';
import 'package:amir_chikan/screens/Order/OrderRecipt1.dart';
import 'package:amir_chikan/screens/Order/Profile/profileScreen.dart';
import 'package:amir_chikan/presentation/Global_widget/SplashScreen.dart';
import 'package:amir_chikan/screens/shop/ShopDetailsPage.dart';
import 'package:amir_chikan/screens/shop/productdetailstpage.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/HomePageScreen';
  static const String myCard = '/MyCardScreen';
  static const String profile = '/ProfileScreen';
  static const String order = '/OrderScreen';
  static const String splash = '/SplashScreen';
  static const String nav = '/NavBar';
  static const String phoneauth = '/phoneauth';


  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomePageScreen(),
    myCard: (context) => MyCardScreen(),
    profile: (context) => const ProfileScreen(),
  
    splash: (context) => const SplashScreen(),
    nav: (context) => const NavBar(),
    phoneauth: (context) => const PhoneAuthScreen(),
  };
}
