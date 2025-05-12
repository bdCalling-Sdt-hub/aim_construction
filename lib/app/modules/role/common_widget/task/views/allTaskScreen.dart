import 'package:aim_construction/app/controller/projectTask_controller.dart';
import 'package:aim_construction/app/modules/role/common_widget/task/views/taskCard.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/helper/time_formate.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProjectAllTaskScreen extends StatefulWidget {
  ProjectAllTaskScreen({super.key});

  @override
  State<ProjectAllTaskScreen> createState() => _ProjectAllTaskScreenState();
}

class _ProjectAllTaskScreenState extends State<ProjectAllTaskScreen> {

  final ProjectTaskController projectTaskController = Get.put(ProjectTaskController());
  TextEditingController textEditingController = TextEditingController();
  String? projectId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      projectId = await PrefsHelper.getString(AppConstants.projectID);
      if (projectId != null) {
        projectTaskController.getAllProjectTaskDetails(projectId: projectId!);
      }
    });

    textEditingController.addListener(() {
      String searchText = textEditingController.text;
      if (searchText.isEmpty) {
        if (projectId != null) {
          projectTaskController.getAllProjectTaskDetails(projectId: projectId!);
        }
      } else {
        if (projectId != null) {
          projectTaskController.getAllProjectTaskDetails(
            projectId: projectId!,
            title: searchText,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.r),
                  child: CustomTextField(
                    controller: textEditingController,
                    hintText: "Search",
                  ),
                ),
                SizedBox(height: 16.h),
                if (projectTaskController.isLoading.value)
                  Center(
                    child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),)
                else if (projectTaskController.projectTaskDetailsModel.value.isEmpty)
                // Show message when no projects are available
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.noData,height: 200.h),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Text(
                            'No project task available now.',
                            style: AppStyles.fontSize20(color: AppColors.hintColor),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projectTaskController.projectTaskDetailsModel.value.length,
                  itemBuilder: (context, index) {
                    final projectTaskDetails = projectTaskController.projectTaskDetailsModel.value[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            String userRole = await PrefsHelper.getString(AppConstants.role);
                            if (userRole == Role.projectSupervisor.name) {
                              Get.toNamed(AppRoutes.supervisorTaskDetailsScreen, parameters:  {
                                "taskID": projectTaskDetails.id ?? '',
                              }
                              );
                            }
                            else if (userRole == Role.projectManager.name) {
                              Get.toNamed(AppRoutes.managerTaskDetailsScreen,parameters:  {
                                "taskID": projectTaskDetails.id ?? '',
                              }
                              );
                            }
                            print('User Role: $userRole');
                          },
                          child: TaskCard(
                            noteTitel: projectTaskDetails.title ?? 'No Title',
                            noteDiscreiption: projectTaskDetails.description ?? 'No Description',
                            doumentCount: projectTaskDetails.documentCount ?? 0,
                            imageCount: projectTaskDetails.imageCount ?? 0,
                            authorName: projectTaskDetails.assignedTo?.fname ?? 'N/A',
                            date: '${TimeFormatHelper.formatDate(DateTime.parse(projectTaskDetails.createdAt.toString()))}',
                            onTap: () {
                              print('Card tapped');
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
