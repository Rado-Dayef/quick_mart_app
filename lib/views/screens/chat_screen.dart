import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/chat_controller.dart';
import 'package:com.rado.quick_mart/models/chat_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_app_bar_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_chat_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends GetWidget<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 125.sp,
            ),
            child: StreamBuilder<List<ChatModel>>(
              stream: controller.fetchCurrentUserChatRooms,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppShimmers.chatItemShimmer(15);
                } else if (snapshot.hasError) {
                  return MyErrorIconWidget();
                } else {
                  List<ChatModel> chats = snapshot.data ?? [];
                  if (chats.isNotEmpty) {
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: chats.length,
                      itemBuilder: (itemBuilder, index) {
                        ChatModel chat = chats[index];
                        return MyChatItemWidget(controller, chat);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return MyDividerWidget(
                          10.sp,
                          height: 25.sp,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        AppStrings.noChatsYetMessage,
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 24.sp,
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
          MyAppBarWidget(AppStrings.chatRoomsText, AppStrings.chatSubTitleText),
        ],
      ),
    );
  }
}
