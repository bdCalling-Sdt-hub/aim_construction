import 'dart:io';
import 'package:aim_construction/app/controller/projectTask_controller.dart';
import 'package:aim_construction/app/controller/profile_more_controller.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/service/fileName.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:intl/intl.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class ManagerTaskCreate extends StatefulWidget {
  const ManagerTaskCreate({Key? key}) : super(key: key);

  @override
  _ManagerTaskCreateState createState() => _ManagerTaskCreateState();
}

class _ManagerTaskCreateState extends State<ManagerTaskCreate> {
  final ProfileMoreController profileMoreController = Get.put(ProfileMoreController());
  final ProjectTaskController projectTaskController = Get.put(ProjectTaskController());
  String projectId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      profileMoreController.getAllSupervisorByManger();
      projectId = await PrefsHelper.getString(AppConstants.projectID);
      setState(() {});
      print("Project Id : $projectId");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Create New Task',
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600, color: AppColors.color323B4A),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assign Supervisor Dropdown
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text('Assign To', style: AppStyles.fontSize20(fontWeight: FontWeight.w600, color: AppColors.color323B4A)),
              ),
              _buildAssignToDropdown(),

              Text('Task Title', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
              SizedBox(height: 8.h),
              // Task Title Input Field
              CustomTextField(
                controller: projectTaskController.taskTitelCTRl,
                hintText: "Type here",
              ),
              SizedBox(height: 8.h),

              // Due Date
              Text('Due date', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
              SizedBox(height: 8.h),
              _buildDueDateField(),
              SizedBox(height: 20.h),

              // Task Description
              Text('Description', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
              SizedBox(height: 12.h),
              CustomTextField(
                maxLines: 3,
                controller: projectTaskController.taskDescriptionCTRl,
              ),
              SizedBox(height: 20.h),

              // File Attachments
              _buildFileAttachments(),
              SizedBox(height: 20.h),

              // Save Button
              Obx((){
                  return CustomButton(
                    loading: projectTaskController.isLoading.value,
                    onTap: () {
                      projectTaskController.managerTaskCreate(projectId: projectId);
                      print('Saving task with projectId: $projectId');
                    },
                    text: 'Save',
                  );
                }

              ),
            ],
          ),
        ),
      ),
    );
  }

  // Supervisor Dropdown
  Widget _buildAssignToDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        ),
        child: DropdownButtonHideUnderline(
          child: Obx(() {
            return DropdownButton<String>(
              value: projectTaskController.assignToSupervisor.isEmpty
                  ? null
                  : projectTaskController.assignToSupervisor.value,
              hint: Text(
                projectTaskController.assignToSupervisor.isEmpty
                    ? "Select Supervisor"
                    : projectTaskController.assignToSupervisor.value,
                style: AppStyles.fontSize16(color: AppColors.primaryColor),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColor),
              ),
              isExpanded: true,
              items: profileMoreController.getAllSupervisorByManagerModel.map((supervisor) {
                return DropdownMenuItem<String>(
                  value: supervisor.userId,
                  child: Text('${supervisor.fname} ${supervisor.lname}', style: AppStyles.fontSize18(color: AppColors.blackColor)),
                );
              }).toList(),
              onChanged: (newRole) {
                projectTaskController.assignToSupervisor.value = newRole ?? '';
              },
            );
          }),
        ),
      ),
    );
  }

  // Due Date Picker
  Widget _buildDueDateField() {
    return Row(
      children: [
        InkWell(
          onTap: _pickDueDate,
          child: SvgPicture.asset(AppIcons.calender, height: 25.h),
        ),
        SizedBox(width: 8.w),
        InkWell(
          onTap: _pickDueDate,
          child: Padding(
            padding:  EdgeInsets.all(8.r),
            child: Text(projectTaskController.selectedDate == null
                  ? 'Select Date'
                  : DateFormat('EEEE, dd MMMM, yyyy').format(projectTaskController.selectedDate!),
              style: AppStyles.fontSize16(color: AppColors.color323B4A),
            ),
          ),
        ),
      ],
    );
  }

  // File Attachments Section
  Widget _buildFileAttachments() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Attachment', style: AppStyles.fontSize16(color: AppColors.color323B4A)),
              InkWell(
                onTap: _showTakeFileDialog,
                child:  SvgPicture.asset(AppIcons.attachmentIcon, height: 35.h),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.attachmentIcon, height: 18.h),
              SizedBox(width: 4.w),
              Obx(() => Text("${projectTaskController.file.length}", style: AppStyles.fontSize16(color: AppColors.color323B4A))),
              SizedBox(width: 16.w),
              SvgPicture.asset(AppIcons.imageIcon, height: 16.h, color: AppColors.color323B4A),
              SizedBox(width: 4.w),
              Obx(() => Text("${projectTaskController.images.length}", style: AppStyles.fontSize16(color: AppColors.color323B4A))),
            ],
          ),
          Obx(() => projectTaskController.file.isNotEmpty
              ? ListView.builder(
            itemCount: projectTaskController.file.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final fileName = path.basename(projectTaskController.file[index]);
              return Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    FileUtils.getFileIcon(projectTaskController.file[index]),
                    SizedBox(width: 8),
                    Text(fileName, style: AppStyles.fontSize16(color: AppColors.color323B4A)),
                    GestureDetector(
                      onTap: () {
                        projectTaskController.removeFile(index);
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
          SizedBox(height: 8.h),
          Obx(() => projectTaskController.images.isNotEmpty
              ? Container(
            height: 130.h,
            child: ListView.builder(
              itemCount: projectTaskController.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Container(
                        height: 73.h,
                        width: 73.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          image: DecorationImage(image: FileImage(File(projectTaskController.images[index])), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        projectTaskController.removeImage(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 5),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.close, color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
              : SizedBox()),
        ],
      ),
    );
  }

  // Show File Dialog
  void _showTakeFileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add an attachment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      projectTaskController.pickFileFromDevice();
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
                          SvgPicture.asset(AppIcons.imageIcon, height: 20, color: Colors.white),
                          SizedBox(width: 8),
                          Text("Select Attachment", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: projectTaskController.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2201),
    );
    if (pickedDate != null && pickedDate != projectTaskController.selectedDate) {
      setState(() {
        projectTaskController.selectedDate = pickedDate;
      });
    }
  }

}
