import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              //=============================> Skip Button <========================
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(width: 1.w, color: AppColors.primaryColor),
                    ),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.signIn_screen);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
                        child: Text('Skip',style: AppStyles.fontSize16(fontWeight: FontWeight.w600,color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //=============================> Onboarding Img Section <========================
              SizedBox(height: 145.h),
              Image.asset('assets/image/onboarding.png', width: 357.w, height: 357.h),
              //=============================> GET STARTED Button <========================
              SizedBox(height: 120.h),
              CustomButton(
                  onTap: () {
                      Get.toNamed(AppRoutes.signIn_screen);
                  },
                  text: 'GET STARTED'),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
