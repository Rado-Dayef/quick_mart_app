import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/models/firebase_services/chat_services.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PostController extends GetxController {
  PostsModel postFromArgs = Get.arguments;
  Stream<List<PostsModel>> fetchedRelatedPosts = PostServices.fetchRelatedPostsInStream(Get.arguments);
  RxBool isLoading = RxBool(false);

  void phoneIconOnClick() {
    launch(AppStrings.telText + postFromArgs.userPhone);
  }

  void chatIconOnClick() async {
    isLoading.value = true;
    List<String> ids = [AppStrings.currentUserEmail, postFromArgs.userEmail];
    ids.sort();
    String chatRoomId = ids.join(AppStrings.underScoreText);
    ChatService.createChatRooms(postFromArgs).then(
      (value) async {
        ChatModel? chat = await ChatService.fetchChatRoomById(chatRoomId);
        Get.toNamed(
          AppStrings.userChatRout,
          arguments: chat,
        );
        isLoading.value = false;
      },
    );
  }

  void relatedItemsOnClick(post) {
    Get.offNamed(
      AppStrings.firstPostRout,
      arguments: post,
    );
  }
}
