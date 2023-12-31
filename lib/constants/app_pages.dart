import 'package:com.rado.quick_mart/views/screens/account_screen.dart';
import 'package:com.rado.quick_mart/views/screens/add_post_screen.dart';
import 'package:com.rado.quick_mart/views/screens/auth/forgot_password_screen.dart';
import 'package:com.rado.quick_mart/views/screens/auth/login_screen.dart';
import 'package:com.rado.quick_mart/views/screens/auth/signup_screen.dart';
import 'package:com.rado.quick_mart/views/screens/category_screen.dart';
import 'package:com.rado.quick_mart/views/screens/chat_screen.dart';
import 'package:com.rado.quick_mart/views/screens/edit_post_screen.dart';
import 'package:com.rado.quick_mart/views/screens/first_post_screen.dart';
import 'package:com.rado.quick_mart/views/screens/home_screen.dart';
import 'package:com.rado.quick_mart/views/screens/library_screen.dart';
import 'package:com.rado.quick_mart/views/screens/nav_bar.dart';
import 'package:com.rado.quick_mart/views/screens/post_screen.dart';
import 'package:com.rado.quick_mart/views/screens/search_screen.dart';
import 'package:com.rado.quick_mart/views/screens/splash_screen.dart';
import 'package:com.rado.quick_mart/views/screens/user_chat_screen.dart';
import 'package:get/get.dart';

import 'app_strings.dart';

class AppPages {
  static List<GetPage> appPages() {
    return [
      GetPage(
        name: AppStrings.forgotPasswordRout,
        page: () => ForgotPasswordScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.categoryRout,
        page: () => CategoryScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.editPostRout,
        page: () => EditPostScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.userChatRout,
        page: () => UserChatScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.addPostRout,
        page: () => AddPostScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.accountRout,
        page: () => AccountScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.libraryRout,
        page: () => LibraryScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.searchRout,
        page: () => SearchScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.signupRout,
        page: () => SignUpScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.splashRout,
        page: () => SplashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.loginRout,
        page: () => LoginScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.homeRout,
        page: () => HomeScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.chatRout,
        page: () => ChatScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.firstPostRout,
        page: () => FirstPostScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.postRout,
        page: () => PostScreen(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
      GetPage(
        name: AppStrings.navBarRout,
        page: () => NavBar(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(
          milliseconds: 250,
        ),
      ),
    ];
  }
}
