import 'package:com.rado.quick_mart/models/firebase_services/user_services.dart';
import 'package:com.rado.quick_mart/models/user_model.dart';
import 'package:com.rado.quick_mart/views/screens/account_screen.dart';
import 'package:com.rado.quick_mart/views/screens/add_post_screen.dart';
import 'package:com.rado.quick_mart/views/screens/chat_screen.dart';
import 'package:com.rado.quick_mart/views/screens/home_screen.dart';
import 'package:com.rado.quick_mart/views/screens/library_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  var currentPage = 2.obs;
  Rx<UserModel> user = UserModel().obs;

  void onInit() async {
    getUserData();
    super.onInit();
  }

  final List<Widget> pages = [
    AddPostScreen(),
    LibraryScreen(),
    HomeScreen(),
    ChatScreen(),
    AccountScreen(),
  ];

  getUserData() async {
    List<Map<String, dynamic>> userData = await UserServices.fetchUserData();
    user.value.updateFromMap(userData[0]);
  }

  void onPageTapped(int index) {
    currentPage.value = index;
  }
}
