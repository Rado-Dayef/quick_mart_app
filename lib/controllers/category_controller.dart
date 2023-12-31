import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categoryNameFromArgs = Get.arguments;
  Stream<List<PostsModel>> fetchedPostsByCategory = PostServices.fetchPostsByCategoryInStream(Get.arguments);

  void categoryItemOnClick(post) {
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
