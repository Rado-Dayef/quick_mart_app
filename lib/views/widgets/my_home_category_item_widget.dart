import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomeCategoryItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const MyHomeCategoryItemWidget(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50.sp,
            width: 50.sp,
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              border: Border.all(
                color: AppColors.darkBlue,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.darkBlue,
              size: 20.sp,
            ),
          ),
          MyGapWidget(5.sp),
          Text(
            title,
            style: TextStyle(
              color: AppColors.darkBlue,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
