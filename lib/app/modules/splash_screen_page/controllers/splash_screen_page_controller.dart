import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testproj/app/routes/app_pages.dart';

class SplashScreenPageController extends GetxController {
  RxBool isCheckingPermission = false.obs;

  @override
  void onReady() {
    super.onReady();
    checkMicPermission();
  }

  /// Checks for microphone permission and navigates accordingly
  Future<void> checkMicPermission() async {
    isCheckingPermission.value = true;

    PermissionStatus status = await Permission.microphone.status;

    if (status.isGranted) {
      goToHomeScreen();
    } else {
      requestMicPermission();
    }

    isCheckingPermission.value = false;
  }

  /// Requests microphone permission and handles responses
  Future<void> requestMicPermission() async {
    PermissionStatus status = await Permission.microphone.request();

    if (status.isGranted) {
      goToHomeScreen();
    } else if (status.isDenied) {
      // Show retry option
      showRetryDialog();
    } else if (status.isPermanentlyDenied) {
      // Guide user to app settings
      showSettingsDialog();
    }
  }

  /// Navigates to the home screen
  void goToHomeScreen() {
    Get.offNamed(Routes.HOME);
  }

  void showRetryDialog() {
    Get.defaultDialog(
      title: "Permission Required",
      middleText: "Microphone access is needed to continue.",
      textConfirm: "Retry",
      textCancel: "Exit",
      onConfirm: () {
        Get.back(); 
        requestMicPermission(); 
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  void showSettingsDialog() {
    Get.defaultDialog(
      title: "Permission Required",
      middleText:
          "Microphone access is permanently denied. Please enable it in settings.",
      textConfirm: "Open Settings",
      textCancel: "Exit",
      onConfirm: () {
        openAppSettings();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
