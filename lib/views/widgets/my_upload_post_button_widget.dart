import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyUploadPostButtonWidget extends StatelessWidget {
  final VoidCallback onClick;
  final RxBool selected;
  final String title;

  const MyUploadPostButtonWidget({
    required this.selected,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return InkWell(
          onTap: onClick,
          child: Container(
            height: 35.sp,
            width: 70.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected.value == false ? AppColors.white : AppColors.darkBlue,
              borderRadius: BorderRadius.circular(15.sp),
              border: Border.all(
                color: selected.value == false ? AppColors.darkBlue : AppColors.white,
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: selected.value == false ? AppColors.darkBlue : AppColors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
