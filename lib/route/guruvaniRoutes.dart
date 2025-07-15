import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruViewAndCreation.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniCardCreation.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';

final List<GoRoute> guruvaniRoutes = [
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
];
