import 'package:com.rado.quick_mart/views/widgets/my_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyChangePasswordBottomSheetFormFieldWidget extends StatelessWidget {
  final String name;
  final RxBool obscureBool;
  final String emptyValidation;
  final String lessValidation;
  final String largeValidation;

  const MyChangePasswordBottomSheetFormFieldWidget({
    required this.name,
    required this.obscureBool,
    required this.emptyValidation,
    required this.lessValidation,
    required this.largeValidation,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return MyFormFieldWidget(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return emptyValidation;
            } else if (value.length < 8) {
              return lessValidation;
            } else if (value.length > 24) {
              return largeValidation;
            }
            return null;
          },
          obscure: obscureBool.value,
          prefixIcon: Icon(Icons.lock_rounded),
          labelName: name,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: InkWell(
            onTap: () {
              obscureBool.value = !obscureBool.value;
            },
            child: Icon(obscureBool.value ? Icons.visibility_off_rounded : Icons.visibility_rounded),
          ),
        );
      },
    );
  }
}
