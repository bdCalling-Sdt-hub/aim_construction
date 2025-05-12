import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  ///<=============================== Sign In Method ===========================>


  var signInLoading = false.obs;

  signInMethod() async {
    signInLoading(true);
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
    var headers = {
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> body = {
      "email": emailCtrl.text.trim(),
      "password": passCtrl.text.trim(),
      "fcmToken": fcmToken,

    };

    print("===================> $body");

    try {
      Response response = await ApiClient.postData(
        ApiConstants.signInEndPoint,
        body,
        headers: headers,
      );

      print("============> Response Body: ${response.body}, Status Code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        signInLoading(false);
        PrefsHelper.setString(AppConstants.fcmToken, response.body['data']['fcmToken']);
        PrefsHelper.setString(AppConstants.bearerToken, response.body['data']['attributes']['tokens']['accessToken']);
        print('===================>> Check error');
        var userRole = response.body['data']['attributes']['userWithoutPassword']['role'].toString();
        var userID = response.body['data']['attributes']['userWithoutPassword']['id'];

       if(userRole.isNotEmpty){
         await PrefsHelper.setString(AppConstants.role, userRole);
       }
        if(userID !=  null){
          await PrefsHelper.setString(AppConstants.userId, userID);
        }
       await PrefsHelper.setBool(AppConstants.isLogged, true);

       String userId = await PrefsHelper.getString(AppConstants.userId);

        print('===================>> User Role: $userRole');
        print('===================>> UserId: $userId');




        if (userRole == Role.projectManager.name) {
          Get.offAllNamed(AppRoutes.managerHomeScreen);
          Get.snackbar('Successfully', response.body['message']);
        } else if (userRole == Role.projectSupervisor.name) {
          Get.offAllNamed(AppRoutes.ROLE_SUPERVISOR_HOME_SCREEN);
          Get.snackbar('Successfully', response.body['message']);
        }
      }
      else if (response.statusCode! >= 401 && response.statusCode! <= 430) {
        Get.snackbar('Error', response.body['message']);
      }
    } catch (e) {
      signInLoading(false);
      print('Error: $e');
    } finally {
      signInLoading(false);
    }
  }

  //=======================>>>> Create Company <<=======================================
  TextEditingController companyName = TextEditingController();
  var companyLoading = false.obs;
  newCompanyCreated() async{
    companyLoading(true);

    Map<String, String> body = {
      "name": companyName.text.trim(),
    };

    var response = await ApiClient.postData(
      ApiConstants.companyCreateEndPoint,
      body,
    );
    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Successfully',response.body['message']);
      print('Response Message: ${response.body['message']}');
      Get.toNamed(AppRoutes.SIGNUP);
      companyName.clear();
      companyLoading(false);
      update();
    }
    else if (response.statusCode == 400) {
     Get.snackbar('Error', response.body['message']);
      companyLoading(false);
    }
    else {
      ApiChecker.checkApi(response);
      Get.snackbar('Error!',response.body['message']);
      companyLoading(false);
      companyName.clear();
      update();

    }

  }
}
