import 'package:aim_construction/app/controller/changePassword_controller.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppString.changePasswordText.tr,
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CustomTextField(
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppIcons.lockIcon, color: AppColors.primaryColor),
              ),
              hintText: AppString.currentPasswordText.tr,
              controller: authController.currentPasswordCTRl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your current password';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppIcons.lockIcon, color: AppColors.primaryColor),
              ),
              hintText: AppString.newPasswordText.tr,
              controller: authController.newPassCTRl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppIcons.lockIcon, color: AppColors.primaryColor),
              ),
              hintText: AppString.confrimNewPasswordText.tr,
              controller: authController.confirmPassCTRl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your new password';
                }
                if (value != authController.newPassCTRl.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                return CustomButton(
                  loading: authController.changeLoading.value,
                  onTap: () {
                      authController.changePassword();
                    },
                  text: AppString.updatePasswordText.tr,
                );
              }),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
