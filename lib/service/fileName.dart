import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {

  static SvgPicture getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return SvgPicture.asset(AppIcons.pdfIcon);
    } else if (fileName.endsWith('.xlsx') || fileName.endsWith('.xls')) {
      return SvgPicture.asset(AppIcons.excelFileIcon, height: 20.h);
    } else if (fileName.endsWith('.docx') || fileName.endsWith('.doc')) {
      return SvgPicture.asset(AppIcons.documentsIcon, height: 20.h, color: Colors.black87);
    }
    else if (fileName.endsWith('.png') || fileName.endsWith('.jpg')) {
      return SvgPicture.asset(AppIcons.imageIcon, height: 20.h, color: Colors.black87);
    }
    else {
      return SvgPicture.asset(AppIcons.documentsIcon, height: 20.h, color: Colors.black87);
    }
  }





  static Widget getFileName(String url) {
    final uri = Uri.parse(url);  // Parse the URL
    final fileName = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
    final shortFileName = fileName.length > 30 ? fileName.substring(fileName.length - 30) : fileName;
    return Text(shortFileName);
  }


  static Future<void> downloadFile(String fileUrl) async {
    try {
      final fileName = fileUrl.split('/').last;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      Dio dio = Dio();
      await dio.download(fileUrl, filePath);

      print('File downloaded to $filePath');

      if (await File(filePath).exists()) {
        print("Opening the file...");
        await OpenFile.open(filePath);
      }

    } catch (e) {
      print('Error downloading file: $e');
    }
  }
  static Future<void> downloadFile2(String fileUrl) async {
    try {
      final fileName = fileUrl.split('/').last;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      Dio dio = Dio();
      await dio.download(fileUrl, filePath);

      print('File downloaded to $filePath');
    } catch (e) {
      print('Error downloading file: $e');
    }
  }



}


