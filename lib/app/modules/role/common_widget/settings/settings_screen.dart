
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/widgets/custom_listTile.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Settings',
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.black, size: 18.w),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //============================> Change Password List Tile <=================
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.changePasswordScreen);
                      },
                      title:AppString.changePasswordText.tr,
                      suffixIcon: SvgPicture.asset(AppIcons.arrowRight,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                    SizedBox(height: 8.h),
                    //============================> Terms Services List Tile <=================
                    CustomListTile(
                      onTap: () {
                          Get.toNamed(AppRoutes.termsandConditionsScreen);
                      },
                      title:'Terms Services',
                      suffixIcon: SvgPicture.asset(AppIcons.arrowRight,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                    SizedBox(height: 8.h),
                    //============================> Privacy Policy List Tile <=================
                    CustomListTile(
                      onTap: () {
                          Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
                      title:AppString.privacyPolicy.tr,
                      suffixIcon: SvgPicture.asset(AppIcons.arrowRight,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                    SizedBox(height: 8.h),
                    //============================> About Us List Tile <=================
                    CustomListTile(
                      onTap: () {
                          Get.toNamed(AppRoutes.aboutUsScreen);
                      },
                      title:AppString.aboutUsText.tr,
                      suffixIcon: SvgPicture.asset(AppIcons.arrowRight,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),

                    SizedBox(height: 8.h),
                    //============================> ContactUs List Tile <=================
                    CustomListTile(
                      onTap: () {
                         Get.toNamed(AppRoutes.contactUsScreen);
                      },
                      title:'Contact Us',
                      suffixIcon: SvgPicture.asset(AppIcons.arrowRight,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    )
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}