import 'package:aim_construction/app/modules/role/common_widget/auth/verifyEmail/controllers/verify_email_controller.dart';
import 'package:aim_construction/base/pin_code_text_field.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final VerifyEmailController verifyEmailController = Get.put(VerifyEmailController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    print('Screen Type: ${parameter['screenType']}');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppString.verifyEmail.tr,
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
            Text(
              'We have sent a verification code to your email. Please check your email and enter the code. ',
              style: AppStyles.fontSize16(color: AppColors.color878787),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30.h),
            CustomPinCodeTextField(
              textEditingController: verifyEmailController.verifyCodeCtrl,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: AppString.didNotGetCode.tr,
                  color: AppColors.color878787,
                ),
                //=====================> Resend Text Button <=================
                InkWell(
                  onTap: () {
                    verifyEmailController.resendOtp("${parameter['email']}");
                  },
                  child: CustomText(
                    text: AppString.resend.tr,
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.h),
            Obx((){
              return  CustomButton(
                loading: verifyEmailController.verifyOTPLoading.value,
                onTap: () {
                  verifyEmailController.verifyCode(
                      email:"${parameter['email']}",
                      otp: verifyEmailController.verifyCodeCtrl.text,
                      type:"${parameter['screenType']}");

                },
                text: AppString.verifyEmail.tr,
              );
            }
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
