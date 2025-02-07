import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash_screen_page/bindings/splash_screen_page_binding.dart';
import '../modules/splash_screen_page/views/splash_screen_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN_PAGE,
      page: () => const SplashScreenPageView(),
      binding: SplashScreenPageBinding(),
    ),
  ];
}
