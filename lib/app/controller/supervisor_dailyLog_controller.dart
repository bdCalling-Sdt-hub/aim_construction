import 'dart:io';

import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/model/getAllImageOrDocumentUnderNoteModel.dart';
import 'package:aim_construction/app/model/getNoteByDate_model.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';



class SupervisorDailyLogController extends GetxController {
  var isLoading = false.obs;

  var noteCount=''.obs;
  var imageCount=''.obs;
  var documentCount=''.obs;
  RxString selectedDate = ''.obs ;


//=================== Daily Log By Date and Project Id Get all Note ====================
  RxList<GetAllNoteByDateModel> getAllNoteByDateModel = <GetAllNoteByDateModel>[].obs;


 getNoteByDate({String? projectId, String? date}) async {

   isLoading(true);
   List<String> queryParams = [];
   if (projectId != null) queryParams.add('projectId=$projectId');
   if (date != null) queryParams.add('date=$date');
   var url = ApiConstants.supervisorNoteByDateEndPoint;

   if (queryParams.isNotEmpty) {
     url +='?${queryParams.join('&')}';
   }

   var response = await ApiClient.getData(url);
    if (response.statusCode == 200) {
      getAllNoteByDateModel.value = List.from(response.body['data']['attributes']['notes'].map((x) => GetAllNoteByDateModel.fromJson(x)));
      isLoading(false);

      imageCount.value= response.body['data']['attributes']['imageCount'].toString();
      documentCount.value= response.body['data']['attributes']['documentCount'].toString();
      noteCount.value= response.body['data']['attributes']['totalNoteCount'].toString();



      update();
    }
    else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }



  //=============================================>> Get Image/Document under date <<=========================

  RxList<GetAllImageOrDocumentUnderNoteModel> getAllImageOrDocumentUnderNoteModel = <GetAllImageOrDocumentUnderNoteModel>[].obs;
  var dateOfData=''.obs;

  getAllImageOrDocumentUnderNote({
    String? projectId,
    String? date,
    String? noteOrTaskOrProject,
    String? imageOrDocument,
    String? uploaderRole,
  }) async {

    isLoading(true);
    List<String> queryParams = [];
    if (projectId != null) queryParams.add('projectId=$projectId');
    if (date != null) queryParams.add('date=$date');
    if (noteOrTaskOrProject != null) queryParams.add('noteOrTaskOrProject=$noteOrTaskOrProject');
    if (imageOrDocument != null) queryParams.add('imageOrDocument=$imageOrDocument');
    if (uploaderRole != null) queryParams.add('uploaderRole=$uploaderRole');

    var url = ApiConstants.getAllImagesOfAllNotesEndPoint;

    if (queryParams.isNotEmpty) {
      url +='?${queryParams.join('&')}';
    }

    var response = await ApiClient.getData(url);
    if (response.statusCode == 200) {
      getAllImageOrDocumentUnderNoteModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllImageOrDocumentUnderNoteModel.fromJson(x)));
      isLoading(false);
      dateOfData.value= response.body['data']['attributes']['date'];


      update();
    }
    else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }

  //  =========================== Image upload
  ImagePicker picker = ImagePicker();
  RxList<String> images = <String>[].obs;

  Future<void> pickImageFromDevice() async {
    try {
      final List<XFile>? returnFiles = await picker.pickMultiImage();
      if (returnFiles == null || returnFiles.isEmpty) {
        print("No files selected");
        Get.snackbar(
          "No Files Selected",
          "Please select valid image files (JPG, PNG)",
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }
      for (var img in returnFiles) {
        final fileExtension = img.path.split('.').last.toLowerCase();

        // Validate file extensions
        if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
          images.add(img.path);
        } else {
          // Handle invalid file formats
          print("Invalid file format: $fileExtension for file ${img.path}");
          Get.snackbar(
            "Invalid File Format",
            "File '${img.name}' is not a valid format. Allowed formats: JPG, PNG",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }

      // Refresh images list
      images.refresh();

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


  //===============================>>> Upload Image <<<<<===================================
addNewImage({required String projectId}) async{
  List<MultipartBody> multipartAttachments = [];

  for (String filePath in images) {
    multipartAttachments.add(MultipartBody("attachments", File(filePath)));
  }


  Map<String, String> body = {
    "projectId": projectId,
    "noteOrTaskOrProject": 'note',
  };

  var response = await ApiClient.postMultipartFileData(
    ApiConstants.daliyLogImageOrDocumentUploadEndPoint, body,
    multipartBody: multipartAttachments,
  );
  if (response.statusCode == 200) {
    Get.back();
    Get.snackbar('Successfully', 'Uploaded Image');
    update();
    clearFile();
  }  if (response.statusCode == 400) {
    Get.snackbar('Error', 'Attachment is required.');

  }
  else {
    ApiChecker.checkApi(response);
    update();
  }

}


  void clearFile(){
    images.clear();
  }


  //================= pickFileFromDevice
  RxList<String> documents = <String>[].obs;

  Future<void> pickDocumentFromDevice() async {
    try {

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'ppt', 'xls'],
      );

      if (result == null || result.files.isEmpty) {
        print("No files selected");
        Get.snackbar(
          "No Files Selected",
          "Please select valid document files (PDF, DOCX, TXT, etc.)",
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
        return;
      }


      for (var file in result.files) {
        final fileExtension = file.extension?.toLowerCase();

        if (fileExtension == 'pdf' || fileExtension == 'doc' || fileExtension == 'docx' || fileExtension == 'txt' || fileExtension == 'ppt' || fileExtension == 'xls') {
          documents.add(file.path ?? '');
        } else {
          // Handle invalid file formats
          print("Invalid file format: $fileExtension for file ${file.name}");
          Get.snackbar(
            "Invalid File Format",
            "File '${file.name}' is not a valid format. Allowed formats: PDF, DOCX, TXT, etc.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }

      // Refresh documents list
      documents.refresh();

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

  removeDocument(int index) {
    documents.removeAt(index);
    refresh();
  }

  //===============================>>> Upload Image <<<<<===================================
  addNewAttachedFile({required String projectId}) async{
    List<MultipartBody> multipartAttachments = [];

    for (String filePath in documents) {
      multipartAttachments.add(MultipartBody("attachments", File(filePath)));
    }


    Map<String, String> body = {
      "projectId": projectId,
      "noteOrTaskOrProject": 'note',
    };

    var response = await ApiClient.postMultipartFileData(
      ApiConstants.daliyLogImageOrDocumentUploadEndPoint, body,
      multipartBody: multipartAttachments,
    );
    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar('Successfully', 'Uploaded File');
      clearuploadedFile();
      update();
    }  if (response.statusCode == 400) {
      Get.snackbar('Error', 'Attachment is required.');

    }
    else {
      ApiChecker.checkApi(response);
      update();
    }

  }


  void clearuploadedFile(){
    documents.clear();
  }

}


