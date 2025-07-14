import 'package:kamal_greet_web_2/IosUserData/view/UserDataScreen.dart';
import 'package:kamal_greet_web_2/Payment/view/PaymentScreen.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruViewAndCreation.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniCardCreation.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/login/view/OtpPage.dart';
import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/view/AddDarshanScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaBookingList.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/view/AartiCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/view/ChaleesaCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/view/MantraCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/view/RingtoneCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/view/StotraCreationScreen.dart';

import '../Access/view/AccessScreen.dart';
import '../sanatan/Wallpaper/view/AddWallpaperScreen.dart';
import '../sanatan/pooja/view/PoojaDashboard.dart';

GoRouter router = GoRouter(
  // initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(path: '/verifyOtp', builder: (context, state) => OtpPage()),
    GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen()),

    ///***** Guruvani Routes *****///

    GoRoute(
        path: '/guruvani/dashboard',
        builder: (context, state) => const GuruvaniDashboard()),
    GoRoute(
        path: '/guruvani/dashboard/guru',
        builder: (context, state) => const GuruViewAndCreation()),
    GoRoute(
        path: '/guruvani/dashboard/creation',
        builder: (context, state) => const GuruvaniCardCreation()),

    ///***** Sanatan Routes *****///
    GoRoute(
        path: '/sanatan/dashboard',
        builder: (context, state) => const SanatanDashboardScreen()),
    GoRoute(
        path: '/pooja/dashboard',
        builder: (context, state) => const PoojaDashboard()),
    GoRoute(
        path: '/pooja/booking',
        builder: (context, state) => const PoojaBookingList()),
    GoRoute(
        path: '/sanatan/wallpaper/creation',
        builder: (context, state) => const AddWallpaperScreen()),
    GoRoute(
        path: '/sanatan/darshan/creation',
        builder: (context, state) => const AddDarshanScreen()),
    GoRoute(
        path: '/sanatan/aarti/creation',
        builder: (context, state) => const AartiCreationScreen()),
    GoRoute(
        path: '/sanatan/mantra/creation',
        builder: (context, state) => const AddMantraScreen()),
    GoRoute(
        path: '/sanatan/chaleesa/creation',
        builder: (context, state) => const ChaleesaCreationScreen()),
    GoRoute(
        path: '/sanatan/stotra/creation',
        builder: (context, state) => const StotraCreationScreen()),
    GoRoute(
        path: '/sanatan/ringtone/creation',
        builder: (context, state) => const RingtoneCreationScreen()),
    GoRoute(
        path: '/sanatan/creation',
        builder: (context, state) => const SanatanCreationScreen()),

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
