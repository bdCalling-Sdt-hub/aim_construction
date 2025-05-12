import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AppCustomTextOrIconButton extends StatelessWidget {
  final String text;
  final Function() onTab;
  final double? height;
  final double? width;
  final bool? isBorderActive;
  final Color? borderColors;
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;
  final double? containerVerticalPadding;
  final double? containerHorizontalPadding;
  final double? iconHeight;
  final bool? isIconWithTextActive;
  final String? iconPath;

  const AppCustomTextOrIconButton(
      {super.key,
      required this.text,
      required this.onTab,
      this.height,
      this.width,
      this.isBorderActive = false,
      this.borderColors,
      this.buttonColor,
      this.containerVerticalPadding,
      this.containerHorizontalPadding,
      this.isIconWithTextActive = false,
      this.iconPath,
      this.textColor,
      this.iconColor, this.iconHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            vertical: containerVerticalPadding ?? 7.h,
            horizontal: containerHorizontalPadding ?? 7.w),
        // Button padding
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: isBorderActive == true ? Border.all(
                  color: borderColors ?? Colors.white,
                  width: 2, // Border width
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: isIconWithTextActive == true
            ? Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 4.w),
                  SvgPicture.asset(iconPath ?? '',
                    height: iconHeight??17.h,
                    colorFilter: ColorFilter.mode(
                        iconColor ?? Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    text,
                    style: AppStyles.fontSize16(color: textColor ?? Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              )
            : Text(
                text,
                style: AppStyles.fontSize16(color: textColor ?? Colors.white),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
