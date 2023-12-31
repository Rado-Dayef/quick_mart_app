import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/splash_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 2.sp,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.sp),
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 690.h,
            width: 360.w,
            child: Center(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        return Lottie.asset(
                          AppStrings.splashJson,
                          animate: controller.animate.value,
                        );
                      },
                    ),
                    Text(
                      AppStrings.appTitle,
                      style: TextStyle(
                        fontSize: 50.sp,
                        color: AppColors.darkBlue,
                        fontFamily: AppStrings.eloraFont,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    MyGapWidget(10.sp),
                    Text(
                      AppStrings.appSubTitle,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.darkBlue,
                        fontFamily: AppStrings.timesFont,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
