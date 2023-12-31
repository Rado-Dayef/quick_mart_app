import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/account_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_app_bar_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_items_title_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountScreen extends GetWidget<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 125.sp,
            ),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                MyItemsTitleWidget(AppStrings.accountSettingText),
                MyListTileWidget(
                  controller.name == AppStrings.emptyText ? controller.emptyData : controller.editProfileBottomSheet,
                  Icons.person_rounded,
                  AppStrings.editProfileText,
                ),
                MyListTileWidget(
                  controller.name == AppStrings.emptyText ? controller.emptyData : controller.changePasswordBottomSheet,
                  Icons.lock_rounded,
                  AppStrings.changePasswordText,
                ),
                MyDividerWidget(
                  10.sp,
                  height: 25.sp,
                ),
                MyItemsTitleWidget(AppStrings.moreText),
                MyListTileWidget(
                  controller.name == AppStrings.emptyText ? controller.emptyData : controller.contactUsBottomSheet,
                  Icons.support_agent,
                  AppStrings.contactUsText,
                ),
                MyListTileWidget(
                  controller.name == AppStrings.emptyText ? controller.emptyData : controller.logoutDialog,
                  Icons.logout_rounded,
                  AppStrings.logoutText,
                ),
                MyListTileWidget(
                  controller.name == AppStrings.emptyText ? controller.emptyData : controller.deleteAccountDialog,
                  Icons.delete_rounded,
                  AppStrings.deleteAccountText,
                ),
                MyGapWidget(10.sp),
              ],
            ),
          ),
          Obx(
            () {
              return MyAppBarWidget(AppStrings.hiText + controller.name.value, AppStrings.accountSubTitleText);
            },
          ),
        ],
      ),
    );
  }
}
