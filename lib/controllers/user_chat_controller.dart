import 'package:com.rado.quick_mart/controllers/chat_controller.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/models/firebase_services/chat_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserChatController extends GetxController {
  ChatModel args = Get.arguments;
  ChatController chatController = Get.find();
  TextEditingController messageController = TextEditingController();
  RxBool isLoading = RxBool(false);

  void onSendMessage() async {
    isLoading.value = true;
    await ChatService.sendNewMessage(args.key, messageController.text).then(
      (value) {
        messageController.clear();
        isLoading.value = false;
      },
    );
  }
}
