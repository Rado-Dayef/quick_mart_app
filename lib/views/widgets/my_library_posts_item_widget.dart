import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLibraryPostsItemWidget extends StatelessWidget {
  final PostsModel post;

  const MyLibraryPostsItemWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          color: AppColors.darkBlue,
        ),
      ),
      child: Column(
        children: [
          MyCachedNetworkImageWidget(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14.sp),
            ),
            imageUrl: post.imageUrls[0],
          ),
          Container(
            height: 50.sp,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(13.sp),
              ),
              border: Border.all(
                color: AppColors.darkBlue,
                width: 2.sp,
              ),
            ),
            child: Text(
              post.title,
              maxLines: 2,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
