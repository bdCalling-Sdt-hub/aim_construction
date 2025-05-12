import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final String? status;
  final int documentCount;
  final int imageCount;

  NoteCard({
    required this.title,
    required this.description,
    this.status,
    required this.documentCount,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    Color? statusColor;
    if (status != null) {
      if (status!.toLowerCase() == 'pending') {
        statusColor = AppColors.pendingStatusColor;
      } else if (status!.toLowerCase() == 'accepted') {
        statusColor = AppColors.greenColor;
      } else if (status!.toLowerCase() == 'denied') {
        statusColor = AppColors.redColor;
      } else {
        statusColor = Colors.grey;
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.color5F6774),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and optional Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    style: AppStyles.fontSize16(color: AppColors.color323B4A,fontWeight: FontWeight.bold),
                  ),
                ),
                if (status != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status!,
                      style: AppStyles.fontSize14(color: AppColors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h), // Small space between title and description


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: AppStyles.fontSize14(color: AppColors.color323B4A),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2
                  ),
                ),
              ],
            ),

            // Footer with icons
            SizedBox(height: 8.h),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.attachmentIcon, height: 20.h),
                    SizedBox(width: 4),
                    Text('$documentCount', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.imageIcon, height: 16.h, color: AppColors.color323B4A),
                    SizedBox(width: 4),
                    Text('$imageCount', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

