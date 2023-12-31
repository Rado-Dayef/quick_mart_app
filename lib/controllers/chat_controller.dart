import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/models/firebase_services/chat_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Stream<List<ChatModel>> fetchCurrentUserChatRooms = ChatService.fetchCurrentUserChatRoomsInStream();
  RxString receiverImage = AppStrings.emptyText.obs;
  RxString receiverName = AppStrings.emptyText.obs;
  RxString receiverEmail = AppStrings.emptyText.obs;

  void onChatClick(arguments) {
    Get.toNamed(
      AppStrings.userChatRout,
      arguments: arguments,
    );
  }

  getReceiverUserData(ChatModel chat) {
    if (AppStrings.currentUserEmail == chat.emails[0]) {
      receiverImage.value = chat.images[1];
      receiverName.value = chat.names[1];
      receiverEmail.value = chat.emails[1];
    } else {
      receiverImage.value = chat.images[0];
      receiverName.value = chat.names[0];
      receiverEmail.value = chat.emails[0];
    }
  }
}
