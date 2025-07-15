import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostKaroCreationScreen.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/login/view/OtpPage.dart';

final List<GoRoute> postkaroRoutes = [
  ///***** Post Karo Routes *****///
  GoRoute(
      path: '/postkaro/dashboard',
      builder: (context, state) => const PostkaroDashboard()),
  GoRoute(
      path: '/postkaro/creation',
      builder: (context, state) => const PostKaroCreationScreen()),
];
