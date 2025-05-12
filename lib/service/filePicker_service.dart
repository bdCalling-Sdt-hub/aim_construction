import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {

  //================ file pick
  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xlsx'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.single.name;
    }
    return null; // Return null if no file was selected
  }

}
