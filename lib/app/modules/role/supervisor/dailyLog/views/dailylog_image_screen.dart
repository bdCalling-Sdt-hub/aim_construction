import 'dart:io';
import 'package:aim_construction/app/controller/supervisor_dailyLog_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;


class DailyLogImageScreen extends StatefulWidget {
  const DailyLogImageScreen({super.key});

  @override
  State<DailyLogImageScreen> createState() => _DailyLogImageScreenState();
}

class _DailyLogImageScreenState extends State<DailyLogImageScreen> {
  final SupervisorDailyLogController supervisorDailyLogController = Get.put(SupervisorDailyLogController());
  String projectId = '';
  String selectDate = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    projectId = await PrefsHelper.getString(AppConstants.projectID);
    setState(() {
      selectDate = supervisorDailyLogController.selectedDate.value;
    });
    _fetchData();
    ever(supervisorDailyLogController.selectedDate, (callback) {
      _fetchData();
    });
  }

  void _fetchData() {
    supervisorDailyLogController.getAllImageOrDocumentUnderNote(
      projectId: projectId,
      date: selectDate,
      noteOrTaskOrProject: 'note',
      imageOrDocument: 'image',
      uploaderRole: 'projectSupervisor',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (supervisorDailyLogController.isLoading.value) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 32.r,
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                if (supervisorDailyLogController.getAllImageOrDocumentUnderNoteModel.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.noData, height: 200.h),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Text(
                            'No project image available now.',
                            style: AppStyles.fontSize20(color: AppColors.hintColor),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: supervisorDailyLogController.getAllImageOrDocumentUnderNoteModel.map((group) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              group.date ?? '',
                              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.color323B4A),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: group.attachments?.length ?? 0,
                            itemBuilder: (context, index) {
                              final imageUrl = group.attachments?[index].attachment;
                              return GestureDetector(
                                onTap: () => _showImagePreview(imageUrl ?? ''),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl ?? '',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: CupertinoActivityIndicator(radius: 10.r, color: AppColors.primaryColor),
                                    ),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTakeFileDialog();
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Show dialog to select files
  void _showTakeFileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    supervisorDailyLogController.pickImageFromDevice();
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
                        Text(
                          "Select Image",
                          style: TextStyle(color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Obx(() => supervisorDailyLogController.images.isNotEmpty
                    ? ListView.builder(
                  itemCount: supervisorDailyLogController.images.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final fileName = path.basename(supervisorDailyLogController.images[index]);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          FileUtils.getFileIcon(supervisorDailyLogController.images[index]),
                          SizedBox(width: 8),
                          Text(fileName, style: AppStyles.fontSize16(color: AppColors.color323B4A)),
                          GestureDetector(
                            onTap: () {
                              supervisorDailyLogController.removeImage(index);
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
                Row(
                  children: [
                    Expanded(child: CustomButton(
                        color: AppColors.orange,
                        onTap: (){
                          Get.back();
                        }, text: 'Cancel')),

                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomButton(
                        onTap: () async {
                          await supervisorDailyLogController.addNewImage(projectId: projectId);
                        },
                        text: 'Upload',
                      ),
                    )

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Show Image Preview Dialog
  void _showImagePreview(String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  image,
                  width: 350.w,
                  height: 500.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16.h),
                /*Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.redColor,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30.sp,
                          color: AppColors.color323B4A,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.redColor,
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 30.sp,
                          color: AppColors.color323B4A,
                        ),
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
