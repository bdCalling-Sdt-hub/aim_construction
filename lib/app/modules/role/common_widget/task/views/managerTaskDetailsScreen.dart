import 'package:aim_construction/app/controller/projectTask_controller.dart';
import 'package:aim_construction/common/helper/time_formate.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ManagerTaskDetailsScreen extends StatefulWidget {
  const ManagerTaskDetailsScreen({super.key});

  @override
  _ManagerTaskDetailsScreenState createState() => _ManagerTaskDetailsScreenState();
}

class _ManagerTaskDetailsScreenState extends State<ManagerTaskDetailsScreen> {
  final ProjectTaskController projectTaskController = Get.put(ProjectTaskController());
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String taskID = '${parameter['taskID']}';
      print('Fetching Task details for ID: $taskID');
      projectTaskController.getTaskDetailsByID(taskID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600, color: AppColors.color323B4A),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Obx(() {
        var displayData = projectTaskController.getTaskDetailByIdModel.value;
        if (projectTaskController.isLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(
              radius: 32.r,
              color: AppColors.primaryColor,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
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
                    Text('Task Status: ${displayData.taskStatus?.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Assign to: ${displayData.assignedTo?.fname} ${displayData.assignedTo?.lname}', style: TextStyle(fontWeight: FontWeight.bold)),

                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Text('Due Date: ',style: AppStyles.fontSize16(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Icon(Icons.calendar_month,size: 20.sp),
                  SizedBox(width: 8.w),
                  Text('${TimeFormatHelper.formatDateWithDay((DateTime.parse(displayData.dueDate.toString())))}'),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  children: [
                    Text('Titel',style: AppStyles.fontSize16(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Text('${displayData.title}',style:  AppStyles.fontSize18()),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  children: [
                    Text('Description',style: AppStyles.fontSize16(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Text('${displayData.description}', style:  AppStyles.fontSize18()),

              SizedBox(height: 20.h),
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
                            child: CachedNetworkImage(
                              imageUrl: fileUrl.toString(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CupertinoActivityIndicator(radius: 10.r, color: AppColors.primaryColor),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
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
              SizedBox(height: 16.h),

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
            padding: EdgeInsets.all(20.h),
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
