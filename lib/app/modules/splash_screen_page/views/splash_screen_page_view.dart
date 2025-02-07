import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_page_controller.dart';

class SplashScreenPageView extends GetView<SplashScreenPageController> {
  const SplashScreenPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const Center(child: CircularProgressIndicator()));
  }
}
