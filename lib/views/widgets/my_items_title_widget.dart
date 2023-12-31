import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyItemsTitleWidget extends StatelessWidget {
  final String title;
  final double? padding;

  const MyItemsTitleWidget(
    this.title, {
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: padding ?? 10.sp,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
