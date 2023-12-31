import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_fav_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPostItemWidget extends StatelessWidget {
  final HomeController controller;
  final PostsModel post;

  const MyPostItemWidget(this.controller, this.post);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            border: Border.all(
              color: AppColors.darkBlue,
            ),
          ),
          child: Column(
            children: [
              MyCachedNetworkImageWidget(
                imageUrl: post.imageUrls[0],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(13.sp),
                ),
              ),
              Container(
                height: 75.sp,
                width: double.infinity,
                padding: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(13.sp),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      "EGP ${post.price}",
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MyFavIconWidget(controller, post),
      ],
    );
  }
}
