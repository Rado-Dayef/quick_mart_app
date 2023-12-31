import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/controllers/library_controller.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_app_bar_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_items_title_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_library_favorite_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_library_posts_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class LibraryScreen extends GetWidget<LibraryController> {
  const LibraryScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 125.sp,
              right: 10.sp,
              left: 10.sp,
            ),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                MyItemsTitleWidget(
                  AppStrings.favoriteText,
                  padding: 0.sp,
                ),
                MyGapWidget(5.sp),
                StreamBuilder<List<PostsModel>>(
                  stream: controller.fetchedCurrentUserFavPosts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return AppShimmers.libraryFavoriteItemShimmer();
                    } else if (snapshot.hasError) {
                      return MyErrorIconWidget();
                    } else {
                      List<PostsModel> posts = snapshot.data ?? [];
                      if (posts.isNotEmpty) {
                        return SizedBox(
                          height: 150.sp,
                          child: MasonryGridView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: posts.length >= 20 ? 20 : posts.length,
                            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            crossAxisSpacing: 10.sp,
                            mainAxisSpacing: 10.sp,
                            itemBuilder: (itemBuilder, index) {
                              PostsModel post = posts[index];
                              return InkWell(
                                onTap: () => controller.favItemOnClick(post),
                                child: MyLibraryFavoriteItemWidget(homeController, post),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.noFavPostsYetMessage,
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
                MyDividerWidget(
                  10.sp,
                  height: 25.sp,
                ),
                MyItemsTitleWidget(
                  AppStrings.adsText,
                  padding: 0.sp,
                ),
                MyGapWidget(5.sp),
                StreamBuilder<List<PostsModel>>(
                  stream: controller.fetchedCurrentUserPosts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return AppShimmers.masonryGridViewShimmer(withLove: false);
                    } else if (snapshot.hasError) {
                      return MyErrorIconWidget();
                    } else {
                      List<PostsModel> posts = snapshot.data ?? [];
                      if (posts.isNotEmpty) {
                        return MasonryGridView.builder(
                          cacheExtent: 0.3,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: posts.length >= 20 ? 20 : posts.length,
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          crossAxisSpacing: 10.sp,
                          mainAxisSpacing: 10.sp,
                          itemBuilder: (itemBuilder, index) {
                            PostsModel post = posts[index];
                            return InkWell(
                              onTap: () => controller.postsItemOnClick(post),
                              child: MyLibraryPostsItemWidget(post),
                            );
                          },
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.noAdsYetMessage,
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
                MyGapWidget(10.sp),
              ],
            ),
          ),
          MyAppBarWidget(AppStrings.libraryText, AppStrings.librarySubTitleText),
        ],
      ),
    );
  }
}
