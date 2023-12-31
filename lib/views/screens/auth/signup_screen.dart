import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/signup_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetWidget<SignupController> {
  const SignUpScreen({super.key});

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
            child: Column(
              children: [
                Text(
                  AppStrings.signupText,
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 24.sp,
                  ),
                ),
                MyGapWidget(25.sp),
                InkWell(
                  onTap: controller.pickImage,
                  child: CircleAvatar(
                    radius: 50.sp,
                    child: Stack(
                      children: [
                        Obx(
                          () {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(250.sp),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlue,
                                ),
                                child: controller.image.value != null
                                    ? Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Image.file(
                                          controller.image.value!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.person_rounded,
                                        color: AppColors.white,
                                        size: 50.sp,
                                      ),
                              ),
                            );
                          },
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(),
                          child: CircleAvatar(
                            radius: 15.sp,
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.darkBlue,
                              size: 20.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                MyGapWidget(15.sp),
                Form(
                  key: controller.formState,
                  child: Column(
                    children: [
                      MyFormFieldWidget(
                        onSaved: (value) {
                          controller.userName = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.nameEmptyText;
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person_rounded),
                        labelName: AppStrings.userNameText,
                        keyboardType: TextInputType.text,
                      ),
                      MyGapWidget(15.sp),
                      MyFormFieldWidget(
                        onSaved: (value) {
                          controller.emailAddress = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.emailEmptyValidate;
                          } else if (!value.contains(AppStrings.atSignText)) {
                            return AppStrings.emailMessingAtSignValidate;
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.email_rounded),
                        labelName: AppStrings.emailAddressText,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      MyGapWidget(15.sp),
                      Obx(
                        () {
                          return MyFormFieldWidget(
                            onSaved: (value) {
                              controller.password = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.passwordEmptyValidate;
                              } else if (value.length < 8) {
                                return AppStrings.passwordLessThen8Validate;
                              } else if (value.length > 24) {
                                return AppStrings.passwordLargerThen24Validate;
                              }
                              return null;
                            },
                            obscure: controller.isObscure.value,
                            prefixIcon: Icon(Icons.lock_rounded),
                            suffixIcon: InkWell(
                              onTap: controller.obscureOnClick,
                              child: Icon(
                                controller.isObscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              ),
                            ),
                            labelName: AppStrings.passwordText,
                            keyboardType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      MyGapWidget(15.sp),
                      MyFormFieldWidget(
                        onSaved: (value) {
                          controller.phoneNumber = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.phoneNumberEmptyValidate;
                          } else if (value[0] != AppStrings.numberZeroText) {
                            return AppStrings.phoneNumberBadlyFormattedValidate;
                          } else if (value[1] != AppStrings.numberOneText) {
                            return AppStrings.phoneNumberBadlyFormattedValidate;
                          } else if (value.length <= 10) {
                            return AppStrings.invalidPhoneNumberValidate;
                          } else if (value.length >= 12) {
                            return AppStrings.invalidPhoneNumberValidate;
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.phone_rounded),
                        labelName: AppStrings.phoneNumberText,
                        keyboardType: TextInputType.phone,
                      ),
                      MyGapWidget(15.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 180.w,
                            padding: EdgeInsets.only(
                              left: 15.sp,
                              right: 5.sp,
                            ),
                            child: MyFormFieldWidget(
                              padding: 0.sp,
                              onSaved: (value) {
                                controller.city = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.cityEmptyValidate;
                                }
                                return null;
                              },
                              labelName: AppStrings.cityText,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Container(
                            width: 180.w,
                            padding: EdgeInsets.only(
                              left: 5.sp,
                              right: 15.sp,
                            ),
                            child: MyFormFieldWidget(
                              padding: 0.sp,
                              onSaved: (value) {
                                controller.area = value!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.areaEmptyValidate;
                                }
                                return null;
                              },
                              labelName: AppStrings.areaText,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MyGapWidget(15.sp),
                Obx(
                  () {
                    return controller.isLoading.value == false
                        ? InkWell(
                            onTap: controller.signupButtonOnClick,
                            child: Container(
                              height: 50.h,
                              width: 150.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                AppStrings.signupText,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 25.sp,
                            backgroundColor: AppColors.darkBlue,
                            child: Container(
                              padding: EdgeInsets.all(10.sp),
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                              ),
                            ),
                          );
                  },
                ),
                MyGapWidget(5.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAnAccountText,
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontSize: 15.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        AppStrings.loginButtonText,
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
