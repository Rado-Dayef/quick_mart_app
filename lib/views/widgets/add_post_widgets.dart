// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:quick_mart/constants/app_colors.dart';
// import 'package:quick_mart/constants/app_strings.dart';
// import 'package:quick_mart/views/widgets/my_dropdown_button_widget.dart';
// import 'package:quick_mart/views/widgets/my_form_field_widget.dart';
// import 'package:quick_mart/views/widgets/my_gap_widget.dart';
// import 'package:quick_mart/views/widgets/my_upload_post_button_widget.dart';
//
// AddPostWidgets({
//   required Key formState,
//   required RxList images,
//   required VoidCallback pickImages,
//   required RxString categoryBHint,
//   required List<String> categories,
//   required RxBool newSelected,
//   required RxBool usedSelected,
//   required RxString condition,
//   required RxString title,
//   required RxString price,
//   required RxString description,
//   required RxBool isLoading,
//   required VoidCallback cancelOnClick,
//   required VoidCallback uploadOnClick,
// }) {
//   return [
//     MyGapWidget(20.sp),
//     Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.sp,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MyGapWidget(15.sp),
//           Text(
//             AppStrings.imagesText,
//             style: TextStyle(
//               color: AppColors.darkBlue,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           MyGapWidget(15.sp),
//           Obx(
//             () {
//               return GridView.builder(
//                 itemCount: images.length,
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10.sp,
//                   crossAxisSpacing: 10.sp,
//                 ),
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onLongPress: () {
//                       images.removeAt(index);
//                     },
//                     child: Obx(
//                       () {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(15.sp),
//                           child: Image.file(
//                             images[index],
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           Obx(
//             () {
//               return images.length == 0 ? MyGapWidget(0) : MyGapWidget(15.sp);
//             },
//           ),
//           Obx(
//             () {
//               return Center(
//                 child: images.length == 0
//                     ? InkWell(
//                         onTap: pickImages,
//                         child: Container(
//                           height: 150.sp,
//                           width: 150.sp,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: AppColors.darkBlue,
//                             borderRadius: BorderRadius.circular(15.sp),
//                           ),
//                           child: Icon(
//                             Icons.camera_rounded,
//                             color: AppColors.white,
//                             size: 50.sp,
//                           ),
//                         ),
//                       )
//                     : MyGapWidget(0),
//               );
//             },
//           ),
//           Divider(
//             height: 50.sp,
//             color: AppColors.darkBlue,
//             thickness: 2,
//             indent: 50.sp,
//             endIndent: 50.sp,
//           ),
//           Text(
//             AppStrings.categoryText,
//             style: TextStyle(
//               color: AppColors.darkBlue,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           MyGapWidget(15.sp),
//           MyDropdownButtonWidget(
//             updatedTitle: categoryBHint,
//             leftIcon: Icons.category_rounded,
//             title: AppStrings.selectCategoryText,
//             items: categories,
//             isDown: RxBool(false),
//           ),
//           Divider(
//             height: 50.sp,
//             color: AppColors.darkBlue,
//             thickness: 2,
//             indent: 50.sp,
//             endIndent: 50.sp,
//           ),
//           Text(
//             AppStrings.conditionText,
//             style: TextStyle(
//               color: AppColors.darkBlue,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           MyGapWidget(15.sp),
//           Wrap(
//             spacing: 8.sp,
//             runSpacing: 4.sp,
//             children: [
//               MyUploadPostButtonWidget(
//                 onClick: () {
//                   usedSelected.value = false;
//                   newSelected.value = true;
//                   condition.value = AppStrings.newText;
//                 },
//                 selected: newSelected,
//                 title: AppStrings.newText,
//               ),
//               MyUploadPostButtonWidget(
//                 onClick: () {
//                   usedSelected.value = true;
//                   newSelected.value = false;
//                   condition.value = AppStrings.usedText;
//                 },
//                 selected: usedSelected,
//                 title: AppStrings.usedText,
//               ),
//             ],
//           ),
//           Divider(
//             height: 50.sp,
//             color: AppColors.darkBlue,
//             thickness: 2.sp,
//             indent: 50.sp,
//             endIndent: 50.sp,
//           ),
//           Text(
//             AppStrings.infoText,
//             style: TextStyle(
//               color: AppColors.darkBlue,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Form(
//             key: formState,
//             child: Column(
//               children: [
//                 MyGapWidget(15.sp),
//                 MyFormFieldWidget(
//                   onSaved: (value) {
//                     title.value = value!;
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppStrings.titleEmptyValidate;
//                     }
//                     return null;
//                   },
//                   padding: 0.sp,
//                   keyboardType: TextInputType.text,
//                   labelName: AppStrings.titleText,
//                   placeholder: AppStrings.titlePlaceholder,
//                 ),
//                 MyGapWidget(25.sp),
//                 MyFormFieldWidget(
//                   onSaved: (value) {
//                     price.value = value!;
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppStrings.priceEmptyValidate;
//                     }
//                     return null;
//                   },
//                   padding: 0.sp,
//                   keyboardType: TextInputType.number,
//                   labelName: AppStrings.priceText,
//                   placeholder: AppStrings.pricePlaceholder,
//                 ),
//                 MyGapWidget(25.sp),
//                 MyFormFieldWidget(
//                   onSaved: (value) {
//                     description.value = value!;
//                   },
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return AppStrings.descriptionEmptyValidate;
//                     }
//                     return null;
//                   },
//                   padding: 0.sp,
//                   keyboardType: TextInputType.text,
//                   labelName: AppStrings.descriptionText,
//                   placeholder: AppStrings.descriptionPlaceholder,
//                 ),
//               ],
//             ),
//           ),
//           MyGapWidget(25.sp),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(
//                 onTap: cancelOnClick,
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 40.sp,
//                   width: 100.sp,
//                   decoration: BoxDecoration(
//                     color: AppColors.darkBlue,
//                     borderRadius: BorderRadius.circular(15.sp),
//                   ),
//                   child: Text(
//                     AppStrings.cancelText,
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     style: TextStyle(
//                       color: AppColors.white,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                 ),
//               ),
//               Obx(
//                 () => isLoading == false
//                     ? InkWell(
//                         onTap: uploadOnClick,
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 40.sp,
//                           width: 100.sp,
//                           decoration: BoxDecoration(
//                             color: AppColors.red,
//                             borderRadius: BorderRadius.circular(15.sp),
//                           ),
//                           child: Text(
//                             AppStrings.uploadText,
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             style: TextStyle(
//                               color: AppColors.white,
//                               fontSize: 16.sp,
//                             ),
//                           ),
//                         ),
//                       )
//                     : CircleAvatar(
//                         radius: 20.sp,
//                         backgroundColor: AppColors.red,
//                         child: Container(
//                           padding: EdgeInsets.all(10.sp),
//                           child: CircularProgressIndicator(
//                             color: AppColors.white,
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//           MyGapWidget(15.sp),
//         ],
//       ),
//     ),
//   ];
// }
