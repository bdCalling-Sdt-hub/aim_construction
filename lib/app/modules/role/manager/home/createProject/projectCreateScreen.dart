import 'dart:developer';
import 'dart:io';
import 'package:aim_construction/app/controller/project_controller.dart';
import 'package:aim_construction/app/controller/profile_more_controller.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class ProjectCreateScreen extends StatefulWidget {
  @override
  _ProjectCreateScreenState createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {

  ProjectController projectController = Get.put(ProjectController());
  Uint8List? _profileImage;


  final ProfileMoreController profileMoreController = Get.put(ProfileMoreController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      profileMoreController.getAllSupervisorByManger();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Project', style: AppStyles.fontSize18()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _profileImage != null
                        ? Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.white,
                          ),
                          image: DecorationImage(
                            image: MemoryImage(_profileImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                        :
                    InkWell(
                      onTap: (){
                        showImagePickerOption(context);
                      },
                      child: Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImage.noData),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 130,
                      child: GestureDetector(
                        onTap: () {
                          showImagePickerOption(context);
                        },
                        child: Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: projectController.projectNameController,
                    hintText: 'Project Name',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: projectController.streetAddressController,
                    hintText: 'Street Address',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: projectController.cityController,
                    hintText: 'City',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: projectController.zipCodeController,
                    hintText: 'Zip Code',
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: projectController.countryController,
                    hintText: 'Country',
                  ),
                  SizedBox(height: 20),
                  Text('Project Deadline'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _calenderDatePicker(controller: projectController.startDateController, isEndDate: false);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.fillColor,
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    projectController.startDateController.text.isEmpty
                                        ? 'Start Date'
                                        : projectController.startDateController.text,
                                    style: TextStyle(
                                      color: projectController.startDateController.text.isEmpty
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _calenderDatePicker(controller: projectController.startDateController, isEndDate: false);
                                  },
                                  icon: SvgPicture.asset(
                                    AppIcons.calender,
                                    color: AppColors.primaryColor,
                                    height: 18.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _calenderDatePicker(controller: projectController.endDateController, isEndDate: true);
                            Logger logger = Logger();
                            logger.d('====> Selected End Date: ${projectController.endDateController.text}');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.fillColor,
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    projectController.endDateController.text.isEmpty ? 'End Date'
                                        : projectController.endDateController.text,
                                    style: TextStyle(
                                      color: projectController.endDateController.text.isEmpty
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _calenderDatePicker(controller: projectController.endDateController, isEndDate: true);
                                    Logger logger = Logger();
                                    logger.d('====> Selected End Date: ${projectController.endDateController.text}');
                                  },
                                  icon: SvgPicture.asset(
                                    AppIcons.calender,
                                    color: AppColors.primaryColor,
                                    height: 18.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text('Assign Supervisor', style: AppStyles.fontSize18(fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primaryColor, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Row(
                          children: [
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Obx(() {
                                return DropdownButton<String>(
                                  value: projectController.selectedSupervisor.isEmpty
                                      ? null
                                      : projectController.selectedSupervisor.value,
                                  borderRadius: BorderRadius.circular(8.r),
                                  hint: Text(
                                    projectController.selectedSupervisor.isEmpty
                                        ? "Select Supervisor"
                                        : projectController.selectedSupervisor.value,
                                    style: AppStyles.fontSize16(color: AppColors.blackColor),
                                  ),
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: profileMoreController.getAllSupervisorByManagerModel.map((supervisor) {
                                    return DropdownMenuItem<String>(
                                      value: supervisor.userId,
                                      child: Text(
                                        '${supervisor.fname} ${supervisor.lname}',
                                        style: AppStyles.fontSize18(color: AppColors.blackColor),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newRole) {
                                    projectController.selectedSupervisor.value = newRole ?? '';
                                    print('================== Supervisor ID : ${projectController.selectedSupervisor.value}');
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Project Template', style: AppStyles.fontSize18(fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.primaryColor, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(() {
                                return DropdownButton<String>(
                                  value: projectController.selectedTampelet.value.isEmpty
                                      ? null
                                      : projectController.selectedTampelet.value,
                                  borderRadius: BorderRadius.circular(8.r),
                                  hint: Text(
                                    projectController.selectedTampelet.isEmpty
                                        ? "Select Tempelet"
                                        : projectController.selectedTampelet.value,
                                    style: AppStyles.fontSize16(color: AppColors.blackColor),
                                  ),
                                  icon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: projectController.tampelet.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: AppStyles.fontSize18(color: AppColors.blackColor),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    // Update the selectedTampelet value
                                    projectController.selectedTampelet.value = newValue ?? '';
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx((){

                    return CustomButton(
                      loading: projectController.isLoading.value,
                      onTap: () {
                        projectController.projectCreate();
                      },
                      text: 'Create Project',
                    );
                  })

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _calenderDatePicker({
    required TextEditingController controller,
    required bool isEndDate,
  }) async {
    DateTime currentDate = DateTime.now();
    DateTime firstDate = currentDate;
    if (isEndDate && projectController.startDateController.text.isNotEmpty) {

      DateTime startDate = DateFormat('dd-MM-yyyy').parse(projectController.startDateController.text);
      firstDate = startDate;
    }

    DateTime lastDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate.isAfter(firstDate) ? currentDate : firstDate,  // Set the initial date to current date or the start date
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: AppColors.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isEndDate) {
          DateTime startDate = DateFormat('yyyy-MM-dd').parse(projectController.startDateController.text);

          if (pickedDate.isBefore(startDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('End date must be after the start date!'),
                backgroundColor: Colors.red,
              ),
            );
            controller.text = '';
          } else {
            controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          }
        } else {
          controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        }
      });
    }
  }





  // Show image picker option
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gallery Option
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 50.w,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(text: 'Gallery'),
                      ],
                    ),
                  ),
                ),
                // Camera Option
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 50.w,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(text: 'Camera'),
                      ],
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

  // Pick image function
  Future<void> _pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;

    setState(() {
      projectController.selectedProjectImage = File(returnImage.path);
      _profileImage = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    await _pickImage(ImageSource.gallery);
  }

  // Pick image from camera
  Future<void> _pickImageFromCamera() async {
    await _pickImage(ImageSource.camera);
  }
}
