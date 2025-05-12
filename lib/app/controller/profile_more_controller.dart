import 'dart:io';

import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/modules/role/manager/more/model/getAllSupervisorbyManagerModel.dart';
import 'package:aim_construction/app/modules/role/manager/more/model/useProfileDetailsModel.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileMoreController extends GetxController {

//============================> Get Profile Data <=============================


  Rx<UserProfileDetailsModel> userProfileDetailsModel = UserProfileDetailsModel().obs;
  var isLoading = false.obs;

  getProfileData(String userID) async {
    isLoading(true);

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken'
    };

    var response = await ApiClient.getData("${ApiConstants.userprofileDetailsEndPoint}/$userID", headers: headers);
    print("=============response : ${response.body}");
    if (response.statusCode == 200) {
      userProfileDetailsModel.value = UserProfileDetailsModel.fromJson(response.body['data']['attributes']);
      isLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }

  }

  //=========================>> All Supervisor by Manger  <<============================

  RxList<GetAllSupervisorByManagerModel> getAllSupervisorByManagerModel = <GetAllSupervisorByManagerModel>[].obs;

  getAllSupervisorByManger() async {
    isLoading (true);
    var response = await ApiClient.getData("${ApiConstants.getAllSupervisorByManagerEndPoint}");
    if (response.statusCode == 200) {
      getAllSupervisorByManagerModel.value = List<GetAllSupervisorByManagerModel>.from(response.body['data']['attributes'].map((x) => GetAllSupervisorByManagerModel.fromJson(x)));
      isLoading (false);
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
      isLoading (false);
    }
  }

  //===================>>> Edit Profile <<====================
  Future<void> editProfile({
    File? profileImage,
    required String fname,
    required String lname,
    required String phoneNumber,
    required String address,
  }) async {
    isLoading (true);

    List<MultipartBody> multipartBody = [];

    if (profileImage != null) {
      multipartBody.add(MultipartBody("profileImage", profileImage));
    }


    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Authorization': 'Bearer $bearerToken',
    };

    Map<String, String> body = {
      "fname": fname,
      "lname": lname,
      "address": address,
      "phoneNumber": phoneNumber,

    };

    var response = await ApiClient.patchMultipartData(
      ApiConstants.updateProfileEndPoint,
      body,
      headers: headers,
      multipartBody: multipartBody,
    );

    print("===========response body : ${response.body} \nand status code : ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      userProfileDetailsModel.value = UserProfileDetailsModel.fromJson(response.body['data']['attributes']);
      isLoading (false);
      userProfileDetailsModel.refresh();
      var role = await PrefsHelper.getString(AppConstants.role);

      if (role == Role.projectManager.name) {
        Get.offAllNamed(AppRoutes.managerMoreScreen);
      } else if (role == Role.projectSupervisor.name) {
        Get.offAllNamed(AppRoutes.supervisorMoreScreen);
      }

      // Show success snackbar
      Get.snackbar('Successfully', response.body['message']);
    } else {
      ApiChecker.checkApi(response);
      Get.snackbar('Error',  response.body['message']);
      isLoading (false);
    }
  }

}
