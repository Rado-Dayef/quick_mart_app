import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyErrorIconWidget extends StatelessWidget {
  final double? size;

  const MyErrorIconWidget({
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error_outline_rounded,
        color: AppColors.red,
        size: size ?? 100.sp,
      ),
    );
    ;
  }
}
