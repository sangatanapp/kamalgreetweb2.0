import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/login/view/OtpPage.dart';

final List<GoRoute> loginRoutes = [
  ///***** Guruvani Routes *****///
  GoRoute(path: '/', builder: (context, state) => const LoginPage()),
  GoRoute(path: '/verifyOtp', builder: (context, state) => OtpPage()),
  GoRoute(
      path: '/dashboard', builder: (context, state) => const DashboardScreen()),
];
