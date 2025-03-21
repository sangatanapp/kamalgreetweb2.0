import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kamal_greet_web_2/Utils/EasyLoadingConfiguration.dart';
import 'package:kamal_greet_web_2/Utils/internet/ControllerBinding.dart';
import 'package:kamal_greet_web_2/Utils/values/Language.dart';
import 'package:kamal_greet_web_2/route/routerDelegate.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  easyLoadingConfiguration();
  runApp(const MyApp());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      initialBinding: ControllerBinding(),
      locale: const Locale('en', 'IN'),
      fallbackLocale: const Locale('en', 'IN'),
      builder: EasyLoading.init(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
    );
  }
}
