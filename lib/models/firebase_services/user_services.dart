import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_formats.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserServices {
  static FirebaseAuth fireauth = FirebaseAuth.instance;
  static String currentUserEmail = AppStrings.currentUserEmail;
  static const Duration timeoutDuration = Duration(seconds: 15);
  static FirebaseStorage fireStorage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection = firestore.collection(AppStrings.usersCollection);
  static CollectionReference postsCollection = firestore.collection(AppStrings.postsCollection);
  static CollectionReference chatRoomsCollection = firestore.collection(AppStrings.chatRoomsCollection);
  static String formattedEmail = AppFormats.myFormatter(AppStrings.currentUserEmail, AppStrings.underScoreText);
  static Query usersCollectionWhereEmailEqualsCurrentUserEmail = usersCollection.where(AppStrings.emailField, isEqualTo: currentUserEmail);
  static Query postsCollectionWhereEmailEqualsCurrentUserEmail = postsCollection.where(AppStrings.userEmailField, isEqualTo: currentUserEmail);
  static Query chatRoomsCollectionWhereEmailEqualsCurrentUserEmail = chatRoomsCollection.where(AppStrings.emailsField, arrayContains: currentUserEmail);

  /// This function to upload the user image for the first time
  Future<String?> uploadUserImage(String emailAddress, Rx<File?> image) async {
    try {
      if (image.value != null) {
        String formattedEmail = AppFormats.myFormatter(emailAddress, AppStrings.underScoreText);
        final storageReference = FirebaseStorage.instance.ref().child(AppStrings.profileImagesBase + AppStrings.backSlashText + formattedEmail + AppStrings.profileImageNameBase);
        final UploadTask uploadTask = storageReference.putFile(
          image.value!,
          SettableMetadata(
            contentType: AppStrings.imagesTypeBase,
          ),
        );
        await uploadTask.whenComplete(() => null);
        return await storageReference.getDownloadURL();
      } else {
        return null;
      }
    } catch (e) {
      print("${AppStrings.errorUploadingImageMessage}$e");
      return null;
    }
  }

  /// This function to fetch all the current user data
  static Future<List<Map<String, dynamic>>> fetchUserData() async {
    try {
      // Fetch the user data by hes email from users collection
      QuerySnapshot querySnapshot = await usersCollectionWhereEmailEqualsCurrentUserEmail.get();
      List<Map<String, dynamic>> data = querySnapshot.docs.map(
        (doc) {
          return doc.data() as Map<String, dynamic>;
        },
      ).toList();
      return data;
    } catch (e) {
      AppDefaults.defaultToast(
        AppStrings.errorFetchingToast + e.toString(),
      );
      return [];
    }
  }

  /// This function to update current user profile image.
  static Future<void> updateUserProfileImage(String newImagePath) async {
    Reference storageReference = fireStorage.ref().child(AppStrings.profileImagesBase + formattedEmail + AppStrings.profileImageNameBase);
    try {
      /// Upload the image file from the user's phone system.
      await storageReference.putFile(
        File(newImagePath),
        SettableMetadata(contentType: AppStrings.imagesTypeBase),
      );

      /// Get the download URL of the uploaded image.
      String downloadURL = await storageReference.getDownloadURL();

      /// Update profileImage field with the download URL from users collection.
      await usersCollectionWhereEmailEqualsCurrentUserEmail.get().then(
        (querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            querySnapshot.docs[0].reference.update({AppStrings.profileImageField: downloadURL});
          }
        },
      );

      /// Update profileImage field with the download URL from posts collection.
      QuerySnapshot postsSnapshot = await postsCollectionWhereEmailEqualsCurrentUserEmail.get();
      if (postsSnapshot.docs.isNotEmpty) {
        WriteBatch postsBatch = FirebaseFirestore.instance.batch();

        for (QueryDocumentSnapshot postDoc in postsSnapshot.docs) {
          postsBatch.update(
            postDoc.reference,
            {AppStrings.userImageField: downloadURL},
          );
        }

        await postsBatch.commit();
      }

      /// Update profileImage field with the download URL from chatRooms collection.
      QuerySnapshot chatRoomsSnapshot = await chatRoomsCollectionWhereEmailEqualsCurrentUserEmail.get();
      if (chatRoomsSnapshot.docs.isNotEmpty) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (QueryDocumentSnapshot chatRoomDoc in chatRoomsSnapshot.docs) {
          List<dynamic> emails = chatRoomDoc[AppStrings.emailsField];
          List<dynamic> images = chatRoomDoc[AppStrings.imagesField];
          int userIndex = emails.indexOf(currentUserEmail);
          if (userIndex != -1 && userIndex < images.length) {
            images[userIndex] = downloadURL;
          }
          batch.update(
            chatRoomDoc.reference,
            {AppStrings.imagesField: images},
          );
        }
        await batch.commit();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// This function to update current user account data.
  static Future<void> updateCurrentUserData(String newName, String newPhone, String newCity, String newArea) async {
    try {
      /// Update user name field from users collection.
      DocumentReference postRef = usersCollection.doc(currentUserEmail);
      await postRef.update(
        {
          AppStrings.nameField: newName,
          AppStrings.phoneNumberField: newPhone,
          AppStrings.cityField: newCity,
          AppStrings.areaField: newArea,
        },
      );

      /// Update user name field from posts collection.
      QuerySnapshot querySnapshot = await postsCollectionWhereEmailEqualsCurrentUserEmail.get();
      if (querySnapshot.docs.isNotEmpty) {
        List<DocumentReference> postRefs = querySnapshot.docs.map((doc) => doc.reference).toList();
        WriteBatch batch = FirebaseFirestore.instance.batch();

        for (DocumentReference postRef in postRefs) {
          batch.update(
            postRef,
            {AppStrings.userNameField: newName},
          );
        }
        await batch.commit();
      }

      /// Update user name field from chatRooms collection.
      QuerySnapshot chatRoomsSnapshot = await chatRoomsCollectionWhereEmailEqualsCurrentUserEmail.get();
      if (chatRoomsSnapshot.docs.isNotEmpty) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        for (QueryDocumentSnapshot chatRoomDoc in chatRoomsSnapshot.docs) {
          List<dynamic> emails = chatRoomDoc[AppStrings.emailsField];
          List<dynamic> names = chatRoomDoc[AppStrings.namesField];
          int userIndex = emails.indexOf(currentUserEmail);
          if (userIndex != -1 && userIndex < names.length) {
            names[userIndex] = newName;
          }
          batch.update(
            chatRoomDoc.reference,
            {AppStrings.namesField: names},
          );
        }
        await batch.commit();
      }
      AppDefaults.defaultToast(AppStrings.updatedSuccessfullyToast);
    } catch (e) {
      AppDefaults.defaultToast(
        AppStrings.errorUpdatingToast + e.toString(),
      );
    }
  }

  /// This function to change current user password.
  static Future<void> changeCurrentUserPassword(String oldPassword, String newPassword, RxBool isLoading) async {
    User? user = fireauth.currentUser;
    try {
      /// Authenticating to make sure that the user is really want to change his password.
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUserEmail,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);

        /// Change user password.
        FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
        Get.back();
        AppDefaults.defaultToast(AppStrings.passwordChanedSuccessfullyToast);
      }
    } catch (e) {
      isLoading.value = false;
      AppDefaults.defaultToast(AppStrings.errorResettingPasswordToast + e.toString());
    }
  }

  /// This function to delete current user account.
  static Future<void> deleteCurrentUserAccount(String password) async {
    User? user = fireauth.currentUser;
    try {
      /// Authenticating to make sure that the user is really want to delete his account.
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUserEmail,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.delete();
      }

      /// Delete user document from users collection.
      await usersCollection.doc(currentUserEmail).delete();

      /// Delete user posts from posts collection.
      QuerySnapshot postsSnapshot = await postsCollectionWhereEmailEqualsCurrentUserEmail.get();
      for (QueryDocumentSnapshot postDocument in postsSnapshot.docs) {
        await postDocument.reference.delete();
      }

      /// Delete user profile image from profileImages folder.
      final profileImage = fireStorage.ref(AppStrings.profileImagesBase).child(formattedEmail + AppStrings.profileImageNameBase);
      await profileImage.delete();

      /// Delete user email from auth user document.
      await FirebaseFirestore.instance.collection(AppStrings.usersCollection).doc(AppStrings.authUsersDocument).set(
        {
          AppStrings.emailsField: FieldValue.arrayRemove([currentUserEmail])
        },
        SetOptions(merge: true),
      );

      /// Delete user posts images from postsImages folder.
      final postsImages = fireStorage.ref().child(AppStrings.postsImagesBase + currentUserEmail);
      ListResult result = await postsImages.listAll();
      for (Reference ref in result.items) {
        ref.delete();
      }
      AppDefaults.defaultToast(AppStrings.accountDeletedSuccessfullyToast).then((value) => SystemNavigator.pop());
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorDeletingAccountToast + e.toString());
    }
  }
}
