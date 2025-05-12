import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:get/get.dart';


class VerifyEmailController extends GetxController {

  ///<=================================== verifyOTP Method==================================================>
  var verifyOTPLoading = false.obs;

  TextEditingController verifyCodeCtrl = TextEditingController();
  verifyCode({
    required String email,
    required String otp,
    required String type,
  }) async {
    var verificationToken = await PrefsHelper.getString(AppConstants.verificationToken);
    verifyOTPLoading(true);
    try {
      Map<String, dynamic> body = {
        "email": email,
        "otp": otp,
        "token": verificationToken,
      };
      var headers = {'Content-Type': 'application/json'};
      Response response = await ApiClient.postData(
          ApiConstants.verifyCodeEndPoint, body,
          headers: headers);

      print("============> Response Body ${response.body} and ==> ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        verifyOTPLoading(false);
        Get.snackbar('Done', response.body['message']);


        if (type == "signupScreen") {
          Get.offAllNamed(AppRoutes.successfullScreen);
        } else if(type == "forgetPasswordScreen") {
          Get.offAllNamed(AppRoutes.resetPasswordScreen,
            parameters: {
              "email": email,
              "otp": otp,
            },

          );
        }

      } else if (response.statusCode == 400 || response.statusCode == 401) {
        verifyOTPLoading(false);
        Get.snackbar('Error', response.body['message']);
      } else {
        ApiChecker.checkApi(response);
        verifyOTPLoading(false);
      }
    } catch (e) {
      print("===> error : $e");
    }
    verifyOTPLoading(false);
  }


  /// ==========================>> Resend otp   <<================
  var resendOtpLoading = false.obs;
  resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {
      "email": email,
    };
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.resendOTPEndPoint, body,
        headers: header);
    print("===> ${response.body}");
    if (response.statusCode == 200) {
      PrefsHelper.setString(AppConstants.verificationToken, response.body['data']['attributes']['resetPasswordToken']);
      Get.snackbar('Successful',  response.body['message']);
    } else {
      Get.snackbar('Error', response.body['message']);
    }
    resendOtpLoading(false);
  }
}
