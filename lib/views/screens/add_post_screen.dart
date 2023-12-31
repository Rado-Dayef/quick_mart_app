import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/add_post_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_app_bar_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_dropdown_button_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_upload_post_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class AddPostScreen extends GetWidget<AddPostController> {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 125.sp),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                Form(
                  key: controller.formState,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.imagesText,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyGapWidget(15.sp),
                        Obx(
                          () {
                            return MasonryGridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.images.length,
                              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              crossAxisSpacing: 10.sp,
                              mainAxisSpacing: 10.sp,
                              itemBuilder: (itemBuilder, index) {
                                return InkWell(
                                  onLongPress: () => controller.imageOnLongPressed(index),
                                  child: Obx(
                                    () {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        child: Image.file(
                                          controller.images[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Obx(
                          () {
                            return controller.images.length == 0 ? MyGapWidget(0) : MyGapWidget(15.sp);
                          },
                        ),
                        Obx(
                          () {
                            return Center(
                              child: controller.images.length == 0
                                  ? InkWell(
                                      onTap: controller.pickImages,
                                      child: Container(
                                        height: 150.sp,
                                        width: 150.sp,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBlue,
                                          borderRadius: BorderRadius.circular(15.sp),
                                        ),
                                        child: Icon(
                                          Icons.camera_rounded,
                                          color: AppColors.white,
                                          size: 50.sp,
                                        ),
                                      ),
                                    )
                                  : MyGapWidget(0),
                            );
                          },
                        ),
                        MyDividerWidget(50.sp),
                        Text(
                          AppStrings.categoryText,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyGapWidget(15.sp),
                        MyDropdownButtonWidget(
                          updatedTitle: controller.categoryBHint,
                          title: AppStrings.selectCategoryText,
                          items: AppStrings.categoriesList,
                        ),
                        MyDividerWidget(50.sp),
                        Text(
                          AppStrings.conditionText,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyGapWidget(15.sp),
                        Wrap(
                          spacing: 8.sp,
                          runSpacing: 4.sp,
                          children: [
                            MyUploadPostButtonWidget(
                              onClick: controller.newButtonOnClick,
                              selected: controller.newSelected,
                              title: AppStrings.newText,
                            ),
                            MyUploadPostButtonWidget(
                              onClick: controller.usedButtonOnClick,
                              selected: controller.usedSelected,
                              title: AppStrings.usedText,
                            ),
                          ],
                        ),
                        MyDividerWidget(50.sp),
                        Text(
                          AppStrings.infoText,
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyGapWidget(15.sp),
                        MyFormFieldWidget(
                          onSaved: (value) {
                            controller.title.value = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.titleEmptyValidate;
                            }
                            return null;
                          },
                          padding: 0.sp,
                          keyboardType: TextInputType.text,
                          labelName: AppStrings.titleText,
                          placeholder: AppStrings.titlePlaceholder,
                        ),
                        MyGapWidget(25.sp),
                        MyFormFieldWidget(
                          onSaved: (value) {
                            controller.price.value = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.priceEmptyValidate;
                            }
                            return null;
                          },
                          padding: 0.sp,
                          keyboardType: TextInputType.number,
                          labelName: AppStrings.priceText,
                          placeholder: AppStrings.pricePlaceholder,
                        ),
                        MyGapWidget(25.sp),
                        MyFormFieldWidget(
                          maxLines: 10,
                          onSaved: (value) {
                            controller.description.value = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.descriptionEmptyValidate;
                            }
                            return null;
                          },
                          padding: 0.sp,
                          keyboardType: TextInputType.text,
                          labelName: AppStrings.descriptionText,
                          placeholder: AppStrings.descriptionPlaceholder,
                        ),
                        MyGapWidget(25.sp),
                        Center(
                          child: Obx(
                            () {
                              return controller.isLoading.value == false
                                  ? InkWell(
                                      onTap: controller.uploadOnClick,
                                      child: Container(
                                        height: 50.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBlue,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          AppStrings.uploadText,
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
                        ),
                        MyGapWidget(15.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          MyAppBarWidget(AppStrings.addPostText, AppStrings.addPostSubTitleText),
        ],
      ),
    );
  }
}
