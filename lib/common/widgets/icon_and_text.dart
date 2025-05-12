
import 'package:aim_construction/common/widgets/spacing.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.iconData,
    required this.text, this.iconSize, this.textStyle, this.iconColor,
  });

  final IconData iconData;
  final Color? iconColor;
  final String text;
  final double? iconSize;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size:iconSize?? 20.h,
          color: iconColor?? Colors.grey,
        ),
        horizontalSpacing(4.w),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.clip,
            style:textStyle?? AppStyles.fontSize12(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
