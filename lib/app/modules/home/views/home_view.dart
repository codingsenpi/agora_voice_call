import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.isJoined.value
                    ? 'Connected to Call'
                    : 'Disconnected',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    controller.isJoined.value
                        ? controller.leaveChannel
                        : controller.joinChannel,
                child: Text(
                  controller.isJoined.value ? 'Leave Call' : 'Join Call',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
