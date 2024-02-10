import 'package:get/get.dart';
import 'package:lawer_finder/test.dart';
import 'package:lawer_finder/views/bottom-nav/bottom-nav.dart';
import 'package:lawer_finder/views/login/login-view.dart';
import 'package:lawer_finder/views/registration/registration-view.dart';
import 'package:lawer_finder/views/splash/splash-view.dart';

class AppRoute {
  static const initialRoute = '/';
  static const loginRoute = '/login';
  static const registrationRoute = '/registration';
  static const bottomNavRoute = '/bottomNav';

  static List<GetPage<dynamic>> routes = [
    GetPage(name: initialRoute, page: () => const SpeechToTextPage()),
    GetPage(name: loginRoute, page: () => const LoginPage()),
    GetPage(name: registrationRoute, page: () => const RegistrationPage()),
    GetPage(name: bottomNavRoute, page: () => const BottomNaviApp()),
  ];
}
