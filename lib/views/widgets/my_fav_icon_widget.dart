import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/models/firebase_services/post_services.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyFavIconWidget extends StatelessWidget {
  final HomeController controller;
  final PostsModel post;
  final Color? backColor;
  final Color? color;

  const MyFavIconWidget(this.controller, this.post, {this.backColor, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.sp),
      child: Container(
        height: 30.sp,
        width: 30.sp,
        decoration: BoxDecoration(
          color: backColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(250.sp),
          border: Border.all(
            color: AppColors.darkBlue,
          ),
        ),
        child: InkWell(
          onTap: () => controller.favIconOnClick(post),
          child: StreamBuilder<List<dynamic>?>(
            stream: PostServices.streamCurrentUserFavPosts(post.key),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppShimmers.favIconShimmer();
              } else if (snapshot.hasError) {
                return MyErrorIconWidget(
                  size: 20.sp,
                );
              } else {
                List<dynamic> favDocumentIds = snapshot.data ?? [];
                return Obx(
                  () {
                    return controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: AppColors.darkBlue,
                            strokeAlign: -3,
                          )
                        : Icon(
                            favDocumentIds.contains(post.key) ? Icons.favorite : Icons.favorite_outline,
                            color: color ?? AppColors.darkBlue,
                            size: 20.sp,
                          );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
