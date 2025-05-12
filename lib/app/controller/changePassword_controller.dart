import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../common/prefs_helper/prefs_helpers.dart' show PrefsHelper;

class AuthController extends GetxController {
  //====================================> Change password <==================================

  final TextEditingController currentPasswordCTRl = TextEditingController();
  final TextEditingController newPassCTRl = TextEditingController();
  final TextEditingController confirmPassCTRl = TextEditingController();

  var changeLoading = false.obs;
  changePassword() async {
    changeLoading(true);

    var body = {
      "currentPassword": currentPasswordCTRl.text.trim(),
      "newPassword": newPassCTRl.text.trim(),
    };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.postData(
        ApiConstants.changePasswordEndPoint, body, headers: headers
    );

    changeLoading(false);
    if (response.statusCode == 200) {

      Get.snackbar('Successfully', response.body['message']);

      var role = await PrefsHelper.getString(AppConstants.role);
      if (role == Role.projectManager.name) {
        Get.toNamed(AppRoutes.managerMoreScreen);
      } else if (role == Role.projectSupervisor.name) {
        Get.toNamed(AppRoutes.supervisorMoreScreen);
      }

    } else if (response.statusCode == 400) {
      Get.snackbar('Error', response.body['message']);
    } else {
      ApiChecker.checkApi(response);
    }
  }


}