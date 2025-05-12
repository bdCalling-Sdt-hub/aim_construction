
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_button.dart';

class HeaderTitleBar extends StatelessWidget {
  final String title;
  const HeaderTitleBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppButton(text: title,buttonColor:AppColors.roseTaupeColor,textStyle: AppStyles.fontSize16(color: Colors.white),),
        Expanded(child: Divider(height: 2.h,color: AppColors.roseTaupeColor,))
      ],
    );
  }
}