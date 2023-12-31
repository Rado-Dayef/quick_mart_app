import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/views/widgets/my_dialog_button_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppDefaults {
  static defaultDialogWithConfirmAndCancel({
    required String title,
    required Widget subTitle,
    required RxBool isLoading,
    required String secondButtonText,
    required VoidCallback secondButtonClick,
  }) {
    Get.defaultDialog(
      backgroundColor: AppColors.white,
      barrierDismissible: false,
      title: title,
      titleStyle: TextStyle(
        color: AppColors.darkBlue,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: EdgeInsets.only(top: 25.sp),
      radius: 15.sp,
      content: Column(
        children: [
          MyGapWidget(10.sp),
          subTitle,
          MyGapWidget(25.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyDialogButtonWidget(
                text: AppStrings.cancelText,
                color: AppColors.darkBlue,
                onTap: () => Get.back(),
              ),
              Obx(
                () => isLoading == false
                    ? MyDialogButtonWidget(
                        text: secondButtonText,
                        color: AppColors.red,
                        onTap: secondButtonClick,
                      )
                    : CircleAvatar(
                        radius: 20.sp,
                        backgroundColor: AppColors.red,
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          child: CircularProgressIndicator(color: AppColors.white),
                        ),
                      ),
              ),
            ],
          ),
          MyGapWidget(10.sp),
        ],
      ),
    );
  }

  static defaultDialogWithOut(title, subTitle, {bool? dismissible}) {
    Get.defaultDialog(
      backgroundColor: AppColors.white,
      barrierDismissible: dismissible ?? true,
      title: title,
      titleStyle: TextStyle(
        color: AppColors.darkBlue,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      titlePadding: EdgeInsets.only(top: 25.sp),
      onWillPop: () async => dismissible ?? true,
      radius: 15.sp,
      content: Column(
        children: [
          MyGapWidget(10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static defaultBottomSheet(List<Widget> widgets, {double? height, bool? isDismissible}) {
    Get.bottomSheet(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.sp)),
      ),
      isDismissible: isDismissible ?? false,
      enterBottomSheetDuration: Duration(milliseconds: 500),
      exitBottomSheetDuration: Duration(milliseconds: 500),
      SizedBox(
        height: height ?? 550.sp,
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () async => isDismissible ?? false,
            child: Center(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(children: widgets),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool?> defaultToast(text) {
    return Fluttertoast.showToast(
      msg: text,
      backgroundColor: AppColors.transparentDarkBlue,
      textColor: AppColors.white,
      fontSize: 14.sp,
    );
  }

  static OutlineInputBorder defaultInputBorder({
    Color? borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.sp),
      borderSide: BorderSide(color: borderColor ?? AppColors.darkBlue),
    );
  }
}
