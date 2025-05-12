import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/controller/profile_more_controller.dart';
import 'package:aim_construction/common/custom_text/custom_text.dart';
import 'package:aim_construction/common/widgets/custom_listTile.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class IndivitualSupervisorInfoScreen extends StatefulWidget {
  const IndivitualSupervisorInfoScreen({super.key});

  @override
  State<IndivitualSupervisorInfoScreen> createState() => _IndivitualSupervisorInfoScreenState();
}

class _IndivitualSupervisorInfoScreenState extends State<IndivitualSupervisorInfoScreen> {
  final ProfileMoreController profileMoreController = Get.put(ProfileMoreController());
  var supervisorID = Get.arguments;

  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      profileMoreController.getProfileData('$supervisorID');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Supervisor Profile',
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
      body: Obx(() {
        var profileData = profileMoreController.userProfileDetailsModel.value;
        if (profileMoreController.isLoading.value) {
          return Center(child: CupertinoActivityIndicator(
              radius: 32.r, color: AppColors.primaryColor));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 102.h,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(8.r))
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0.r),
                              child:  Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8)), // Removed .r for simplicity
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "${ApiConstants.imageBaseUrl}${profileData.profileImage?.imageUrl ?? ''}",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Image.network('http://www.clker.com/cliparts/Z/J/g/U/V/b/avatar-male-silhouette-md.png',
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: "${profileData.fname} ${profileData.fname}",color: Colors.white,fontSize:24.sp ,),
                                  CustomText(text: "${profileData.email}",color: Colors.white,fontSize:14.sp),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      //============================> Name List Tile <=================
                      CustomListTile(
                        title: "${profileData.fname} ${profileData.fname}",
                        prefixIcon: SvgPicture.asset(
                            AppIcons.profileIcon, color: AppColors.primaryColor,
                            height: 20.h,
                            width: 20.w),
                      ),
                      SizedBox(height: 8.h),
                      //============================> Project Supervisor List Tile <=================
                      CustomListTile(
                        title: profileData.role == 'projectSupervisor'
                            ? 'Project Supervisor'
                            : profileData.role == 'projectManager'
                            ? 'Project Manager'
                            : profileData.role!,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.profileIcon,
                          color: AppColors.primaryColor,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //============================> Email List Tile <=================
                      CustomListTile(
                        title: '${profileData.email}',
                        prefixIcon: SvgPicture.asset(
                            AppIcons.emailIcon, color: AppColors.primaryColor,
                            height: 20.h,
                            width: 20.w),
                      ),
                      SizedBox(height: 8.h),
                      //============================> Phone List Tile <=================
                      CustomListTile(
                        title: '${profileData.phoneNumber ?? 'N/A'}',
                        prefixIcon: SvgPicture.asset(
                            AppIcons.phoneIcon, color: AppColors.primaryColor,
                            height: 20.h,
                            width: 20.w),
                      )
                    ]
                ),
              ),
            ],
          ),
        );
      }
      )
    );
  }
}
