import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/signup/model/allCompanyGetByName_model.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/all_manager_model.dart';

class SignupController extends GetxController {
  ///<=============================== Sign Up Method ===========================>
  TextEditingController signUpFirstNameCtrl = TextEditingController();
  TextEditingController signUpLastNameCtrl = TextEditingController();
  TextEditingController signUpEmailCtrl = TextEditingController();
  TextEditingController signUpPassCtrl = TextEditingController();
  TextEditingController signUpConfirmPassCtrl = TextEditingController();

  TextEditingController signUpBirthday = TextEditingController();
  TextEditingController signUpAddressCtrl = TextEditingController();
  TextEditingController signUpCompanyCtrl = TextEditingController();
  List<String> userRole = ['Project Manager', 'Project Supervisor'];
  RxString selectedRole = ''.obs;

  RxString selectedManagerRole = ''.obs;

  var signUpLoading = false.obs;

  signUpMethod(String companyID) async {
    signUpLoading.value = true;
    var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
    Map<String, dynamic> body = {
      "fname": signUpFirstNameCtrl.text.trim(),
      "lname": signUpLastNameCtrl.text.trim(),
      "password": signUpPassCtrl.text.trim(),
      "email": signUpEmailCtrl.text.trim(),
      "role": selectedRole.value,
      "companyId": companyID,
      "superVisorsManagerId": selectedManagerRole.value,
      "fcmToken": fcmToken,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setString(AppConstants.verificationToken,
          response.body['data']['attributes']['verificationToken']);
      print('Hera is your fcmToken : $fcmToken');
      Get.toNamed(
        AppRoutes.verify_email_screen,
        parameters: {
          "email": signUpEmailCtrl.text.trim(),
          "screenType": "signupScreen",
        },
      );
      clearData();
      signUpLoading(false);
      update();
    }

    else {
      ApiChecker.checkApi(response);
      Get.snackbar('Error', response.body['message']);
      signUpLoading(false);
      update();
    }
  }

  clearData() {
    signUpFirstNameCtrl.clear();
    signUpLastNameCtrl.clear();
    signUpEmailCtrl.clear();
    signUpPassCtrl.clear();
    signUpConfirmPassCtrl.clear();
    selectedRole.value = "";
  }

  //=========================>> Get All Company  <<============================

  RxList<GetAllCompanyModel> getAllCompanyModel = <GetAllCompanyModel>[].obs;
  TextEditingController companyName = TextEditingController();
  var companyLoading = false.obs;
  RxString selectedCompany = ''.obs;

  getAllCompany() async {
    companyLoading(true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await ApiClient.postDatax(
        "${ApiConstants.getAllCompanyEndPoint}?companyName=${companyName.text}",
        headers: headers);

    if (response.statusCode == 200) {
      getAllCompanyModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllCompanyModel.fromJson(x)));
      companyLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      companyLoading(false);
      update();
    }
  }

  //=========================>> Get All Company Manager <<============================

  RxList<GetAllManagerModel> getAllManagerModel = <GetAllManagerModel>[].obs;
  var loading = false.obs;

  getAllCompanyManager(String companyId) async {
    loading(true);

    var response = await ApiClient.getData("${ApiConstants.getAllCompanyManagerEndPoint}?companyId=$companyId");
    if (response.statusCode == 200) {
      getAllManagerModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllManagerModel.fromJson(x)));
      loading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }
}
