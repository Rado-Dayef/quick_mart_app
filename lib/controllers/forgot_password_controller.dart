import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_formats.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? emailAddress;
  RxBool isLoading = RxBool(false);

  forgotPasswordValidator() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      isLoading.value = true;
      var connection = await InternetConnectionChecker().hasConnection;
      if (connection == true) {
        try {
          var snapshot = await FirebaseFirestore.instance.collection(AppStrings.usersCollection).where(AppStrings.emailsField, arrayContains: emailAddress!).get();

          if (snapshot.docs.isNotEmpty) {
            await FirebaseAuth.instance.sendPasswordResetEmail(
              email: emailAddress!,
            );
            AppDefaults.defaultToast(AppStrings.emailSentSuccessfullyToast)
                .then(
                  (value) => isLoading.value = false,
                )
                .then(
                  (value) => Get.back(),
                );
          } else {
            isLoading.value = false;
            AppDefaults.defaultToast(AppStrings.yourEmailNotInOurDatabaseToast);
          }
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          AppDefaults.defaultToast(AppFormats.myFormatter(e, AppStrings.spaceText));
        } catch (e) {
          isLoading.value = false;
          AppDefaults.defaultToast(AppFormats.myFormatter(e, AppStrings.spaceText));
        }
      } else {
        isLoading.value = false;
        AppDefaults.defaultToast(AppStrings.connectionErrorToast);
      }
    }
  }

  void sendButtonOnClick() async {
    UserCredential res = await forgotPasswordValidator();
    if (res != null && FirebaseAuth.instance.currentUser!.emailVerified) {
      Get.offAllNamed(AppStrings.splashRout);
    } else {
      isLoading.value = false;
      AppDefaults.defaultToast(AppStrings.verifyEmailFirstToast);
    }
  }
}
