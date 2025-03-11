import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/login/view/OtpPage.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/verifyOtp',
      builder: (context, state) => OtpPage(),
    ),
  ],
);
