import 'dart:io';

import 'package:aim_construction/app/controller/projectNote_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class AddNewNoteScreen extends StatefulWidget {
  AddNewNoteScreen({super.key});

  @override
  State<AddNewNoteScreen> createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final ProjectNoteController projectNoteController = Get.put(ProjectNoteController());
  String projectId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      projectId = await PrefsHelper.getString(AppConstants.projectID);
      setState(() {});
      print("Project Id : $projectId");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          "Add new note",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Name Section
            Text('Add note name', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
            TextField(
              controller: projectNoteController.noteName,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            SizedBox(height: 16.h),

            // Description Section
            Text('Add Description', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
            TextField(
              controller: projectNoteController.noteDescription,
              maxLines: 3,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
            SizedBox(height: 16.h),

            // File Attachments Section
            _buildFileAttachments(),

            const Spacer(),
            Obx((){
              return CustomButton(
                loading: projectNoteController.isLoading.value,
                  onTap: () {
                    projectNoteController.supervisorNewNoteCreate(projectId: projectId);
              }, text: 'Save');
            }

            ),

            // Save Button Section
          ],
        ),
      ),
    );
  }

  // File Attachments Section
  Widget _buildFileAttachments() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Attachment', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
              InkWell(
                onTap: _showTakeFileDialog,
                child: SvgPicture.asset(AppIcons.attachmentIcon, height: 35.h),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.attachmentIcon, height: 18.h),
              SizedBox(width: 4.w),
              Obx(() => Text("${projectNoteController.file.length}", style: AppStyles.fontSize16(color: AppColors.color323B4A))),
              SizedBox(width: 16.w),
              SvgPicture.asset(AppIcons.imageIcon, height: 16.h, color: AppColors.color323B4A),
              SizedBox(width: 4.w),
              Obx(() => Text("${projectNoteController.images.length}", style: AppStyles.fontSize16(color: AppColors.color323B4A))),
            ],
          ),
          Obx(() => projectNoteController.file.isNotEmpty
              ? ListView.builder(
            itemCount: projectNoteController.file.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final fileName = path.basename(projectNoteController.file[index]);
              return Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    FileUtils.getFileIcon(projectNoteController.file[index]),
                    SizedBox(width: 8),
                    Text(fileName, style: AppStyles.fontSize16(color: AppColors.color323B4A)),
                    GestureDetector(
                      onTap: () {
                        projectNoteController.removeFile(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.close, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
              : SizedBox()),
          SizedBox(height: 8.h),
          Obx(() => projectNoteController.images.isNotEmpty
              ? Container(
            height: 130.h,
            child: ListView.builder(
              itemCount: projectNoteController.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Container(
                        height: 73.h,
                        width: 73.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          image: DecorationImage(image: FileImage(File(projectNoteController.images[index])), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        projectNoteController.removeImage(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 5),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.close, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
              : SizedBox()),
        ],
      ),
    );
  }

  // Show dialog to select files
  void _showTakeFileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add attachment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      projectNoteController.pickFileFromDevice();
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppIcons.imageIcon, height: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Select Attachment", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
