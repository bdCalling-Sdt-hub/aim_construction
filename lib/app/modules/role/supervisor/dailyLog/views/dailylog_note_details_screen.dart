import 'package:aim_construction/app/controller/projectNote_controller.dart';
import 'package:aim_construction/common/helper/time_formate.dart';
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


class DailyNoteDetailsScreen extends StatefulWidget {
  @override
  State<DailyNoteDetailsScreen> createState() => _DailyNoteDetailsScreenState();
}

class _DailyNoteDetailsScreenState extends State<DailyNoteDetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Note Section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
                    decoration: BoxDecoration(
                      color: displayData.isAccepted == 'pending'
                          ? AppColors.pendingStatusColor
                          : AppColors.greenColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${displayData.isAccepted?.toUpperCase()}',
                      style: AppStyles.fontSize14(color: AppColors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(TimeFormatHelper.formatDateWithDay(DateTime.parse(displayData.createdAt.toString())), style: TextStyle(color: Colors.grey),),
              SizedBox(height: 10.h),
              Text('${displayData.title ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5.h),
              Text('${displayData.description ?? 'N/A'}', style: TextStyle(fontSize: 14.sp),),
              SizedBox(height: 20.h),

              // Attachments Section
              Text('Attachments', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                itemCount: displayData.attachments?.where((attachment) => attachment.attachmentType == 'image').length ?? 0, // Only count image attachments
                itemBuilder: (context, index) {
                  final imageAttachments = displayData.attachments?.where((attachment) => attachment.attachmentType == 'image').toList();
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
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 2.h),
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
                  }

                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  // Function to handle image click (show preview dialog)
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
                        child: SvgPicture.asset(AppIcons.deletedIcon,color: Colors.white),
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
