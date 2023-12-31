import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/forgot_password_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppStrings.authBackgroundImage),
            opacity: 0.2,
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.transparentDarkBlue,
              AppColors.white,
              AppColors.transparentDarkBlue,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Text(
                    AppStrings.forgotPasswordText,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 24.sp,
                    ),
                  ),
                  MyGapWidget(25.sp),
                  Form(
                    key: controller.formState,
                    child: Column(
                      children: [
                        MyFormFieldWidget(
                          onSaved: (value) {
                            controller.emailAddress = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.emailEmptyValidate;
                            } else if (!value.contains(AppStrings.atSignText)) {
                              return AppStrings.emailMessingAtSignValidate;
                            }
                            return null;
                          },
                          obscure: false,
                          prefixIcon: Icon(Icons.email_rounded),
                          labelName: AppStrings.emailAddressText,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  MyGapWidget(15.sp),
                  Obx(
                    () {
                      return controller.isLoading.value
                          ? CircleAvatar(
                              radius: 25.sp,
                              backgroundColor: AppColors.darkBlue,
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: controller.sendButtonOnClick,
                              child: Container(
                                height: 50.h,
                                width: 150.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  AppStrings.sendText,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
