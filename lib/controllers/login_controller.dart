import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_formats.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? emailAddress, password;
  RxBool isObscure = RxBool(true);
  RxBool isLoading = RxBool(false);

  loginValidator() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      isLoading.value = true;
      var connection = await InternetConnectionChecker().hasConnection;
      if (connection == true) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress!,
            password: password!,
          );
          return userCredential;
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          AppDefaults.defaultToast(AppFormats.myFormatter("$e", AppStrings.spaceText));
        } catch (e) {
          isLoading.value = false;
          AppDefaults.defaultToast(AppFormats.myFormatter("$e", AppStrings.spaceText));
        }
      } else {
        isLoading.value = false;
        AppDefaults.defaultToast(AppStrings.connectionErrorToast);
      }
    }
  }

  void loginButtonOnClick() async {
    UserCredential res = await loginValidator();
    if (res != null && FirebaseAuth.instance.currentUser!.emailVerified) {
      Get.offAllNamed(AppStrings.splashRout);
    } else {
      isLoading.value = false;
      AppDefaults.defaultToast(AppStrings.verifyEmailFirstToast);
    }
  }

  void signupOnClick() async {
    Get.toNamed(AppStrings.signupRout);
  }

  void forgotPasswordClick() async {
    Get.toNamed(AppStrings.forgotPasswordRout);
  }

  void obscureOnClick() {
    isObscure.value = !isObscure.value;
  }
}
