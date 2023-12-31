import 'package:com.rado.quick_mart/controllers/account_controller.dart';
import 'package:com.rado.quick_mart/controllers/add_post_controller.dart';
import 'package:com.rado.quick_mart/controllers/category_controller.dart';
import 'package:com.rado.quick_mart/controllers/chat_controller.dart';
import 'package:com.rado.quick_mart/controllers/edit_post_controller.dart';
import 'package:com.rado.quick_mart/controllers/first_post_controller.dart';
import 'package:com.rado.quick_mart/controllers/forgot_password_controller.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/controllers/home_search_controller.dart';
import 'package:com.rado.quick_mart/controllers/library_controller.dart';
import 'package:com.rado.quick_mart/controllers/login_controller.dart';
import 'package:com.rado.quick_mart/controllers/nav_bar_controller.dart';
import 'package:com.rado.quick_mart/controllers/post_controller.dart';
import 'package:com.rado.quick_mart/controllers/signup_controller.dart';
import 'package:com.rado.quick_mart/controllers/splash_controller.dart';
import 'package:com.rado.quick_mart/controllers/user_chat_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgotPasswordController(),
      fenix: true,
    );
    Get.lazyPut(
      () => HomeSearchController(),
      fenix: true,
    );
    Get.lazyPut(
      () => CategoryController(),
      fenix: true,
    );
    Get.lazyPut(
      () => UserChatController(),
      fenix: true,
    );
    Get.lazyPut(
      () => EditPostController(),
      fenix: true,
    );
    Get.lazyPut(
      () => LibraryController(),
      fenix: true,
    );
    Get.lazyPut(
      () => AccountController(),
      fenix: true,
    );
    Get.lazyPut(
      () => AddPostController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SignupController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SplashController(),
      fenix: true,
    );
    Get.lazyPut(
      () => NavBarController(),
      fenix: true,
    );
    Get.lazyPut(
      () => LoginController(),
      fenix: true,
    );
    Get.lazyPut(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut(
      () => FirstPostController(),
      fenix: true,
    );
    Get.lazyPut(
      () => PostController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ChatController(),
      fenix: true,
    );
  }
}
