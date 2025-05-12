import 'dart:io';

import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/model/project_model.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProjectController extends GetxController {
  //==================== >>>>   Project Create <<<<   ==========================

  TextEditingController projectNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  File? selectedProjectImage;
  RxString selectedSupervisor = ''.obs;
  RxString selectedTampelet = ''.obs;
  List<String> tampelet = ['Default'];
  var isLoading = false.obs;

  projectCreate() async {
    isLoading(true);
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(startDateController.text));
    String formattedEndDate = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(endDateController.text));

    List<MultipartBody> multipartBody = [];
    if (selectedProjectImage != null) {
      multipartBody.add(MultipartBody("projectLogo", selectedProjectImage!));
    }

    Map<String, String> body = {
      "projectName": projectNameController.text,
      "projectSuperVisorId": selectedSupervisor.value,
      "streetAddress": streetAddressController.text,
      "city": cityController.text,
      "zipCode": zipCodeController.text,
      "country": countryController.text,
      "startDate": formattedStartDate,
      "endDate": formattedEndDate,
    };

    var response = await ApiClient.postMultipartData(
      ApiConstants.projectCreateEndPoint,
      body,
      multipartBody: multipartBody,
    );

    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading(false);
      Get.snackbar('Successfully', 'Project created successfully');
      update();
      clearFromData();
      Get.toNamed(AppRoutes.managerHomeScreen);
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }

  void clearFromData() {
    projectNameController.clear();
    selectedSupervisor.value = '';
    selectedTampelet.value = '';
    streetAddressController.clear();
    cityController.clear();
    zipCodeController.clear();
    countryController.clear();
    startDateController.clear();
    endDateController.clear();
  }

//======================== Project Details ==========================
  RxList<ProjectDetailsModel> projectDetailsModel = <ProjectDetailsModel>[].obs;


  getAllProjectDetails(
      {String? projectName,
      String? id,
      String? projectSuperVisorId,
      String? projectManagerId,
      String? projectStatus}) async {
    isLoading(true);
    List<String> queryParams = [];
    if (projectName != null) queryParams.add('projectName=$projectName');
    if (id != null) queryParams.add('id=$id');
    if (projectSuperVisorId != null) queryParams.add('projectSuperVisorId=$projectSuperVisorId');

    if (projectManagerId != null) queryParams.add('projectManagerId=$projectManagerId');
    if (projectStatus != null) queryParams.add('projectStatus=$projectStatus');

    var url = ApiConstants.projectDetailsEndPoint;

    if (queryParams.isNotEmpty) {
      url +='?sortBy=-createdAt&${queryParams.join('&')}';
    }


    var response = await ApiClient.getData(url);

    // Handle response
    if (response.statusCode == 200) {
      projectDetailsModel.value = List.from(response.body['data']['attributes']['results'].map((x) => ProjectDetailsModel.fromJson(x)));
      isLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }
}


