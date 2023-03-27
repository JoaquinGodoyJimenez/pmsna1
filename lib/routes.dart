import 'package:flutter/material.dart';
import 'package:pmsna1/screens/add_post_screen.dart';
import 'package:pmsna1/screens/dashboard_screen.dart';
import 'package:pmsna1/screens/list_popular_videos.dart';
import 'package:pmsna1/screens/register_screen.dart';
import 'package:pmsna1/screens/eventos_screen.dart';
import 'package:pmsna1/screens/login_screen.dart';
import 'package:pmsna1/screens/onboard.dart';
import 'package:pmsna1/screens/theme_selecter.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dash': (BuildContext context) => DashboardScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/board': (BuildContext context) => const Onboard(),
    '/themes': (BuildContext context) => const ThemeSelecter(),
    '/add': (BuildContext context) => AddPostScreen(),
    '/popular': (BuildContext context) => const ListPopularVideos(),
    '/events': (BuildContext context) => const EventCalendarScreen(),
  };
}