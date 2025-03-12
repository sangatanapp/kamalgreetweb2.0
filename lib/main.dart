import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ControllerBinding.dart';
import 'package:kamal_greet_web_2/Utils/values/Language.dart';
import 'package:kamal_greet_web_2/route/routerDelegate.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..indicatorColor = Colors.white
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.black // Set background color to black
    ..textColor = Colors.black
    ..fontSize = 18
    ..userInteractions = true
    ..dismissOnTap = true // This ensures that there is no masking
    ..textStyle = GoogleFonts.poppins(
      // Change text style to Google Font Poppins
      fontSize: 18.0,
      color: Colors.black,
    )
    ..maskType = EasyLoadingMaskType.custom // Use custom mask type
    ..maskColor = Colors.black.withOpacity(0.2)
    ..contentPadding = const EdgeInsets.all(16.0) // Add padding
    ..successWidget =
        const Icon(Icons.check_circle, color: Colors.green, size: 40.0)
    ..errorWidget = const Icon(Icons.error, color: Colors.red, size: 40.0)
    ..infoWidget = const Icon(Icons.info, color: Colors.blue, size: 40.0);
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
