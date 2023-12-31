import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_fav_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLibraryFavoriteItemWidget extends StatelessWidget {
  final HomeController controller;
  final PostsModel post;

  const MyLibraryFavoriteItemWidget(this.controller, this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          color: AppColors.darkBlue,
        ),
      ),
      child: Stack(
        children: [
          MyCachedNetworkImageWidget(
            borderRadius: BorderRadius.circular(14.sp),
            imageUrl: post.imageUrls[0],
          ),
          MyFavIconWidget(controller, post),
        ],
      ),
    );
  }
}
