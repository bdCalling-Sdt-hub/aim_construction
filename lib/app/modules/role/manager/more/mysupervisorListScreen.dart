import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/controller/profile_more_controller.dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MySupervisorListScreen extends StatefulWidget {
  @override
  State<MySupervisorListScreen> createState() => _MySupervisorListScreenState();
}

class _MySupervisorListScreenState extends State<MySupervisorListScreen> {
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
        title: Text(
          "Supervisor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx((){
        if (profileMoreController.isLoading.value) {
          return Center(child: CupertinoActivityIndicator(radius: 32.r, color:AppColors.primaryColor));
        }
        if (profileMoreController.getAllSupervisorByManagerModel.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                   'No Supervisor available right now.',
                    style:
                    AppStyles.fontSize16(color: AppColors.hintColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: profileMoreController.getAllSupervisorByManagerModel.length,
                  itemBuilder: (context, index) {
                    final supervisor = profileMoreController.getAllSupervisorByManagerModel[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.indivitualSupervisorInfoScreen,
                              arguments: supervisor.userId
                          );
                        },
                        child: Container(
                          height: 110.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.color5F6774),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Profile Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: CachedNetworkImage(
                                    imageUrl: "${supervisor.profileImage?.imageUrl}",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Image.network('http://www.clker.com/cliparts/Z/J/g/U/V/b/avatar-male-silhouette-md.png', fit: BoxFit.cover),
                                  ),

                                ),
                                SizedBox(width: 15.w),

                                // Name and ID Text
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${supervisor.fname} ${supervisor.lname}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Id: ${supervisor.userId}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Forward Arrow
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );

      }


      ),
    );
  }
}
