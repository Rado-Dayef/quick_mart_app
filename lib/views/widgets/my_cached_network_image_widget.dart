import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCachedNetworkImageWidget extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Color? placeholderColor;
  final String imageUrl;

  // final BoxFit fit;

  const MyCachedNetworkImageWidget({
    this.borderRadius,
    this.placeholderColor,
    required this.imageUrl,
    // required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(13.sp),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
        errorWidget: (buildContext, object, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: SizedBox(
              width: 325.w,
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.darkBlue,
                size: 50.sp,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return SizedBox(
            height: 100.sp,
            width: 100.sp,
            child: Center(
              child: CircularProgressIndicator(
                color: placeholderColor ?? AppColors.darkBlue,
              ),
            ),
          );
        },
      ),
    );
  }
}
