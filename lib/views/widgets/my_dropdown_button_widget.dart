import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/views/widgets/my_gap_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyDropdownButtonWidget extends StatelessWidget {
  final RxString updatedTitle;
  final List<String> items;
  final String title;

  const MyDropdownButtonWidget({
    required this.updatedTitle,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              Icons.category_rounded,
              size: 24.sp,
              color: AppColors.darkBlue,
            ),
            MyGapWidget(10.sp),
            Obx(
              () {
                return Text(
                  updatedTitle.value == "" ? title : updatedTitle.value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
          ],
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          updatedTitle.value = value!;
        },
        buttonStyleData: ButtonStyleData(
          height: 25.sp,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 24.sp,
            color: AppColors.darkBlue,
          ),
          openMenuIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24.sp,
            color: AppColors.darkBlue,
          ),
          iconSize: 20.sp,
          iconEnabledColor: AppColors.darkBlue,
          iconDisabledColor: AppColors.darkBlue,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: Radius.circular(15.sp),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.all(10.sp),
        ),
      ),
    );
  }
}
