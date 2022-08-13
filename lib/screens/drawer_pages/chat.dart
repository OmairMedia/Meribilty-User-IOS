import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/chat/chatServiceWithGetx.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/widgets/chat/channels.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ChatServiceWithGetx chatService = Get.put(ChatServiceWithGetx());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (chatService.isLoading == true) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Channels(
            client: chatstorage.getItem('chat_client'), channel: chatService.chatData[0], orderArr: chatService.chatData[1],biltiesArr: chatService.chatData[2],);
      }
    });
    // FutureBuilder(
    //     future: chatClient(),
    //     builder: (context, AsyncSnapshot snap) {
    //       if (snap.connectionState == ConnectionState.none &&
    //           snap.hasData == null) {
    //         return Padding(padding: EdgeInsets.only(top: 0));
    //       } else if (snap.hasError) {
    //         return Center(child: Text(snap.error.toString()));
    //       } else if (snap.hasData) {
    //         return StreamChannel(
    //             child: ChannelListPage(), channel: snap.data);
    //       } else {
    //         return Padding(padding: EdgeInsets.only(top: 0));
    //       }
    //     });
  }
}
