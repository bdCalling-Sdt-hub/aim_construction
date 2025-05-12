import 'package:aim_construction/common/widgets/spacing.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TitleAndSeeAll extends StatelessWidget {
  const TitleAndSeeAll({
    super.key, required this.title, required this.onTap, this.count, this.buttonTitle,
  });
  final String title;
  final String? buttonTitle;
  final int? count;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title,style: AppStyles.fontSize20(),),
            horizontalSpacing(10.w),
            Text(count!=null && count! >0 ? count.toString():'',style: AppStyles.fontSize16(color: Colors.redAccent),),
          ],
        ),
        TextButton(onPressed: onTap, child:  Text(buttonTitle??'See All',style: AppStyles.fontSize16(color: Colors.blueAccent),))
      ],
    );
  }
}
