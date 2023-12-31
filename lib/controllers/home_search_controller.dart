import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:get/get.dart';

class HomeSearchController extends GetxController {
  final searchFromArgs = Get.arguments;

  void searchedItemOnClick(post) {
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
}
