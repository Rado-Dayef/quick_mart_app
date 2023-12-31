import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:com.rado.quick_mart/constants/app_defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFormFieldWidget extends StatelessWidget {
  final Color? color;
  final bool? obscure;
  final int? maxLines;
  final bool? readOnly;
  final bool? autofocus;
  final double? padding;
  final String? initVal;
  final String? labelName;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? placeholder;
  final VoidCallback? onClick;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextEditingController? textController;
  final void Function(String)? onFieldSubmitted;

  const MyFormFieldWidget({
    this.color,
    this.obscure,
    this.readOnly,
    this.autofocus,
    this.maxLines,
    this.initVal,
    this.labelName,
    this.placeholder,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.onClick,
    this.keyboardType,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding ?? 15.w,
        ),
        child: TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction ?? TextInputAction.next,
          textAlignVertical: TextAlignVertical.center,
          minLines: 1,
          maxLines: maxLines ?? 1,
          controller: textController,
          autofocus: autofocus ?? false,
          onTap: onClick,
          readOnly: readOnly ?? false,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          initialValue: initVal,
          keyboardType: keyboardType,
          obscureText: obscure ?? false,
          cursorColor: color ?? AppColors.darkBlue,
          style: TextStyle(
            color: color ?? AppColors.darkBlue,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: color ?? AppColors.transparentDarkBlue,
            ),
            labelText: labelName,
            labelStyle: TextStyle(
              color: color ?? AppColors.darkBlue,
            ),
            border: AppDefaults.defaultInputBorder(
              borderColor: color ?? AppColors.darkBlue,
            ),
            disabledBorder: AppDefaults.defaultInputBorder(
              borderColor: color ?? AppColors.darkBlue,
            ),
            enabledBorder: AppDefaults.defaultInputBorder(
              borderColor: color ?? AppColors.darkBlue,
            ),
            focusedBorder: AppDefaults.defaultInputBorder(
              borderColor: color ?? AppColors.darkBlue,
            ),
            focusedErrorBorder: AppDefaults.defaultInputBorder(
              borderColor: AppColors.red,
            ),
            errorBorder: AppDefaults.defaultInputBorder(
              borderColor: AppColors.red,
            ),
            errorStyle: TextStyle(
              color: AppColors.red,
            ),
            prefixIconColor: color ?? AppColors.darkBlue,
            prefixIcon: prefixIcon,
            suffixIconColor: color ?? AppColors.darkBlue,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
