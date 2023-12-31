import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_formats.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/firebase_services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignupController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Rx<File?> image = Rx<File?>(null);
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  String? userName, emailAddress, password, phoneNumber, city, area;

  pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  signUpValidator() async {
    FocusManager.instance.primaryFocus?.unfocus();
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      isLoading.value = true;
      var connection = await InternetConnectionChecker().hasConnection;
      if (connection == true) {
        try {
          String? imageUrl = await UserServices().uploadUserImage(emailAddress!, image);
          if (imageUrl != null) {
            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailAddress!,
              password: password!,
            );
            if (userCredential.user!.emailVerified == false) {
              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              await FirebaseAuth.instance.signOut();
              await FirebaseFirestore.instance.collection(AppStrings.usersCollection).doc(emailAddress).set({
                AppStrings.nameField: userName,
                AppStrings.emailField: emailAddress,
                AppStrings.profileImageField: imageUrl,
                AppStrings.phoneNumberField: AppFormats.formatPhoneNumber(phoneNumber),
                AppStrings.cityField: city,
                AppStrings.areaField: area,
                AppStrings.chatRoomIdsField: [],
              });
              await FirebaseFirestore.instance.collection(AppStrings.usersCollection).doc(AppStrings.authUsersDocument).set(
                {
                  AppStrings.emailsField: FieldValue.arrayUnion([emailAddress!])
                },
                SetOptions(merge: true),
              ).then(
                (value) => Get.offAllNamed(AppStrings.loginRout),
              );
            } else {
              return userCredential;
            }
          } else {
            isLoading.value = false;
            AppDefaults.defaultToast(AppStrings.imageFailedUploadingMessage);
          }
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

  void signupButtonOnClick() async {
    UserCredential res = await signUpValidator();
    if (res != null) {
      Get.offAllNamed(AppStrings.splashRout);
    }
  }

  void obscureOnClick() {
    isObscure.value = !isObscure.value;
  }
}
