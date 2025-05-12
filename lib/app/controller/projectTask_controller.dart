import 'dart:io';

import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/model/projectTask_details_model.dart';
import 'package:aim_construction/app/model/project_model.dart';
import 'package:aim_construction/app/model/task_detailsModel.dart';
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


class ProjectTaskController extends GetxController {

//======================== Project Task Details ==========================
  RxList<ProjectTaskDetailsModel> projectTaskDetailsModel = <ProjectTaskDetailsModel>[].obs;
  var isLoading = false.obs;

  getAllProjectTaskDetails(
      {
        String? title,
        String? id,
        String? project,
        String? task_status,
        String? projectId}) async {
    isLoading(true);
    List<String> queryParams = [];
    if (title != null) queryParams.add('title=$title');
    if (id != null) queryParams.add('_id=$id');
    if (project != null) queryParams.add('project=$project');
    if (task_status != null) queryParams.add('task_status=$task_status');
    if (projectId != null) queryParams.add('projectId=$projectId');

    var url = ApiConstants.projectTaskDetailsEndPoint;

    if (queryParams.isNotEmpty) {
      url +='?sortBy=-createdAt&${queryParams.join('&')}';
    }


    var response = await ApiClient.getData(url);

    // Handle response
    if (response.statusCode == 200) {
      projectTaskDetailsModel.value = List.from(response.body['data']['attributes'].map((x) => ProjectTaskDetailsModel.fromJson(x)));
      isLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }

//================= pickFileFromDevice
  ImagePicker picker = ImagePicker();
  RxList<String> images = <String>[].obs;
  RxList<String> file = <String>[].obs;

  Future<void> pickFileFromDevice() async {
    try {
      // Pick multiple images or files (assuming you are using an image picker that supports multiple media)
      final List<XFile>? returnFiles = await picker.pickMultipleMedia();  // This needs the correct package

      // Check if no files were selected
      if (returnFiles == null || returnFiles.isEmpty) {
        print("No files selected");
        Get.snackbar(
          "No Files Selected",
          "Please select valid image files (JPG, PNG) or PDF files.",
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }

      // Iterate through each selected file
      for (var img in returnFiles) {
        final fileExtension = img.path.split('.').last.toLowerCase();

        if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
          images.value.add(img.path);
        }
        // If it's a file (PDF, DOCX, XLSX), add it to the file list
        else if (fileExtension == 'pdf' || fileExtension == 'docx' || fileExtension == 'doc' || fileExtension == 'xls' || fileExtension == 'xlsx') {
          file.value.add(img.path);
        } else {
          // Handle invalid file formats
          print("Invalid file format: $fileExtension for file ${img.path}");
          Get.snackbar(
            "Invalid File Format",
            "File '${img.name}' is not a valid format. Allowed formats: JPG, PNG, PDF, DOCX, XLSX.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }

      images.refresh();
      file.refresh();
    } catch (e) {
      // Handle unexpected errors gracefully
      print("Error while picking files: $e");
      Get.snackbar(
        "Error",
        "An error occurred while selecting files. Please try again.",
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }

  removeImage(int index) {
    images.removeAt(index);
    refresh();
  }

  removeFile(int index) {
    file.removeAt(index);
    refresh();
  }

  RxString assignToSupervisor = ''.obs;
  DateTime? selectedDate;

  TextEditingController taskTitelCTRl = TextEditingController();
  TextEditingController taskDescriptionCTRl = TextEditingController();
  //====================>> Manger Task Create

  managerTaskCreate({required String projectId}) async{
    isLoading(true);
    List<MultipartBody> multipartAttachments = [];


    // Add multiple images to multipartList
    for (String imagePath in images) {
      multipartAttachments.add(MultipartBody("attachments", File(imagePath)));
    }

    for (String filePath in file) {
      multipartAttachments.add(MultipartBody("attachments", File(filePath)));
    }


    Map<String, String> body = {
      "projectId": projectId,
      "title": taskTitelCTRl.text.trim(),
      "description": taskDescriptionCTRl.text.trim(),
      "assignedTo": assignToSupervisor.value,
      "dueDate": selectedDate.toString(),
    };

    var response = await ApiClient.postMultipartFileData(
      ApiConstants.projectTaskCreateEndPoint,
      body,
      multipartBody: multipartAttachments,
    );
    // Handle response
    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.snackbar('Successfully','Task created successfully');
      isLoading(false);
      update();
      clearTaskData();
      Get.toNamed(AppRoutes.taskViewScreen);
    }
    if (response.statusCode == 400) {
      isLoading(false);
      Get.snackbar('Error','All field required');
    }
    else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();

    }

  }

  void clearTaskData(){
    taskTitelCTRl.clear();
    taskDescriptionCTRl.clear();
    assignToSupervisor.value = '';
    selectedDate = null;
    clearImage();
    clearFile();
  }

  void clearImage(){
    images.clear();
  }
  void clearFile(){
    file.clear();
  }



  //============================>> Task Details by ID <<==============================

  Rx<GetTaskDetailByIdModel> getTaskDetailByIdModel = GetTaskDetailByIdModel().obs;


  getTaskDetailsByID(String taskID)async{
    isLoading.value=true;
    var response = await ApiClient.getData(
      "${ApiConstants.getTaskDetailsByIDEndPoint}/$taskID",);
    if (response.statusCode == 200) {
      getTaskDetailByIdModel.value = GetTaskDetailByIdModel.fromJson(response.body['data']['attributes']);


      isLoading.value=false;


      update();

    }else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
      update();

    }
  }


  //============================= Task Status Change ======================
  RxBool loading=false.obs;
  taskStatusChnage(String taskID) async {
    loading.value = true;
    var response = await ApiClient.getData("${ApiConstants.taskStatusChnangeEndPoint}/$taskID",);
    if (response.statusCode == 200) {
      Get.snackbar('Successfully', response.body['message']);
      loading.value=false;


      update();

    }else {
      isLoading.value=false;
      ApiChecker.checkApi(response);
      update();

    }
  }
}


