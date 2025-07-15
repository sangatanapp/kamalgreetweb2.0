import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/view/AddDarshanScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaBookingList.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/view/AartiCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/view/ChaleesaCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/view/MantraCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/view/RingtoneCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/view/StotraCreationScreen.dart';
import '../sanatan/Wallpaper/view/AddWallpaperScreen.dart';

final List<GoRoute> sanatanRoutes = [
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
];
