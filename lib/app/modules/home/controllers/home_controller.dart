import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class HomeController extends GetxController {
  final String appId = "appId";
  final String channelName = "test_room";
  final String token = "token";

  RxBool isJoined = false.obs;
  late RtcEngine agoraEngine;

  @override
  void onInit() {
    super.onInit();
    initializeAgora();
  }

  /// Initialize Agora SDK
  Future<void> initializeAgora() async {
    await [Permission.microphone].request();

    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(RtcEngineContext(appId: appId));

    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("Remote user joined: $remoteUid");
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          isJoined.value = false;
        },
      ),
    );
  }

  /// Join the Agora channel
  Future<void> joinChannel() async {
    await agoraEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      uid: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      options: const ChannelMediaOptions(
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    await agoraEngine.setEnableSpeakerphone(true);
  }

  /// Leave the Agora channel
  Future<void> leaveChannel() async {
    await agoraEngine.leaveChannel();
  }
}
