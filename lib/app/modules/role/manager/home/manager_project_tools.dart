import 'package:aim_construction/app/controller/project_controller.dart';
import 'package:aim_construction/app/modules/role/supervisor/projectTool/views/toolsCard.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ManagerProjectToolsScreen extends StatefulWidget {
  const ManagerProjectToolsScreen({super.key});

  @override
  State<ManagerProjectToolsScreen> createState() => _ManagerProjectToolsScreenState();
}

class _ManagerProjectToolsScreenState extends State<ManagerProjectToolsScreen> {
  final ProjectController projectController = Get.put(ProjectController());

  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      //projectController.getAllProjectDetails(id: parameter['projectId']);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("${parameter['projectName']}"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Project Tool",
              style: AppStyles.fontSize16(
                  color: AppColors.color323B4A, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.w,
                  mainAxisSpacing: 30.h,
                ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToolsCard(
                        title: 'Daily Logs',
                        icon: AppIcons.daliyLogs,
                        onTap: () {
                          Get.toNamed(AppRoutes.managerDailyLogScreen,
                              parameters: {
                                "projectName": parameter['projectName'] ?? '',
                              }
                          );
                        },
                      ),
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToolsCard(
                        title: 'Task',
                        icon: AppIcons.taskIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.taskViewScreen);
                        },
                      ),
                    );
                  } else if (index == 2) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToolsCard(
                        title: 'Image',
                        icon: AppIcons.imageIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.projectImagers);
                        },
                      ),
                    );
                  } else if (index == 3) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToolsCard(
                        title: 'Document',
                        icon: AppIcons.documentsIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.supervisorDocuments);
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ToolsCard(
                        title: 'Contract',
                        icon: AppIcons.contractIcon,
                        onTap: () {
                          Get.toNamed(AppRoutes.managerContactScreen);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

