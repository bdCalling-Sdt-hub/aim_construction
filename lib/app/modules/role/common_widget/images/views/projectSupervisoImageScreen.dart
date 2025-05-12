import 'package:aim_construction/app/controller/image_and_document_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProjectSupervisorImageScreen extends StatefulWidget {
  const ProjectSupervisorImageScreen({super.key});

  @override
  State<ProjectSupervisorImageScreen> createState() =>
      _ProjectSupervisorImageScreenState();
}

class _ProjectSupervisorImageScreenState extends State<ProjectSupervisorImageScreen> {

  final ProjectImageAndDocumentController projectImageAndDocumentController = Get.put(ProjectImageAndDocumentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var projectId = await PrefsHelper.getString(AppConstants.projectID);
      projectImageAndDocumentController.getAllImageAndDocument(
        projectId: projectId,
        imageOrDocument: 'image',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (projectImageAndDocumentController.isLoading.value) {
                  // Show loading indicator while the data is loading
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
                    children: projectImageAndDocumentController.getAllImageAndDocumentModel.map((group) {
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
                                onTap: () => _showImagePreview(imageUrl.toString()),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl.toString(),
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
    );
  }

  // Function to handle image click (show preview dialog)
  void _showImagePreview(String? image) {
    if (image == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.r),
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
               /* Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back();
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
                          _deleteImage(image);
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.redColor,
                        ),
                        child: SvgPicture.asset(AppIcons.deletedIcon,color: Colors.black),
                      ),
                    )
                  ],
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to delete the selected image
  void _deleteImage(String image) {
    projectImageAndDocumentController.getAllImageAndDocumentModel.forEach((group) {
      group.attachments?.remove(image);
    });
  }
}
