import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class MyReadMoreTextWidget extends StatelessWidget {
  final String text;
  final double size;
  final int? trimLines;
  final Color? color;
  final TextAlign? textAlign;

  const MyReadMoreTextWidget(this.text, this.size, {this.color, this.trimLines, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ReadMoreText(
        text,
        textAlign: textAlign ?? TextAlign.start,
        trimLines: trimLines ?? 3,
        trimMode: TrimMode.Line,
        trimCollapsedText: AppStrings.showMoreText,
        trimExpandedText: AppStrings.showLessText,
        style: TextStyle(
          color: color ?? AppColors.darkBlue,
          fontSize: size,
        ),
        moreStyle: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        lessStyle: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
