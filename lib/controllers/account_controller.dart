import 'dart:io';

import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/nav_bar_controller.dart';
import 'package:com.rado.quick_mart/models/firebase_services/user_services.dart';
import 'package:com.rado.quick_mart/views/widgets/change_password_widgets.dart';
import 'package:com.rado.quick_mart/views/widgets/edit_profile_widgets.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
  static NavBarController navBarController = Get.find();
  GlobalKey<FormState> editProfileFormState = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordFormState = GlobalKey<FormState>();
  GlobalKey<FormState> deleteAccountFormState = GlobalKey<FormState>();
  String? body;
  String? subject;
  RxBool isLoading = false.obs;
  RxBool oldPasswordIsObscure = true.obs;
  RxBool newPasswordIsObscure = true.obs;
  RxBool confirmPasswordIsObscure = true.obs;
  RxBool isOldPasswordObscure = RxBool(true);
  RxBool isNewPasswordObscure = RxBool(true);
  RxBool isObscure = RxBool(true);
  String? newPassword;
  String? oldPassword;
  String? password;
  RxString image = navBarController.user.value.profileImage;
  RxString name = navBarController.user.value.name;
  RxString email = navBarController.user.value.email;
  RxString phone = navBarController.user.value.phone;
  RxString city = navBarController.user.value.city;
  RxString area = navBarController.user.value.area;
  final RxList<String> attachments = <String>[].obs;
  final TextEditingController subjectController = TextEditingController(text: "Subject");
  final TextEditingController bodyController = TextEditingController(text: "Body");

  void editProfileBottomSheet() {
    File? imageFile;
    AppDefaults.defaultBottomSheet(
      EditProfileWidgets(
        imageFile: imageFile,
        image: navBarController.user.value.profileImage,
        formState: editProfileFormState,
        name: name,
        email: email,
        phone: phone,
        city: city,
        area: area,
        cancelOnClick: () {
          FocusManager.instance.primaryFocus?.unfocus();
          Get.back();
          isLoading.value = false;
          navBarController.getUserData();
        },
        confirmOnClick: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          var formData = editProfileFormState.currentState;
          if (formData!.validate()) {
            isLoading.value = true;
            formData.save();
            await UserServices.updateUserProfileImage(image.value);
            await UserServices.updateCurrentUserData(name.value, phone.value, city.value, area.value);
            Get.back();
            navBarController.getUserData();
            isLoading.value = false;
          }
        },
        isLoading: isLoading,
      ),
    );
  }

  void changePasswordBottomSheet() {
    AppDefaults.defaultBottomSheet(
      height: 300.sp,
      isDismissible: true,
      ChangePasswordWidgets(
        formState: changePasswordFormState,
        isLoading: isLoading,
        isOldPasswordObscure: isOldPasswordObscure,
        oldPasswordOnSaved: (value) {
          oldPassword = value;
        },
        isNewPasswordObscure: isNewPasswordObscure,
        newPasswordOnSaved: (value) {
          newPassword = value;
        },
        confirmOnClick: () async {
          isLoading.value = true;
          FocusManager.instance.primaryFocus?.unfocus();
          var formData = changePasswordFormState.currentState;
          if (formData!.validate()) {
            formData.save();
            isLoading.value = true;
            await UserServices.changeCurrentUserPassword(oldPassword!, newPassword!, isLoading).then(
              (value) {
                isLoading.value = false;
              },
            );
          } else {
            isLoading.value = false;
          }
        },
      ),
    );
  }

  void contactUsBottomSheet() {
    launch(AppStrings.mailtoText + navBarController.user.value.name.value);
  }

  void logoutDialog() {
    AppDefaults.defaultDialogWithConfirmAndCancel(
      title: AppStrings.logoutText,
      subTitle: Text(
        AppStrings.logoutMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 24.sp,
        ),
      ),
      isLoading: isLoading,
      secondButtonText: AppStrings.logoutText,
      secondButtonClick: () {
        isLoading.value = true;
        FirebaseAuth.instance.signOut().then(
          (value) {
            isLoading.value = false;
            SystemNavigator.pop();
          },
        );
      },
    );
  }

  void deleteAccountDialog() {
    AppDefaults.defaultDialogWithConfirmAndCancel(
      title: AppStrings.deleteText,
      subTitle: Column(
        children: [
          Text(
            AppStrings.deleteAccountMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkBlue,
              fontSize: 24.sp,
            ),
          ),
          MyGapWidget(10.sp),
          Form(
            key: deleteAccountFormState,
            child: Obx(
              () {
                return MyFormFieldWidget(
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.passwordEmptyValidate;
                    } else if (value.length < 8) {
                      return AppStrings.passwordLessThen8Validate;
                    } else if (value.length > 24) {
                      return AppStrings.passwordLargerThen24Validate;
                    }
                    return null;
                  },
                  obscure: isObscure.value,
                  suffixIcon: InkWell(
                    onTap: () => isObscure.value = !isObscure.value,
                    child: Icon(
                      isObscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    ),
                  ),
                  placeholder: AppStrings.confirmPasswordText,
                  keyboardType: TextInputType.visiblePassword,
                );
              },
            ),
          ),
        ],
      ),
      isLoading: isLoading,
      secondButtonText: AppStrings.deleteText,
      secondButtonClick: () async {
        if (deleteAccountFormState.currentState!.validate()) {
          deleteAccountFormState.currentState!.save();
          isLoading.value = true;
          await UserServices.deleteCurrentUserAccount(password.toString());
          isLoading.value = false;
        }
      },
    );
  }

  void emptyData() {
    AppDefaults.defaultToast(AppStrings.connectionErrorToast);
  }
}
