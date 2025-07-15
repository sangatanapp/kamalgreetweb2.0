import 'package:kamal_greet_web_2/IosUserData/view/UserDataScreen.dart';
import 'package:kamal_greet_web_2/Payment/view/PaymentScreen.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/route/guruvaniRoutes.dart';
import 'package:kamal_greet_web_2/route/loginRoutes.dart';
import 'package:kamal_greet_web_2/route/postkaroRoutes.dart';
import 'package:kamal_greet_web_2/route/sanatanRoutes.dart';
import '../Access/view/AccessScreen.dart';

GoRouter router = GoRouter(
  // initialLocation: '/dashboard',
  routes: [
    ...guruvaniRoutes,
    ...sanatanRoutes,
    ...loginRoutes,
    ...postkaroRoutes,

    ///***** Ios User Data Routes *****///

    GoRoute(
        path: '/iosuserdata',
        builder: (context, state) => const UserDataScreen()),

    ///***** Access Setting Routes *****///

    GoRoute(path: '/access', builder: (context, state) => const AccessScreen()),

    ///***** Payment Setting Routes *****///

    GoRoute(
        path: '/payment', builder: (context, state) => const PaymentScreen()),
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
