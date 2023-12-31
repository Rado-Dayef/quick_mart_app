import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/edit_post_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_dropdown_button_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_offline_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_upload_post_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class EditPostScreen extends GetWidget<EditPostController> {
  const EditPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.passPostValues();
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected
            ? Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  title: Text(
                    controller.title.value,
                  ),
                  actions: [
                    IconButton(
                      onPressed: controller.deleteOnClick,
                      icon: Icon(
                        Icons.delete_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                body: ListView(
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
                            MyGapWidget(15.sp),
                            Text(
                              AppStrings.imagesText,
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            MyGapWidget(15.sp),
                            MasonryGridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.imageUrls.length,
                              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              crossAxisSpacing: 10.sp,
                              mainAxisSpacing: 10.sp,
                              itemBuilder: (itemBuilder, index) {
                                return InkWell(
                                  onTap: controller.imageOnClick,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.sp),
                                    child: MyCachedNetworkImageWidget(
                                      imageUrl: controller.imageUrls[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                            MyGapWidget(15.sp),
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
                              title: controller.categoryBHint.value,
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
                              initVal: controller.title.value,
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
                              initVal: controller.price.value,
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
                              initVal: controller.description.value,
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
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Obx(
                        () {
                          return controller.isLoading.value == false
                              ? InkWell(
                                  onTap: controller.updateOnClick,
                                  child: Container(
                                    height: 50.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.darkBlue,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      AppStrings.updateText,
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
                    MyGapWidget(50.sp),
                  ],
                ),
                bottomSheet: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.sp,
                    horizontal: 25.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.sp),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                          MyGapWidget(10.sp),
                          Text(
                            controller.postFromArgs.fav.length.toString(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_rounded,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                          MyGapWidget(10.sp),
                          Text(
                            controller.postFromArgs.view.length.toString(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : MyOfflineWidget();
      },
      child: Center(),
    );
  }
}
