import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOfflineWidget extends StatelessWidget {
  const MyOfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyGapWidget(0.sp),
        centerTitle: true,
        title: Text("Offline"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                color: AppColors.darkBlue,
                size: 50.sp,
              ),
              MyGapWidget(10.sp),
              Text(
                "You are offline. Please check your internet connection.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
