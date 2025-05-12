import 'package:aim_construction/app/controller/image_and_document_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
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
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class ProjectSupervisorDoumentScreen extends StatefulWidget {
  const ProjectSupervisorDoumentScreen({super.key});

  @override
  State<ProjectSupervisorDoumentScreen> createState() => _ProjectSupervisorDoumentScreenState();
}

class _ProjectSupervisorDoumentScreenState extends State<ProjectSupervisorDoumentScreen> {
  final ProjectImageAndDocumentController projectImageAndDocumentController = Get.put(ProjectImageAndDocumentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var projectId = await PrefsHelper.getString(AppConstants.projectID);
      projectImageAndDocumentController.getAllImageAndDocument(
        projectId: projectId,
        imageOrDocument: 'document',
        uploaderRole: 'projectSupervisor',
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
              children:[
                Obx(() {
                  if (projectImageAndDocumentController.isLoading.value) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 32.r,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  // Show content when loading is complete
                  if (projectImageAndDocumentController.getAllImageAndDocumentModel.isEmpty) {
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
                      children: projectImageAndDocumentController.getAllImageAndDocumentModel.map((group) {
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
                                  final fileUrl = group.attachments?[index].attachment ?? '';
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Row(
                                          children: [
                                            FileUtils.getFileIcon(fileUrl), 
                                            SizedBox(width: 8.w),
                                            FileUtils.getFileName(fileUrl),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: ()  {
                                            FileUtils.downloadFile(fileUrl);
                                          },
                                          child: SvgPicture.asset(AppIcons.downloadIcon)),
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
              ]
          ),
        ),
      ),
    );
  }
}

