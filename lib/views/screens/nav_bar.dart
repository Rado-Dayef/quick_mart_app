import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/controllers/nav_bar_controller.dart';
import 'package:com.rado.quick_mart/views/widgets/my_offline_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavBar extends GetWidget<NavBarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: controller.currentPage.value,
          height: 50.sp,
          items: [
            Icon(
              Icons.add_rounded,
              color: AppColors.white,
              size: 24.sp,
            ),
            Icon(
              Icons.my_library_books,
              color: AppColors.white,
              size: 24.sp,
            ),
            Icon(
              Icons.home_rounded,
              color: AppColors.white,
              size: 24.sp,
            ),
            Icon(
              Icons.chat_rounded,
              color: AppColors.white,
              size: 24.sp,
            ),
            Icon(
              Icons.supervisor_account_rounded,
              color: AppColors.white,
              size: 24.sp,
            ),
          ],
          color: AppColors.darkBlue,
          buttonBackgroundColor: AppColors.darkBlue,
          backgroundColor: AppColors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 500),
          onTap: controller.onPageTapped,
          letIndexChange: (index) => true,
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? Obx(
                  () => controller.pages[controller.currentPage.value],
                )
              : MyOfflineWidget();
        },
        child: Center(),
      ),
    );
  }
}
