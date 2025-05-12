import 'dart:convert';
import 'dart:io';
import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/model/managerContract_model.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';


class ManagerContarctController extends GetxController {

//======================== Project Task Details ==========================
  RxList<GetAllManagerContractModel> getAllManagerContractModel = <GetAllManagerContractModel>[].obs;
  var isLoading = false.obs;

  getAllManagerContractDetails(
      {
        String? projectName,
        String? id,
        }) async {
    isLoading(true);
    List<String> queryParams = [];
    if (projectName != null) queryParams.add('projectName=$projectName');
    if (id != null) queryParams.add('_id=$id');

    var url = ApiConstants.getManagerContarctEndPoint;

    if (queryParams.isNotEmpty) {
      url +='?${queryParams.join('&')}';
    }


    var response = await ApiClient.getData(url);

    // Handle response
    if (response.statusCode == 200) {
      getAllManagerContractModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllManagerContractModel.fromJson(x)));
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
  RxList<String> file = <String>[].obs;

  Future<void> pickAttachemtFromDevice() async {
    try {
      final List<XFile>? returnFiles = await picker.pickMultipleMedia();

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

        // If it's a file (PDF, DOCX, XLSX), add it to the file list
      if (fileExtension == 'pdf' || fileExtension == 'docx' || fileExtension == 'doc' || fileExtension == 'xls' || fileExtension == 'xlsx') {
          file.value.add(img.path);
        } else {
          print("Invalid file format: $fileExtension for file ${img.path}");
          Get.snackbar(
            "Invalid File Format",
            "File '${img.name}' is not a valid format. Allowed formats: JPG, PNG, PDF, DOCX, XLSX.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }

      file.refresh();
    } catch (e) {

      print("Error while picking files: $e");
      Get.snackbar(
        "Error",
        "An error occurred while selecting files. Please try again.",
        colorText: Colors.red,
        backgroundColor: Colors.white,
      );
    }
  }


  removeFile(int index) {
    file.removeAt(index);
    refresh();
  }


  //====================>> Manger Task Create

  managerContractCreate({required String projectId}) async{
    isLoading(true);

    List<MultipartBody> multipartAttachments = [];

    // Add multiple files (PDF, DOCX, XLSX) to multipartList
    for (String filePath in file) {
      multipartAttachments.add(MultipartBody("attachments", File(filePath)));
    }


    Map<String, String> body = {
      "projectId": projectId,
    };

    var response = await ApiClient.postMultipartFileData(
      ApiConstants.managerContarctCreateEndPoint, body,
      multipartBody: multipartAttachments,
    );
    // Handle response
    if (response.statusCode == 200) {
      isLoading(false);
      Get.back();
      Get.snackbar('Successfully', response.body['message']);
      update();
      clearFile();
    }  if (response.statusCode == 400) {
      isLoading(false);
      Get.snackbar('Error', response.body['message']);

    }
    else {
      ApiChecker.checkApi(response);
      update();
    }

  }


  void clearFile(){
    file.clear();
  }
}


