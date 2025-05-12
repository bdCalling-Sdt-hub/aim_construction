import 'package:aim_construction/app/controller/supervisor_dailyLog_controller.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/innerWidget/note_card_widget.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DailyLogNoteScreen extends StatefulWidget {
  DailyLogNoteScreen({super.key});

  @override
  State<DailyLogNoteScreen> createState() => _DailyLogNoteScreenState();
}

class _DailyLogNoteScreenState extends State<DailyLogNoteScreen> {
  final SupervisorDailyLogController supervisorDailyLogController = Get.put(SupervisorDailyLogController());
  String projectId = '';
  String selectDate = '';

  @override
  void initState() {
    super.initState();
    // Get projectId from preferences
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      projectId = await PrefsHelper.getString(AppConstants.projectID);
      setState(() {});

      // Initialize the selected date and fetch the notes for the selected date
      selectDate = supervisorDailyLogController.selectedDate.value;
      supervisorDailyLogController.getNoteByDate(projectId: projectId, date: selectDate);

      print("Project Id : $projectId");
      print("Controller select date : $selectDate");
    });

    ever(supervisorDailyLogController.selectedDate, (callback) {
      supervisorDailyLogController.getNoteByDate(projectId: projectId, date: supervisorDailyLogController.selectedDate.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Obx(() {
                // Check loading status
                if (supervisorDailyLogController.isLoading.value) {
                  return Center(
                    child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),
                  );
                } else if (supervisorDailyLogController.getAllNoteByDateModel.value.isEmpty) {
                  // Show message when no notes are available
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.noData, height: 200.h),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Text(
                            'No project note available now.',
                            style: AppStyles.fontSize20(color: AppColors.hintColor),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Display the notes
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: supervisorDailyLogController.getAllNoteByDateModel.value.length,
                    itemBuilder: (context, index) {
                      final noteDetails = supervisorDailyLogController.getAllNoteByDateModel.value[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.dailyNoteDetailsScreen,parameters:  {
                                "noteId": noteDetails.id ?? '',
                              }

                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: NoteCard(
                                title: noteDetails.title ?? 'N/A',
                                description: noteDetails.description ?? 'N/A',
                                status: noteDetails.isAccepted?.toUpperCase() ?? 'N/A',
                                documentCount: noteDetails.documentCount ?? 0,
                                imageCount: noteDetails.imageCount ?? 0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addNewNoteScreen);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
