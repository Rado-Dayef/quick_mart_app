import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/user_chat_controller.dart';
import 'package:com.rado.quick_mart/models/chat_message_model.dart';
import 'package:com.rado.quick_mart/models/firebase_services/chat_services.dart';
import 'package:com.rado.quick_mart/views/widgets/my_chat_message_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_offline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserChatScreen extends GetWidget<UserChatController> {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected
            ? Scaffold(
                appBar: AppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(15.sp),
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  title: Text(
                    AppStrings.currentUserEmail == controller.args.emails[0] ? controller.args.names[1] : controller.args.names[0],
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                body: StreamBuilder<List<ChatMessageModel>>(
                  stream: ChatService.fetchChatRoomMessagesInStream(controller.args.key),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return AppShimmers.userChatItemsShimmer();
                    } else if (snapshot.hasError) {
                      return MyErrorIconWidget();
                    } else {
                      List<ChatMessageModel> messages = snapshot.data ?? [];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 70.sp,
                        ),
                        child: ListView.separated(
                          itemCount: messages.length,
                          physics: ClampingScrollPhysics(),
                          reverse: true,
                          itemBuilder: (buildContext, index) {
                            ChatMessageModel message = messages[index];
                            return MyChatMessageItemWidget(message);
                          },
                          separatorBuilder: (buildContext, index) {
                            return MyGapWidget(10.sp);
                          },
                        ),
                      );
                    }
                  },
                ),
                bottomSheet: Padding(
                  padding: EdgeInsets.only(bottom: 5.sp),
                  child: Container(
                    height: 60.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 280.sp,
                          alignment: Alignment.center,
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 10,
                            controller: controller.messageController,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.sp,
                            ),
                            cursorColor: AppColors.white,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.darkBlue,
                              labelStyle: TextStyle(
                                color: AppColors.white,
                              ),
                              hintText: "Type Your Message Here",
                              hintStyle: TextStyle(
                                color: AppColors.white,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () {
                            return InkWell(
                              onTap: controller.isLoading.value ? () {} : controller.onSendMessage,
                              child: CircleAvatar(
                                radius: 25.sp,
                                backgroundColor: AppColors.darkBlue,
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeAlign: -2,
                                      )
                                    : Icon(
                                        Icons.send_rounded,
                                        color: AppColors.white,
                                        size: 20.sp,
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : MyOfflineWidget();
      },
      child: Center(),
    );
  }
}
