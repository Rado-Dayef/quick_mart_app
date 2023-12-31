import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostServices {
  static FirebaseStorage storage = FirebaseStorage.instance;
  static String currentUserEmail = AppStrings.currentUserEmail;
  static const Duration timeoutDuration = Duration(seconds: 15);
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference postsCollection = firestore.collection(AppStrings.postsCollection);
  static Query postsCollectionWhereEmailNotEqual = postsCollection.where(AppStrings.userEmailField, isNotEqualTo: currentUserEmail);

  /// This function to upload new post for the current user.
  static Future<void> uploadPost(userName, userImage, userPhone, images, category, condition, title, price, description) async {
    DocumentReference documentReference = postsCollection.doc();
    List<String> imageUrls = [];
    Random random = Random();

    try {
      /// Upload the image files from the user's phone system.
      for (var image in images) {
        String imageName = DateTime.now().millisecondsSinceEpoch.toString() + AppStrings.underScoreText + random.nextInt(99999).toString();
        Reference storageReference = await storage.ref().child(AppStrings.postsImagesBase + currentUserEmail + AppStrings.backSlashText + imageName + AppStrings.imagesExtensionText);
        UploadTask uploadTask = storageReference.putFile(image, SettableMetadata(contentType: AppStrings.imagesTypeBase));
        await uploadTask.timeout(timeoutDuration);
        TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      /// Upload the post data.
      await documentReference.set(
        {
          AppStrings.userNameField: userName,
          AppStrings.userImageField: userImage,
          AppStrings.userPhoneField: userPhone,
          AppStrings.userEmailField: currentUserEmail,
          AppStrings.timestampField: FieldValue.serverTimestamp(),
          AppStrings.imageUrlsField: imageUrls,
          AppStrings.categoryField: category.toString(),
          AppStrings.conditionField: condition.toString(),
          AppStrings.titleField: title.toString(),
          AppStrings.priceField: price.toString(),
          AppStrings.descriptionField: description.toString(),
          AppStrings.locationField: AppStrings.currentUserAddress,
          AppStrings.favField: [],
          AppStrings.viewField: [],
        },
      );

      AppDefaults.defaultToast(AppStrings.uploadedSuccessfullyText);
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorUploadingToast + e.toString());
    }
  }

  /// This function to edit specific post for the current user.
  static Future<void> editPost(postId, newCategory, newCondition, newTitle, newPrice, newDescription) async {
    DocumentReference postRef = postsCollection.doc(postId);
    try {
      /// Upload the post updates.
      await postRef.update(
        {
          AppStrings.categoryField: newCategory,
          AppStrings.conditionField: newCondition,
          AppStrings.titleField: newTitle,
          AppStrings.priceField: newPrice,
          AppStrings.descriptionField: newDescription,
        },
      ).timeout(timeoutDuration);
      AppDefaults.defaultToast(AppStrings.updatedSuccessfullyToast);
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorUpdatingToast + e.toString());
    }
  }

  /// This function to delete specific post for the current user.
  static deletePost(imageUrls, postId) async {
    try {
      /// Looping on the images by there URLs to remove.
      for (String imageUrl in imageUrls) {
        await storage.refFromURL(imageUrl).delete();
      }

      /// Remove the post data from the posts collection.
      await postsCollection.doc(postId).delete().timeout(timeoutDuration);
      AppDefaults.defaultToast(AppStrings.deletedSuccessfullyToast);
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorDeletingToast + e.toString());
    }
  }

  /// This function to fetch all the current user fav posts.
  static Stream<List<PostsModel>> fetchCurrentUserFavPostsInStream() {
    try {
      return postsCollection.where(AppStrings.favField, arrayContains: currentUserEmail).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> favPosts = querySnapshot.docs.map(
            (DocumentSnapshot document) {
              return PostsModel.fromFirestore(document);
            },
          ).toList();

          return favPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to check if the item is fav for the current user or not.
  static Stream<List<dynamic>> streamCurrentUserFavPosts(String postId) {
    try {
      return postsCollection.where(AppStrings.favField, arrayContains: AppStrings.currentUserEmail).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<dynamic> favArray = [];
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
            List<dynamic>? postFavArray = data?[AppStrings.favField];
            if (postFavArray != null && postFavArray.contains(AppStrings.currentUserEmail)) {
              favArray.add(doc.id);
            }
          }
          return favArray;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch all the current user posts.
  static Stream<List<PostsModel>> fetchCurrentUserPostsInStream() {
    try {
      return postsCollection.where(AppStrings.userEmailField, isEqualTo: currentUserEmail).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> userPosts = querySnapshot.docs.map((DocumentSnapshot document) => PostsModel.fromFirestore(document)).toList();
          return userPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch all posts where email is not equals the current user email.
  static Stream<List<PostsModel>> fetchPostsWhereEmailNotEqualToCurrentUserEmailInStream() {
    try {
      return postsCollectionWhereEmailNotEqual.snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> userPosts = querySnapshot.docs.map((DocumentSnapshot document) => PostsModel.fromFirestore(document)).toList();
          return userPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch posts by Category.
  static Stream<List<PostsModel>> fetchPostsByCategoryInStream(category) {
    try {
      return postsCollectionWhereEmailNotEqual.where(AppStrings.categoryField, isEqualTo: category).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> userPosts = querySnapshot.docs.map((DocumentSnapshot document) => PostsModel.fromFirestore(document)).toList();
          return userPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch related posts based on current post category.
  static Stream<List<PostsModel>> fetchRelatedPostsInStream(PostsModel post) {
    try {
      return postsCollectionWhereEmailNotEqual.where(AppStrings.categoryField, isEqualTo: post.category).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> userPosts = querySnapshot.docs.map((DocumentSnapshot document) => PostsModel.fromFirestore(document)).toList();
          return userPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to fetch posts based on user search and where email is not equal to current user email.
  static Stream<List<PostsModel>> fetchPostsBasedOnUserSearchInStream(String search) {
    try {
      return postsCollection.orderBy(AppStrings.timestampField, descending: true).snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<PostsModel> allPosts = querySnapshot.docs.map(
            (DocumentSnapshot document) {
              return PostsModel.fromFirestore(document);
            },
          ).toList();
          List<PostsModel> searchedPosts = allPosts.where((post) => post.title.toLowerCase().contains(search.toLowerCase()) && post.userEmail != currentUserEmail).toList();
          return searchedPosts;
        },
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
      return Stream.value([]);
    }
  }

  /// This function to mark the post as fav for the user.
  static Future<void> markPostAsFav(PostsModel post) async {
    DocumentSnapshot postDocument = await postsCollection.doc(post.key).get();
    Map<String, dynamic>? data = postDocument.data() as Map<String, dynamic>?;
    List<dynamic>? favArray = data?[AppStrings.favField];
    try {
      /// Uploading the data from fav array.
      await postsCollection.doc(post.key).set(
        {
          AppStrings.favField: favArray!.contains(currentUserEmail) ? FieldValue.arrayRemove([AppStrings.currentUserEmail]) : FieldValue.arrayUnion([AppStrings.currentUserEmail])
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      AppDefaults.defaultToast(AppStrings.errorFetchingToast + e.toString());
    }
  }
}
