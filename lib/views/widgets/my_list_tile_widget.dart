import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTileWidget extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  final String title;

  const MyListTileWidget(this.onClick, this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      leading: Icon(
        icon,
        color: AppColors.darkBlue,
        size: 24.sp,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.darkBlue,
              fontSize: 20.sp,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.darkBlue,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
