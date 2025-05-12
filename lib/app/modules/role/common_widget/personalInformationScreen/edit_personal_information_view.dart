import 'dart:io';

import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/controller/profile_more_controller.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/common/widgets/custom_button.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_string.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class EditPersonalInformationScreen extends StatefulWidget {
  const EditPersonalInformationScreen({super.key});

  @override
  State<EditPersonalInformationScreen> createState() => _EditPersonalInformationScreenState();
}

class _EditPersonalInformationScreenState extends State<EditPersonalInformationScreen> {

  TextEditingController firstnameCTRl = TextEditingController();
  TextEditingController lastnameCTRl = TextEditingController();
  TextEditingController phoneCTRl = TextEditingController();

  TextEditingController addressCTRl = TextEditingController();

  Uint8List? _image;
  File? selectedImage;

  final ProfileMoreController profileMoreController = Get.put(ProfileMoreController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      var userId = await PrefsHelper.getString(AppConstants.userId);
      print('===========id $userId');

      var profileData = profileMoreController.userProfileDetailsModel.value;

      firstnameCTRl.text = profileData.fname ?? '';
      lastnameCTRl.text = profileData.lname ?? '';

      phoneCTRl.text = profileData.phoneNumber ?? 'N/A';
      addressCTRl.text = profileData.address ?? 'N/A';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppString.editPersonalInfo.tr,
          style: AppStyles.fontSize18(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx((){
        var profileData = profileMoreController.userProfileDetailsModel.value;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height :102.h,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Profile picture
                              _image != null
                                  ? Padding(
                                padding:  EdgeInsets.all(8.0.r),
                                child: Container(
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(width: 1.w, color: AppColors.white),
                                        image: DecorationImage(
                                            image: MemoryImage(_image!),
                                            fit: BoxFit.cover))),
                              ) : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    showImagePickerOption(context);
                                  },
                                  child: Container(
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: "${profileData.profileImage?.imageUrl}",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Image.network('http://www.clker.com/cliparts/Z/J/g/U/V/b/avatar-male-silhouette-md.png', fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 35,
                                child: GestureDetector(
                                  onTap: () {
                                    showImagePickerOption(context);
                                  },
                                  child: Icon(Icons.image_outlined,size: 25,color: AppColors.white,),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${profileData.fname} ${profileData.lname}" ?? 'N/A', style: TextStyle(color: Colors.white, fontSize: 24.sp),),
                              Text("${profileData.email}", style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  //============================> Name List Tile <=================
                  CustomTextField(
                    controller: firstnameCTRl,
                    hintText: 'Enter First Name',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.profileIcon,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  //============================> Settings List Tile <=================
                  CustomTextField(
                    controller: lastnameCTRl,
                    hintText: 'Enter Last Name',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.profileIcon,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  //============================> Settings List Tile <=================
                  CustomTextField(
                    controller: phoneCTRl,
                    hintText: AppString.enterPhone.tr,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.phoneIcon,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  //============================> Address List Tile <=================
                  CustomTextField(
                    controller: addressCTRl,
                    hintText: AppString.enterAddress.tr,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(AppIcons.location,color: AppColors.primaryColor,height: 20.h,width: 20.w),
                    ),
                  ),

                  SizedBox(height: 50.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx((){
                      return CustomButton(
                        loading: profileMoreController.isLoading.value,
                        onTap: () {
                          profileMoreController.editProfile(
                            profileImage: selectedImage,
                            fname: firstnameCTRl.text,
                            lname: lastnameCTRl.text,
                            address: addressCTRl.text,
                            phoneNumber: phoneCTRl.text,

                          );
                        },
                        text: AppString.updateText.tr,
                      );
                    }

                    ),
                  ),
                ]
            ),
          ),
        );
      })
    );
  }
  //==================================> ShowImagePickerOption Function <===============================
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
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                              color: AppColors.primaryColor,
                            ),
                            CustomText(text: AppString.galleryText.tr)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt,
                                size: 50.w, color: AppColors.primaryColor),
                            CustomText(text:  AppString.cameraText.tr)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }
//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }
}