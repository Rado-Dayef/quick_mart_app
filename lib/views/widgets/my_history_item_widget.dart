import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHistoryItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String location;
  final String time;
  final bool favorite;

  const MyHistoryItemWidget({
    required this.image,
    required this.title,
    required this.price,
    required this.location,
    required this.time,
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
      ),
      child: ListTile(
        onTap: () {
          Fluttertoast.showToast(
            msg: "This item is for display only",
            backgroundColor: AppColors.transparentDarkBlue,
            textColor: AppColors.white,
            fontSize: 14.0,
          );
        },
        title: Text(title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
          side: BorderSide(
            color: AppColors.darkBlue,
          ),
        ),
        subtitle: Text(time),
      ),
    );
  }
}
