import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_shimmers.dart';
import 'package:com.rado.quick_mart/constants/app_strings.dart';
import 'package:com.rado.quick_mart/controllers/home_controller.dart';
import 'package:com.rado.quick_mart/models/posts_model.dart';
import 'package:com.rado.quick_mart/views/widgets/my_app_bar_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_divider_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_error_icon_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_home_category_item_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_items_title_widget.dart';
import 'package:com.rado.quick_mart/views/widgets/my_post_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 125.sp,
            ),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                MyFormFieldWidget(
                  padding: 10.sp,
                  textController: controller.searchController,
                  prefixIcon: InkWell(
                    onTap: controller.searchOnClick,
                    child: Icon(
                      Icons.search_rounded,
                    ),
                  ),
                  placeholder: AppStrings.searchText,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    controller.searchOnClick();
                  },
                ),
                MyGapWidget(10.sp),
                MyItemsTitleWidget(AppStrings.categoriesText),
                SizedBox(
                  height: 105.sp,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: AppStrings.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (itemBuilder, index) {
                      List ls = AppStrings.categories;
                      return InkWell(
                        onTap: () => controller.categoryOnClick(ls[index][AppStrings.titleField]),
                        child: MyHomeCategoryItemWidget(
                          ls[index][AppStrings.titleField],
                          ls[index][AppStrings.iconField],
                        ),
                      );
                    },
                  ),
                ),
                MyDividerWidget(
                  100.sp,
                  height: 25.sp,
                ),
                MyItemsTitleWidget(AppStrings.forYouText),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: StreamBuilder<List<PostsModel>>(
                    stream: controller.fetchedAds,
                    builder: (context, snapshot) {
                      List<PostsModel> posts = snapshot.data ?? [];
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AppShimmers.masonryGridViewShimmer();
                      } else if (snapshot.hasError) {
                        return MyErrorIconWidget();
                      } else if (posts.isNotEmpty) {
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
                              onTap: () => controller.itemOnClick(post),
                              child: MyPostItemWidget(controller, post),
                            );
                          },
                        );
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.noAdsForYouYetMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 24.sp,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          MyAppBarWidget(AppStrings.homeText, AppStrings.homeSubTitleText),
        ],
      ),
    );
  }
}
