import 'dart:io';

import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/account_controller.dart';
import 'package:com.rado.quick_mart/controllers/library_controller.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPostController extends GetxController {
  AccountController accountController = Get.find();
  LibraryController libraryController = Get.find();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RxList<File> images = RxList();
  RxBool newSelected = RxBool(false);
  RxBool usedSelected = RxBool(false);
  RxBool isDown = RxBool(false);
  final RxString categoryBHint = AppStrings.emptyText.obs;
  final RxString title = AppStrings.emptyText.obs;
  final RxString price = AppStrings.emptyText.obs;
  final RxString description = AppStrings.emptyText.obs;
  final RxString condition = AppStrings.emptyText.obs;
  final RxBool isLoading = RxBool(false);

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      images.value = pickedFiles
          .map(
            (pickedFile) => File(pickedFile.path),
          )
          .toList();
    }
  }

  void imageOnLongPressed(index) {
    images.removeAt(index);
  }

  void newButtonOnClick() {
    usedSelected.value = false;
    newSelected.value = true;
    condition.value = AppStrings.newText;
  }

  void usedButtonOnClick() {
    usedSelected.value = true;
    newSelected.value = false;
    condition.value = AppStrings.usedText;
  }

  uploadOnClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var myFormsState = formState.currentState;
    if (myFormsState!.validate()) {
      myFormsState.save();
      isLoading.value = true;
      if (images.length > 0) {
        if (categoryBHint.value != AppStrings.emptyText) {
          if (condition.value != AppStrings.emptyText) {
            PostServices.uploadPost(
              accountController.name.value,
              accountController.image.value,
              accountController.phone.value,
              images,
              categoryBHint.value,
              condition.value,
              title,
              price,
              description,
            ).then(
              (value) {
                isLoading.value = false;
                images.value = RxList();
                categoryBHint.value = AppStrings.emptyText;
                condition.value = AppStrings.emptyText;
                newSelected.value = false;
                usedSelected.value = false;
                title.value = AppStrings.emptyText;
                price.value = AppStrings.emptyText;
                description.value = AppStrings.emptyText;
                formState.currentState!.reset();
              },
            );
          } else {
            isLoading.value = false;
            AppDefaults.defaultToast(AppStrings.selectConditionToast);
          }
        } else {
          isLoading.value = false;
          AppDefaults.defaultToast(AppStrings.selectCategoryToast);
        }
      } else {
        isLoading.value = false;
        AppDefaults.defaultToast(AppStrings.uploadImageToast);
      }
    }
  }
}
