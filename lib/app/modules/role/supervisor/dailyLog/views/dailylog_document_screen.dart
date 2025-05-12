import 'package:aim_construction/app/controller/supervisor_dailyLog_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path/path.dart' as path;

class DailyLogDocumentScreen extends StatefulWidget {
  DailyLogDocumentScreen({super.key});

  @override
  State<DailyLogDocumentScreen> createState() => _DailyLogDocumentScreenState();
}

class _DailyLogDocumentScreenState extends State<DailyLogDocumentScreen> {
  final SupervisorDailyLogController supervisorDailyLogController = Get.put(SupervisorDailyLogController());

  String projectId = '';
  String selectDate = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Loading projectId and image data
  void _loadData() async {
    projectId = await PrefsHelper.getString(AppConstants.projectID);
    setState(() {
      selectDate = supervisorDailyLogController.selectedDate.value;
    });
    _fetchData();
  }

  void _fetchData() {
    supervisorDailyLogController.getAllImageOrDocumentUnderNote(
      projectId: projectId,
      date: selectDate,
      noteOrTaskOrProject: 'note',
      imageOrDocument: 'document',
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

                // Show content when loading is complete
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
                            'No project document available now.',
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                group.date ?? '',
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.color323B4A),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: group.attachments?.length ?? 0,
                              itemBuilder: (context, index) {
                                final imageUrl = group.attachments?[index].attachment ?? '';
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Row(
                                        children: [
                                          FileUtils.getFileIcon(imageUrl),
                                          SizedBox(width: 8.w),
                                          FileUtils.getFileName(imageUrl),
                                        ],
                                      ),
                                    ),
                                    SvgPicture.asset(AppIcons.downloadIcon),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
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
                  "Add new Attchement",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    supervisorDailyLogController.pickDocumentFromDevice();
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
                          "Select Attchement",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() {
                  if (supervisorDailyLogController.documents.isNotEmpty) {
                    return ListView.builder(
                      itemCount: supervisorDailyLogController.documents.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final fileName = path.basename(supervisorDailyLogController.documents[index]);
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              FileUtils.getFileIcon(supervisorDailyLogController.documents[index]),
                              SizedBox(width: 8),
                              Text(fileName, style: AppStyles.fontSize16(color: AppColors.color323B4A)),
                              GestureDetector(
                                onTap: () {
                                  supervisorDailyLogController.removeDocument(index);
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
                    );
                  } else {
                    return SizedBox();
                  }
                }),
                Row(
                  children: [
                    Expanded(child: CustomButton(
                        color: AppColors.orange,
                        onTap: () {
                          Get.back();
                        },
                        text: 'Cancel')),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomButton(
                        onTap: () async {
                          await supervisorDailyLogController.addNewAttachedFile(projectId: projectId);
                        },
                        text: 'Upload',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

