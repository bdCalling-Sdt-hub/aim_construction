import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskCard extends StatelessWidget {
  final String noteTitel;
  final String noteDiscreiption;
  final int doumentCount;
  final int imageCount;
  final String authorName;
  final String date;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.noteTitel,
    required this.noteDiscreiption,
    required this.doumentCount,
    required this.imageCount,
    required this.authorName,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.color5F6774),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      noteTitel,
                      style: AppStyles.fontSize14(color: AppColors.color323B4A, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      noteDiscreiption,
                      style: AppStyles.fontSize14(color: AppColors.color323B4A),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.attachmentIcon, height: 14.h, width: 14.w),
                        SizedBox(width: 4.w),
                        Text('$doumentCount', style: AppStyles.fontSize14(color: AppColors.color323B4A)),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(AppIcons.imageIcon, height: 14.h, width: 14.w, color: AppColors.color323B4A),
                        SizedBox(width: 4.w),
                        Text('$imageCount', style: AppStyles.fontSize14(color: AppColors.color323B4A)),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(AppIcons.profileIcon, height: 14.h, width: 14.w),
                        SizedBox(width: 4.w),
                        Text(authorName, style: AppStyles.fontSize14(color: AppColors.color323B4A)),
                        SizedBox(width: 12.w),
                        SvgPicture.asset(AppIcons.calender, height: 14.h, width: 14.w),
                        SizedBox(width: 4.w),
                        Text(date, style: AppStyles.fontSize14(color: AppColors.color323B4A)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor, size: 15),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


