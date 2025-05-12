import 'package:aim_construction/app/controller/projectNote_controller.dart';
import 'package:aim_construction/common/helper/time_formate.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ManagerNoteAcceptScreen extends StatefulWidget {
  @override
  State<ManagerNoteAcceptScreen> createState() => _ManagerNoteAcceptScreenState();
}

class _ManagerNoteAcceptScreenState extends State<ManagerNoteAcceptScreen> {


  final ProjectNoteController projectNoteController = Get.put(ProjectNoteController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String noteId = '${parameter['noteId']}';
      print('Fetching note details for ID: $noteId');
      projectNoteController.getNoteDetailsByID(noteId);
    });
  }

  void _showImagePreview(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View report'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        var displayData = projectNoteController.getNoteDetailByIdModel.value;
        if (projectNoteController.isLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 32.r,
              color: AppColors.primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Project Status: ${displayData.isAccepted?.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Project name: ${displayData.projectId?.projectName}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Address: ${displayData.projectId?.streetAddress}, ${displayData.projectId?.city} - ${displayData.projectId?.zipCode} ${displayData.projectId?.country}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Date: ${TimeFormatHelper.formatDateWithDay((DateTime.parse(displayData.createdAt.toString())))}'),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ', style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
                    Text('${displayData.title}', style: AppStyles.fontSize16()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ', style: AppStyles.fontSize20(fontWeight: FontWeight.w600)),
                    Text('${displayData.description}', style: AppStyles.fontSize16()),
                  ],
                ),
              ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: displayData.attachments?.where((attachment) => attachment?.attachmentType == 'image').length ?? 0, // Only count image attachments
              itemBuilder: (context, index) {
                final imageAttachments = displayData.attachments?.where((attachment) => attachment?.attachmentType == 'image').toList();
                if (imageAttachments != null && imageAttachments.isNotEmpty) {
                  final fileUrl = imageAttachments[index].attachment ?? '';
                  return Padding(
                    padding: EdgeInsets.all(8.r),
                    child: InkWell(
                      onTap: () => showImagePreview(fileUrl ?? ''),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.primaryColor)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            fileUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            color: Colors.transparent,
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  );
                }  else {
                  return SizedBox.shrink();
                }
              },
            ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayData.attachments?.length ?? 0,
                itemBuilder: (context, index) {
                  final attachment = displayData.attachments?[index];
                  final fileUrl = attachment?.attachment ?? '';
                  final attachmentType = attachment?.attachmentType ?? '';
                  if (attachmentType == 'document') {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Row(
                            children: [
                              // Display PDF icon for documents
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
                  }

                  return SizedBox.shrink();
                },
              ),

              SizedBox(height: 16),
            
              // Button at the bottom
              Row(
                children: [
                  // Show both buttons if status is 'pending'
                  if (displayData.isAccepted == 'pending') ...[
                    Expanded(
                      child: CustomButton(
                        loading: projectNoteController.acceptLoading.value,
                        onTap: () async {
                          await projectNoteController.noteStatusChnage(
                            noteID: '${parameter['noteId']}',
                            actionStatus: 'accepted',
                          );
                          String noteId = '${parameter['noteId']}';
                          await projectNoteController.getNoteDetailsByID(noteId);
                          setState(() {});
                        },
                        text: 'Accept',
                        color: AppColors.greenColor,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomButton(
                        loading: projectNoteController.deniedLoading.value,
                        onTap: () async {
                          await projectNoteController.noteStatusDenied(
                            noteID: '${parameter['noteId']}',
                            actionStatus: 'denied',
                          );
                          String noteId = '${parameter['noteId']}';
                          await projectNoteController.getNoteDetailsByID(noteId);
                          setState(() {});
                        },
                        text: 'Denied',
                        color: AppColors.redColor,
                      ),
                    ),
                  ]
                  // Show only Denied button if status is 'accepted'
                  else if (displayData.isAccepted == 'accepted') ...[
                    Expanded(
                      child: CustomButton(
                        loading: projectNoteController.deniedLoading.value,
                        onTap: () async {
                          await projectNoteController.noteStatusDenied(
                            noteID: '${parameter['noteId']}',
                            actionStatus: 'denied',
                          );
                          String noteId = '${parameter['noteId']}';
                          await projectNoteController.getNoteDetailsByID(noteId);
                          setState(() {});
                        },
                        text: 'Denied',
                        color: AppColors.redColor,
                      ),
                    ),
                  ]
                  // Show only Accept button if status is 'denied'
                  else if (displayData.isAccepted == 'denied') ...[
                      Expanded(
                        child: CustomButton(
                          loading: projectNoteController.acceptLoading.value,
                          onTap: () async {
                            await projectNoteController.noteStatusChnage(
                              noteID: '${parameter['noteId']}',
                              actionStatus: 'accepted',
                            );
                            String noteId = '${parameter['noteId']}';
                            await projectNoteController.getNoteDetailsByID(noteId);
                            setState(() {});
                          },
                          text: 'Accept',
                          color: AppColors.greenColor,
                        ),
                      ),
                    ],
                ],
              )



            ],
          ),
        );
      }),
    );
  }
  void showImagePreview(String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
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
                Row(
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
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.redColor,
                        ),
                        child: SvgPicture.asset(AppIcons.deletedIcon),
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
