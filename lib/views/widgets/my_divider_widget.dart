import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDividerWidget extends StatelessWidget {
  final double? horizontalPadding;
  final double? height;

  const MyDividerWidget(this.horizontalPadding, {this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.darkBlue,
      height: height ?? 50.sp,
      thickness: 0.5.sp,
      indent: horizontalPadding,
      endIndent: horizontalPadding,
    );
  }
}
