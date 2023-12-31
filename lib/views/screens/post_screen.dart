import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/controllers/post_controller.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/screens/image_screen.dart';
import 'package:com.rado.quick_mart/views/widgets/my_cached_network_image_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_fav_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_items_title_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_offline_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_post_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_read_more_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostScreen extends GetWidget<PostController> {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected
            ? Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  title: Text(
                    controller.postFromArgs.title,
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                      ),
                      child: Column(
                        children: [
                          MyGapWidget(10.sp),
                          MasonryGridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.postFromArgs.imageUrls.length,
                            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: controller.postFromArgs.imageUrls.length < 2 ? 1 : 2,
                            ),
                            crossAxisSpacing: 10.sp,
                            mainAxisSpacing: 10.sp,
                            itemBuilder: (itemBuilder, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    ImageScreen(controller.postFromArgs.imageUrls, index),
                                    transition: Transition.fadeIn,
                                    duration: Duration(
                                      milliseconds: 250,
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: controller.postFromArgs.imageUrls[index],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.darkBlue,
                                      ),
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                    child: MyCachedNetworkImageWidget(
                                      imageUrl: controller.postFromArgs.imageUrls[index],
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          MyGapWidget(25.sp),
                          Text(
                            controller.postFromArgs.title,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyGapWidget(15.sp),
                          Container(
                            height: 50.sp,
                            padding: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "EGP ${controller.postFromArgs.price}",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                MyFavIconWidget(
                                  homeController,
                                  controller.postFromArgs,
                                  backColor: AppColors.darkBlue,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                          MyGapWidget(15.sp),
                          Text(
                            DateFormat(AppStrings.dateFormat).format(controller.postFromArgs.timestamp.toDate()),
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 20.sp,
                            ),
                          ),
                          MyGapWidget(15.sp),
                          Row(
                            children: [
                              MyItemsTitleWidget(
                                AppStrings.conditionTitleText,
                                padding: 0.sp,
                              ),
                              Text(
                                controller.postFromArgs.condition,
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          MyGapWidget(15.sp),
                          Row(
                            children: [
                              MyItemsTitleWidget(
                                AppStrings.categoryTitleText,
                                padding: 0.sp,
                              ),
                              Text(
                                controller.postFromArgs.category,
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          MyGapWidget(15.sp),
                          MyItemsTitleWidget(
                            AppStrings.descriptionTitleText,
                            padding: 0.sp,
                          ),
                          MyGapWidget(5.sp),
                          MyReadMoreTextWidget(controller.postFromArgs.description, 20.sp),
                          MyGapWidget(15.sp),
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                              side: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.darkBlue,
                              radius: 20.sp,
                              child: Container(
                                height: 40.sp,
                                width: 40.sp,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.sp),
                                  child: MyCachedNetworkImageWidget(
                                    imageUrl: controller.postFromArgs.userImage,
                                    placeholderColor: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.postFromArgs.userName,
                                      style: TextStyle(
                                        color: AppColors.darkBlue,
                                      ),
                                    ),
                                    Text(
                                      controller.postFromArgs.userPhone,
                                      style: TextStyle(
                                        color: AppColors.transparentDarkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: controller.phoneIconOnClick,
                                      icon: Icon(
                                        Icons.phone_rounded,
                                        color: AppColors.transparentDarkBlue,
                                      ),
                                    ),
                                    MyGapWidget(10.sp),
                                    Obx(
                                      () {
                                        return controller.isLoading.value
                                            ? CircularProgressIndicator(
                                                color: AppColors.transparentDarkBlue,
                                                strokeAlign: -3,
                                              )
                                            : IconButton(
                                                onPressed: controller.chatIconOnClick,
                                                icon: Icon(
                                                  Icons.chat_rounded,
                                                  color: AppColors.transparentDarkBlue,
                                                ),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          MyDividerWidget(0.sp),
                          MyItemsTitleWidget(
                            AppStrings.relatedAdsText,
                            padding: 0.sp,
                          ),
                          MyGapWidget(10.sp),
                          StreamBuilder<List<PostsModel>>(
                            stream: controller.fetchedRelatedPosts,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return AppShimmers.masonryGridViewShimmer();
                              } else if (snapshot.hasError) {
                                return MyErrorIconWidget();
                              } else {
                                List<PostsModel> posts = snapshot.data ?? [];
                                if (posts.isNotEmpty) {
                                  return MasonryGridView.builder(
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
                                        onTap: () => controller.postFromArgs.key == post.key ? AppDefaults.defaultToast(AppStrings.itemAlreadyOpenedToast) : controller.relatedItemsOnClick(post),
                                        child: MyPostItemWidget(homeController, post),
                                      );
                                    },
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
                          MyGapWidget(10.sp),
                        ],
                      ),
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
