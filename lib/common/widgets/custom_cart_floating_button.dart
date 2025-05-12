import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';

class CustomCartFloatingButton extends StatelessWidget {
  const CustomCartFloatingButton({super.key});
  final int notificationCount = 20;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,  // To allow the badge to overflow
      children: [
        FloatingActionButton(
          onPressed: () {
          // Get.toNamed(Routes.CART);
          },
          backgroundColor: AppColors.floatingButtonColor,
          child: const Icon(Icons.shopping_cart),
        ),

        // Notification Badge
        if (notificationCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12.r),
              ),
              constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.h),
              child: Text(
                notificationCount > 99 ? "99+" : "$notificationCount",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
