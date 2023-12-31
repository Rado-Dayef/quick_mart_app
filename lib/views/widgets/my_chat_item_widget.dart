import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/chat_controller.dart';
import 'package:com.rado.quick_mart/models/chat_message_model.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/models/firebase_services/chat_services.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MyChatItemWidget extends StatelessWidget {
  final ChatController controller;
  final ChatModel chat;

  const MyChatItemWidget(this.controller, this.chat);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<List<ChatMessageModel>>(
        stream: ChatService.fetchChatRoomMessagesInStream(chat.key),
        builder: (context, snapshot) {
          controller.getReceiverUserData(chat);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppShimmers.chatItemShimmer(1);
          } else if (snapshot.hasError) {
            return MyErrorIconWidget();
          } else {
            List<ChatMessageModel> messages = snapshot.data ?? [];
            if (messages.isNotEmpty) {
              ChatMessageModel lastMessage = messages.first;
              String lastSender = lastMessage.senderEmail == AppStrings.appTitle
                  ? AppStrings.emptyText
                  : lastMessage.senderEmail == AppStrings.currentUserEmail
                      ? AppStrings.youText
                      : controller.receiverName.value + AppStrings.nameMessageSpaceText;
              return ListTile(
                onTap: () {
                  controller.onChatClick(chat);
                  print(lastMessage.key);
                  ChatService.markMessageAsSeen(chat.key, lastMessage);
                },
                leading: CircleAvatar(
                  backgroundColor: AppColors.darkBlue,
                  radius: 25.sp,
                  child: Container(
                    height: 50.sp,
                    width: 50.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.sp),
                      child: MyCachedNetworkImageWidget(
                        imageUrl: controller.receiverImage.value,
                        placeholderColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 225.w,
                          child: Text(
                            controller.receiverName.value,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 225.w,
                          child: Text(
                            lastSender + lastMessage.message,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 32.w,
                          child: Text(
                            DateFormat(AppStrings.timeFormat).format(lastMessage.timestamp.toDate()),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        lastMessage.senderEmail != AppStrings.currentUserEmail && lastMessage.isSeen == false
                            ? CircleAvatar(
                                radius: 8.sp,
                                backgroundColor: AppColors.darkBlue,
                              )
                            : MyGapWidget(0.sp),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text(AppStrings.systemText);
            }
          }
        },
      ),
    );
  }
}
