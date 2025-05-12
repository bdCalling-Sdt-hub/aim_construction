
import 'package:aim_construction/app/modules/resetPassword/controllers/reset_password_controller.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    // Print screen type when the screen initializes
    print('Screen Email Type: ${parameter['email']}');
    print('Screen Otp Type: ${parameter['otp']}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=============================> AppBar Section <=======================
      appBar: AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      //=============================> Body Section <========================
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //=======================> Password Text Field <======================
                    CustomTextField(
                      filColor: AppColors.fillUpColor,
                      controller: resetPasswordController.setNewPasswordCTRl,
                      hintText: "Password",
                      isPassword: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        child: SvgPicture.asset(AppIcons.lockIcon,color: AppColors.primaryColor),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    //=======================> Confirm Password Text Field <======================
                    CustomTextField(
                      filColor: AppColors.fillUpColor,
                      controller: resetPasswordController.setConfirmNewPasswordCTRl,
                      hintText: "Confirm Password",
                      isPassword: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        child: SvgPicture.asset(AppIcons.lockIcon,color: AppColors.primaryColor),
                      ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter Confirm password";
                          }
                          else if (resetPasswordController.setNewPasswordCTRl.text !=
                              resetPasswordController.setConfirmNewPasswordCTRl.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        }
                    ),
                    //====================> Continue Button <=============================
                    SizedBox(height: 425.h),
                    CustomButton(
                      onTap: () {
                       resetPasswordController.setNewPassword(
                           email:"${parameter['email']}",
                           otp: "${parameter['otp']}",
                       );
                      },
                      text: "Set New Password",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
