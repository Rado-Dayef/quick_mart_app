import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onClick;
  final Widget? action;
  final int? num;

  const MyProfileItemWidget({
    required this.icon,
    required this.title,
    required this.onClick,
    this.action,
    this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: onClick,
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.darkBlue,
          ),
          borderRadius: BorderRadius.circular(15.sp),
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.darkBlue,
          radius: 25.sp,
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 24.sp,
              ),
            ),
            action ?? MyGapWidget(0.sp),
          ],
        ),
      ),
    );
  }
}
