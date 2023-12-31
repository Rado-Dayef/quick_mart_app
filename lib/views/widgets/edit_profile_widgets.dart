import 'dart:io';

import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

EditProfileWidgets({
  required imageFile,
  required image,
  required Key formState,
  required RxString name,
  required RxString email,
  required RxString phone,
  required RxString city,
  required RxString area,
  required RxBool isLoading,
  required VoidCallback cancelOnClick,
  required VoidCallback confirmOnClick,
}) {
  return [
    MyGapWidget(10.sp),
    InkWell(
      onTap: () async {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          image.value = imageFile!.path;
        }
      },
      child: CircleAvatar(
        radius: 50.sp,
        backgroundColor: AppColors.darkBlue,
        child: Stack(
          children: [
            Obx(
              () {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(
                    250.sp,
                  ),
                  child: imageFile != null
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: MyCachedNetworkImageWidget(
                            imageUrl: image!.value,
                            placeholderColor: AppColors.white,
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
            ),
          ],
        ),
      ),
    ),
    MyGapWidget(25.sp),
    Form(
      key: formState,
      child: Column(
        children: [
          MyFormFieldWidget(
            initVal: name.value,
            onSaved: (newValue) {
              name.value = newValue!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.nameEmptyText;
              } else if (value.length < 4) {
                return AppStrings.nameLessThen4Validate;
              } else if (value.length > 24) {
                return AppStrings.nameLargerThen24Validate;
              }
              return null;
            },
            prefixIcon: Icon(Icons.person_rounded),
            labelName: AppStrings.userNameText,
            keyboardType: TextInputType.text,
          ),
          MyGapWidget(15.sp),
          MyFormFieldWidget(
            onClick: () {
              Fluttertoast.showToast(
                msg: AppStrings.emailCanNotBeEditedToast,
                backgroundColor: AppColors.transparentDarkBlue,
                textColor: AppColors.white,
                fontSize: 14.sp,
              );
            },
            color: AppColors.grey,
            initVal: email.value,
            readOnly: true,
            prefixIcon: Icon(Icons.email_rounded),
            labelName: AppStrings.emailText,
          ),
          MyGapWidget(15.sp),
          MyFormFieldWidget(
            initVal: phone.value,
            onSaved: (newValue) {
              phone.value = newValue!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.phoneNumberEmptyValidate;
              } else if (value.length <= 15) {
                return AppStrings.badlyFormattedPhoneNumberValidate;
              } else if (value.length >= 17) {
                return AppStrings.badlyFormattedPhoneNumberValidate;
              }
              return null;
            },
            prefixIcon: Icon(Icons.phone_rounded),
            labelName: AppStrings.phoneNumberText,
            keyboardType: TextInputType.text,
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
                  initVal: city.value,
                  onSaved: (newValue) {
                    city.value = newValue!;
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
                  initVal: area.value,
                  onSaved: (newValue) {
                    area.value = newValue!;
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
    MyGapWidget(25.sp),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: cancelOnClick,
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
