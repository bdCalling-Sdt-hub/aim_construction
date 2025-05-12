import 'package:aim_construction/app/controller/manager_contarct_controller.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/service/filePicker_service.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path/path.dart' as path;


class ManagerContactScreen extends StatefulWidget {
  const ManagerContactScreen({super.key});

  @override
  State<ManagerContactScreen> createState() => _ManagerContactScreenState();
}

class _ManagerContactScreenState extends State<ManagerContactScreen> {
  ManagerContarctController managerContarctController = Get.put(ManagerContarctController());

  String projectId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      projectId = await PrefsHelper.getString(AppConstants.projectID);
      setState(() {});
      print("Project Id : $projectId");
      managerContarctController.getAllManagerContractDetails();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Contract',
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
              children:[
                Obx(() {
                  if (managerContarctController.isLoading.value) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: 32.r,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  // Show content when loading is complete
                  if (managerContarctController.getAllManagerContractModel.isEmpty) {
                    return Center(
                      child: Text(
                        'No Contact available',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.color323B4A,
                        ),
                      ),
                    );
                  } else {
                    return Obx((){
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: managerContarctController.getAllManagerContractModel.map((group) {
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

                                    final innerAttachments = group.attachments?[index].attachments;

                                    final fileUrl = (innerAttachments != null && innerAttachments.isNotEmpty) ? innerAttachments[0].attachment : '';

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.r),
                                          child: Row(
                                            children: [
                                              FileUtils.getFileIcon(fileUrl!),
                                              SizedBox(width: 8.w),
                                              FileUtils.getFileName(fileUrl!)
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(AppIcons.downloadIcon),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }
                    );
                  }
                }),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTakeFileDialog();
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add),
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
                  "Add a attachment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    managerContarctController.pickAttachemtFromDevice();
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
                        SvgPicture.asset(AppIcons.documentsIcon, height: 20.h,color: Colors.white),
                        SizedBox(width: 8.w),
                        Text(
                          "Select File",
                          style: TextStyle(color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                Obx(() => managerContarctController.file.isNotEmpty
                    ? ListView.builder(
                  itemCount: managerContarctController.file.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final fileName = path.basename(managerContarctController.file[index]);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          FileUtils.getFileIcon(managerContarctController.file[index]),
                          SizedBox(width: 8),
                          Text(fileName, style: AppStyles.fontSize16(color: AppColors.color323B4A)),
                          GestureDetector(
                            onTap: () {
                              managerContarctController.removeFile(index);
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
                    SvgPicture.asset(AppIcons.attachmentIcon, height: 18.h),
                    SizedBox(width: 4.w),
                    Obx(() => Text("${managerContarctController.file.length}", style: AppStyles.fontSize16(color: AppColors.color323B4A))),

                  ],
                ),
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
                        loading: managerContarctController.isLoading.value,
                        onTap: () async {
                          await managerContarctController.managerContractCreate(projectId: projectId);
                        },
                        text: 'Save',
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
}