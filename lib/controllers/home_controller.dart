import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Stream<List<PostsModel>> fetchedAds = PostServices.fetchPostsWhereEmailNotEqualToCurrentUserEmailInStream();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
  }

  void searchOnClick() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.toNamed(
      AppStrings.searchRout,
      arguments: searchController.text,
    );
    searchController.text = AppStrings.emptyText;
  }

  void categoryOnClick(arguments) {
    Get.toNamed(
      AppStrings.categoryRout,
      arguments: arguments,
    );
  }

  void favIconOnClick(post) async {
    isLoading.value == true;
    await PostServices.markPostAsFav(post).then((value) => isLoading.value == false);
  }

  void itemOnClick(argument) {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection(AppStrings.postsCollection);
    Get.toNamed(
      AppStrings.firstPostRout,
      arguments: argument,
    )!
        .then(
      (value) => postsCollection.doc(argument.key).set(
        {
          AppStrings.viewField: FieldValue.arrayUnion([AppStrings.currentUserEmail])
        },
        SetOptions(merge: true),
      ),
    );
  }
}
