import 'package:aim_construction/app/modules/role/common_widget/auth/sign_in/controllers/sign_in_controller.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Sign In",style: AppStyles.fontSize18()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              // Text sections

              SizedBox(height: 20.h),
              CustomTextField(
                  filColor: AppColors.white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.emailIcon),
                  ),
                  hintText: AppString.enterEmailText.tr,
                  controller: signInController.emailCtrl),
              SizedBox(height: 16.h),
              CustomTextField(
                  filColor: AppColors.white,
                  isPassword: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.lockIcon),
                  ),
                  hintText: AppString.enterPasswordText.tr,
                  controller: signInController.passCtrl),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //=================================> Forgot Password Button <================================
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.FORGET_PASSWORD);
                    },
                    child: CustomText(
                      fontWeight: FontWeight.bold,
                      text: AppString.forgotPassword.tr,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              /// Sing In Button
              Obx((){
                return CustomButton(
                  loading: signInController.signInLoading.value,
                  onTap: () {
                    signInController.signInMethod();
                  },
                  text: AppString.signInText.tr,
                );
              }),

              ///==================>> Don't have and Account <===================
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${AppString.doNotHaveAccount.tr}",
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.SIGNUP);
                      },
                      child: CustomText(
                        text: AppString.signUpText.tr,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),

              TextButton(
                  onPressed: () {
                    createCompany(context);
                  },
                  child: CustomText(
                    text: 'As a manager create company first.',
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
      ),
    );
  }
//====================== Create Company ==============
  void createCompany(BuildContext context) {
    final SignInController signInController = Get.put(SignInController());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Company'),
          content: TextFormField(
            controller: signInController.companyName,
            decoration: const InputDecoration(
              labelText: 'Company Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        onTap: (){
                          Get.back();
                        },
                        text: 'Cancel',
                      color: AppColors.subTextColor
                    )
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Obx((){
                    return CustomButton(
                      loading: signInController.companyLoading.value,
                        onTap: (){
                        signInController.newCompanyCreated();
                        }, text: 'Add');
                  })
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
