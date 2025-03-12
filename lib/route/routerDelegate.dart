import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/login/view/OtpPage.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  // initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/verifyOtp',
      builder: (context, state) => OtpPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
  redirect: (context, state) {
    final String? authToken = GreetStorage.getAuthToken();
    print("i am navigation page token check -> $authToken");

    if ((authToken == null || authToken == "") &&
        state.matchedLocation == '/dashboard') {
      return '/';
    }
    return null;
  },
);
