import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {

  //====================================> Set New password <==================================
  var setPasswordLoading = false.obs;
  final TextEditingController setNewPasswordCTRl = TextEditingController();
  final TextEditingController setConfirmNewPasswordCTRl = TextEditingController();

  setNewPassword({required String email,required String otp}) async {
    setPasswordLoading(true);
    var body = {
      "email": email,
      "otp": otp,
      "password": setNewPasswordCTRl.text.trim()
    };
    var response =
    await ApiClient.postData(ApiConstants.setNewPasswordEndPoint, body);
    if (response.statusCode == 200) {
      Get.snackbar('Success', response.body['message']);
      Get.offNamed(AppRoutes.successfullScreen);
    } else {
      Get.snackbar('Error', response.body['message']);
    }
    setPasswordLoading(false);
  }


}
