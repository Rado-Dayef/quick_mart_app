import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LibraryController extends GetxController {
  Stream<List<PostsModel>> fetchedCurrentUserPosts = PostServices.fetchCurrentUserPostsInStream();
  Stream<List<PostsModel>> fetchedCurrentUserFavPosts = PostServices.fetchCurrentUserFavPostsInStream();
  RxList<PostsModel> favItems = RxList<PostsModel>();
  HomeController homeController = Get.find();
  RxBool isEmptyPostsData = RxBool(false);
  RxBool isEmptyFavData = RxBool(false);
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RxList<File> images = RxList();
  RxBool newSelected = RxBool(false);
  RxBool usedSelected = RxBool(false);
  final RxString categoryBHint = AppStrings.emptyText.obs;
  final RxString title = AppStrings.emptyText.obs;
  final RxString price = AppStrings.emptyText.obs;
  final RxString description = AppStrings.emptyText.obs;
  final RxString condition = AppStrings.emptyText.obs;
  final RxBool isLoading = RxBool(false);
  final List<String> categories = [
    AppStrings.vehiclesText,
    AppStrings.propertiesText,
    AppStrings.electronicsText,
    AppStrings.fashionText,
    AppStrings.furnitureText,
    AppStrings.healthText,
    AppStrings.beautyText,
    AppStrings.sportsText,
    AppStrings.jewelryText,
    AppStrings.otherText,
  ];

  void favIconOnClick(PostsModel post) async {
    DocumentSnapshot postDocument = await FirebaseFirestore.instance.collection(AppStrings.postsCollection).doc(post.key).get();
    Map<String, dynamic>? data = postDocument.data() as Map<String, dynamic>?;
    List<dynamic>? favArray = data?["fav"];
    await FirebaseFirestore.instance.collection(AppStrings.postsCollection).doc(post.key).set(
      {
        "fav": favArray!.contains(AppStrings.currentUserEmail) ? FieldValue.arrayRemove([AppStrings.currentUserEmail]) : FieldValue.arrayUnion([AppStrings.currentUserEmail])
      },
      SetOptions(merge: true),
    );
  }

  void favItemOnClick(post) {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection(AppStrings.postsCollection);
    Get.toNamed(
      AppStrings.firstPostRout,
      arguments: post,
    )!
        .then(
      (value) => postsCollection.doc(post.key).set(
        {
          AppStrings.viewField: FieldValue.arrayUnion([AppStrings.currentUserEmail])
        },
        SetOptions(merge: true),
      ),
    );
  }

  void postsItemOnClick(post) {
    Get.toNamed(
      AppStrings.editPostRout,
      arguments: post,
    );
  }
}
