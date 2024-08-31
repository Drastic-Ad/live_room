// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/pages/newpages/giftWidget.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/models/constant_zego.dart';
import 'package:flutter_live_audio_room_zego_cloud/gifts/showGifts.dart';
import 'package:flutter_live_audio_room_zego_cloud/newlivefiles/main.dart';
import 'package:http/http.dart' as http;

// Package imports:
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class LivePage extends StatefulWidget {
  final String roomID;
  final bool isHost;
  final String userName;
  final String userId;

  const LivePage({
    Key? key,
    required this.roomID,
    required this.isHost,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final List<StreamSubscription<dynamic>?> subscriptions = [];
  var animationVisibility = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscriptions
        ..add(ZegoUIKit()
            .getSignalingPlugin()
            .getInRoomTextMessageReceivedEventStream()
            .listen(onInRoomTextMessageReceived))
        ..add(ZegoUIKit()
            .getInRoomCommandReceivedStream()
            .listen(onInRoomCommandReceived));
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (var subscription in subscriptions) {
      subscription?.cancel();
    }
  }

  // If you use a reliable message channel, you need to subscribe to this method.
  void onInRoomTextMessageReceived(
      ZegoSignalingPluginInRoomTextMessageReceivedEvent event) {
    final messages = event.messages;
    debugPrint("onInRoomTextMessageStream:$messages");
    // You can display different animations according to gift type
    var message = messages.first;
    if (message.senderUserID != localUserID) {
      GiftWidget.show(context, "assets/stars.json");
    }
  }

  // If you use an unreliable message channel, you need to subscribe to this method.
  void onInRoomCommandReceived(ZegoInRoomCommandReceivedData commandData) {
    debugPrint(
        "onInRoomCommandReceived, fromUser:${commandData.fromUser}, command:${commandData.command}");
    // You can display different animations according to gift type
    if (commandData.fromUser.id != localUserID) {
      GiftWidget.show(context, "assets/stars.json");
    }
  }

  Future<void> _sendGift() async {
    late http.Response response;
    try {
      response = await http.post(
        Uri.parse(
            'https://zego-example-server-nextjs.vercel.app/api/send_gift'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'app_id': ConstantZegoCloud.appId,
          'server_secret': ConstantZegoCloud().server_secret,
          'room_id': widget.roomID,
          'user_id': localUserID,
          'user_name': 'user_$localUserID',
          'gift_type': 1001,
          'gift_count': 1,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        }),
      );

      if (response.statusCode == 200) {
        // When the gift giver calls the gift interface successfully,
        // the gift animation can start to be displayed
        GiftWidget.show(context, "assets/stars.json");
      }
    } on Exception catch (error) {
      debugPrint("[ERROR], store FCM token exception, ${error.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ZegoUIKitPrebuiltLiveAudioRoom(
            appID: ConstantZegoCloud.appId,
            appSign: ConstantZegoCloud.appSign,
            userID: localUserID,
            userName: 'user_$localUserID',
            roomID: widget.roomID,
            config: (widget.isHost
                ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
                : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience())
              ..userAvatarUrl = 'https://robohash.org/$localUserID.png'
              ..background = background()
              ..seat.takeIndexWhenJoining = widget.isHost ? 0 : -1
              ..bottomMenuBar = ZegoLiveAudioRoomBottomMenuBarConfig(
                  maxCount: 5,
                  audienceExtendButtons: [
                    CircleAvatar(
                      backgroundColor: const Color(0xff1D1D1D),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ShowGift(
                              onSendGift: _sendGift, // Pass the callback
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.card_giftcard,
                          color: Color(0xffB9A588),
                        ),
                      ),
                    )
                  ]),
          ),
        ],
      ),
    );
  }

  Widget background() {
    /// how to replace background view
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.black87
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: Image.asset('assets/images/background.jpeg').image,
              // ),
              ),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: Text(
              'user${localUserID}s room',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: const Color(0xffB9A588),
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            )),
        Positioned(
          top: 10 + 20 + 5,
          left: 10,
          child: Text(
            'ID: ${widget.roomID}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: const Color(0xffB9A588),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
