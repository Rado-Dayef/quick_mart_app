import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/library_controller.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPostController extends GetxController {
  PostsModel postFromArgs = Get.arguments;
  LibraryController libraryController = Get.find();
  RxList imageUrls = RxList();
  RxString categoryBHint = AppStrings.emptyText.obs;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RxBool newSelected = RxBool(false);
  RxBool usedSelected = RxBool(false);
  RxBool isDown = RxBool(false);
  final RxString title = AppStrings.emptyText.obs;
  final RxString price = AppStrings.emptyText.obs;
  final RxString description = AppStrings.emptyText.obs;
  final RxString condition = AppStrings.emptyText.obs;
  final RxBool deleteIsLoading = RxBool(false);
  final RxBool isLoading = RxBool(false);

  void passPostValues() {
    imageUrls.value = postFromArgs.imageUrls;
    categoryBHint.value = postFromArgs.category;
    condition.value = postFromArgs.condition;
    postFromArgs.condition == AppStrings.usedText
        ? usedSelected.value = true
        : postFromArgs.condition == AppStrings.newText
            ? newSelected.value = true
            : null;
    title.value = postFromArgs.title;
    price.value = postFromArgs.price;
    description.value = postFromArgs.description;
  }

  void imageOnClick() {
    AppDefaults.defaultToast(AppStrings.imageEditToast);
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

  void deleteOnClick() {
    AppDefaults.defaultDialogWithConfirmAndCancel(
      title: AppStrings.deleteText,
      subTitle: Text(
        AppStrings.deletePostMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 24.sp,
        ),
      ),
      isLoading: deleteIsLoading,
      secondButtonText: AppStrings.deleteText,
      secondButtonClick: () {
        deleteIsLoading.value = true;
        PostServices.deletePost(imageUrls, postFromArgs.key).then(
          (value) {
            Get.back();
            Get.back();
          },
        );
      },
    );
  }

  void updateOnClick() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var myFormsState = formState.currentState;
    if (myFormsState!.validate()) {
      myFormsState.save();
      isLoading.value = true;
      if (categoryBHint.value != AppStrings.emptyText) {
        if (condition.value != AppStrings.emptyText) {
          PostServices.editPost(
            postFromArgs.key,
            categoryBHint.value,
            condition.value,
            title.value,
            price.value,
            description.value,
          ).then(
            (value) {
              Get.back();
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
    }
  }
}
