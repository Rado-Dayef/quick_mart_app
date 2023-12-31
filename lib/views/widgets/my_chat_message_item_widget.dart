import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyChatMessageItemWidget extends StatelessWidget {
  final ChatMessageModel message;

  const MyChatMessageItemWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.message == AppStrings.firstChatMessageText
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Text(
                    message.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: message.senderEmail == AppStrings.currentUserEmail ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.sp,
                ),
                child: Container(
                  alignment: message.senderEmail == AppStrings.currentUserEmail ? Alignment.centerRight : Alignment.centerLeft,
                  width: 250.w,
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: message.senderEmail != AppStrings.currentUserEmail ? Radius.circular(0.sp) : Radius.circular(15.sp),
                      topRight: message.senderEmail == AppStrings.currentUserEmail ? Radius.circular(0.sp) : Radius.circular(15.sp),
                      bottomRight: Radius.circular(15.sp),
                      bottomLeft: Radius.circular(15.sp),
                    ),
                  ),
                  padding: EdgeInsets.all(10.sp),
                  child: Text(
                    message.message,
                    textAlign: message.senderEmail == AppStrings.currentUserEmail ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
