import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

List<Widget> ChangePasswordWidgets({
  required Key formState,
  required RxBool isLoading,
  required RxBool isOldPasswordObscure,
  required RxBool isNewPasswordObscure,
  required VoidCallback confirmOnClick,
  required void Function(String?)? oldPasswordOnSaved,
  required void Function(String?)? newPasswordOnSaved,
}) {
  return [
    Text(
      AppStrings.changePasswordText,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.darkBlue,
        fontSize: 24.sp,
      ),
    ),
    MyGapWidget(25.sp),
    Form(
      key: formState,
      child: Column(
        children: [
          Obx(
            () {
              return MyFormFieldWidget(
                onSaved: oldPasswordOnSaved,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.oldPasswordEmptyValidate;
                  } else if (value.length < 8) {
                    return AppStrings.oldPasswordLessThen8Validate;
                  } else if (value.length > 24) {
                    return AppStrings.oldPasswordLargerThen24Validate;
                  }
                  return null;
                },
                obscure: isOldPasswordObscure.value,
                prefixIcon: Icon(Icons.lock_rounded),
                suffixIcon: InkWell(
                  onTap: () => isOldPasswordObscure.value = !isOldPasswordObscure.value,
                  child: Icon(
                    isOldPasswordObscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  ),
                ),
                placeholder: AppStrings.oldPasswordText,
                keyboardType: TextInputType.visiblePassword,
              );
            },
          ),
          MyGapWidget(15.sp),
          Obx(
            () {
              return MyFormFieldWidget(
                onSaved: newPasswordOnSaved,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.newPasswordEmptyValidate;
                  } else if (value.length < 8) {
                    return AppStrings.newPasswordLessThen8Validate;
                  } else if (value.length > 24) {
                    return AppStrings.newPasswordLargerThen24Validate;
                  }
                  return null;
                },
                prefixIcon: Icon(Icons.lock_rounded),
                obscure: isNewPasswordObscure.value,
                suffixIcon: InkWell(
                  onTap: () => isNewPasswordObscure.value = !isNewPasswordObscure.value,
                  child: Icon(
                    isNewPasswordObscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                  ),
                ),
                placeholder: AppStrings.newPasswordText,
                keyboardType: TextInputType.visiblePassword,
              );
            },
          ),
        ],
      ),
    ),
    MyGapWidget(25.sp),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            alignment: Alignment.center,
            height: 40.sp,
            width: 100.sp,
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Text(
              AppStrings.cancelText,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        Obx(
          () => isLoading == false
              ? InkWell(
                  onTap: confirmOnClick,
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.sp,
                    width: 100.sp,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Text(
                      AppStrings.confirmText,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: 20.sp,
                  backgroundColor: AppColors.red,
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                ),
        ),
      ],
    ),
    MyGapWidget(10.sp),
  ];
}
