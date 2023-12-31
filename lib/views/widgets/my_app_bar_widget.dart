import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBarWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const MyAppBarWidget(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.sp,
      width: 360.w,
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15.sp),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
