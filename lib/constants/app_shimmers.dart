import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/models/chat_message_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_chat_message_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmers {
  static Widget masonryGridViewShimmer({bool? withLove}) {
    return MasonryGridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      crossAxisSpacing: 10.sp,
      mainAxisSpacing: 10.sp,
      itemBuilder: (itemBuilder, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.transparentDarkBlue,
          highlightColor: AppColors.darkBlue,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  border: Border.all(
                    color: AppColors.darkBlue,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: Random().nextInt(100) + 50.sp,
                    ),
                    Container(
                      height: 50.sp,
                      width: double.infinity,
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              withLove ?? true
                  ? Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: CircleAvatar(
                        radius: 15.sp,
                      ),
                    )
                  : MyGapWidget(0),
            ],
          ),
        );
      },
    );
  }

  static Widget favIconShimmer({bool? withLove}) {
    return Shimmer.fromColors(
      baseColor: AppColors.transparentDarkBlue,
      highlightColor: AppColors.darkBlue,
      child: CircleAvatar(
        radius: 15.sp,
      ),
    );
  }

  static Widget libraryFavoriteItemShimmer() {
    return SizedBox(
      height: 150.sp,
      child: MasonryGridView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 10.sp,
        itemBuilder: (itemBuilder, index) {
          return Shimmer.fromColors(
            baseColor: AppColors.transparentDarkBlue,
            highlightColor: AppColors.darkBlue,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    border: Border.all(
                      color: AppColors.darkBlue,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140.sp,
                        width: Random().nextInt(250) + 150.sp,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: CircleAvatar(
                    radius: 15.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget userChatItemsShimmer() {
    String chooseRandomString() {
      Random random = Random();
      int randomIndex = random.nextInt(2);
      return (randomIndex == 0) ? AppStrings.currentUserEmail : AppStrings.emptyText;
    }

    return Shimmer.fromColors(
      baseColor: AppColors.transparentDarkBlue,
      highlightColor: AppColors.darkBlue,
      child: Padding(
        padding: EdgeInsets.only(top: 10.sp, bottom: 70.sp),
        child: ListView.separated(
          itemCount: 15,
          physics: ClampingScrollPhysics(),
          reverse: false,
          itemBuilder: (buildContext, index) {
            return MyChatMessageItemWidget(
              ChatMessageModel(
                key: AppStrings.emptyText,
                senderEmail: chooseRandomString(),
                message: AppStrings.emptyText,
                isSeen: false,
                timestamp: Timestamp.now(),
              ),
            );
          },
          separatorBuilder: (buildContext, index) {
            return MyGapWidget(10.sp);
          },
        ),
      ),
    );
  }

  static Widget chatItemShimmer(int count) {
    return Shimmer.fromColors(
      baseColor: AppColors.transparentDarkBlue,
      highlightColor: AppColors.darkBlue,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: (itemBuilder, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25.sp,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.sp,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Container(
                      width: 150.sp,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 25.sp,
                      height: 10.sp,
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    CircleAvatar(
                      radius: 8.sp,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return MyDividerWidget(
            10.sp,
            height: 25.sp,
          );
        },
      ),
    );
  }

  static Widget textShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.transparentDarkBlue,
      highlightColor: AppColors.darkBlue,
      child: Container(
        width: 150.sp,
        height: 10.sp,
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
