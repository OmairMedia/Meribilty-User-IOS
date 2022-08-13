import 'package:get/get.dart';
import 'package:meribiltyapp/Api%20Services/chat/chat_client.dart';

class ChatServiceWithGetx extends GetxController {
  var isLoading = false.obs;
  var chatData = [].obs;
  // @override
  // void onInit() {
  //   fetchChat();
  //   super.onInit();
  // }

  void fetchChat() async {
    try {
      isLoading.value = true;
      var chats = await chatClient();
      if (chats != null) {
        chatData.value = chats;
        print(chatData);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
