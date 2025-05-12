
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTwoDigitsFormField extends StatelessWidget {
  const CustomTwoDigitsFormField({
    super.key,
    required this.controller, required this.digitValue,
  });

  final TextEditingController controller;
  final int digitValue;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: AppStyles.fontSize20(),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2)
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
      ),
      onChanged: (value){
        if(value.isNotEmpty){
          int parseValue= int.parse(value);
          if(parseValue > digitValue){
            controller.text='$digitValue';
            controller.selection= TextSelection.fromPosition(TextPosition(offset: controller.text.length));
          }
        }
      },
    );
  }
}