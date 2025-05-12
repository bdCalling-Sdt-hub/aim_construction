import 'package:aim_construction/app/controller/notification_controller.dart';
import 'package:aim_construction/app/modules/bottom_menu/manager_bottom_menu..dart';
import 'package:aim_construction/app/routes/app_pages.dart';
import 'package:aim_construction/common/helper/time_formate.dart';
import 'package:aim_construction/common/widgets/custom_text_field.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/app_icons.dart';
import 'package:aim_construction/utils/app_images.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


class ManagerActivityScreen extends StatefulWidget {
  const ManagerActivityScreen({super.key});

  @override
  State<ManagerActivityScreen> createState() => _ManagerActivityScreenState();
}

class _ManagerActivityScreenState extends State<ManagerActivityScreen> {
  final NotificationController notificationController = Get.put(NotificationController());

  @override
    Widget build(BuildContext context) {

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        notificationController.getAllNotification();
      });

    return Scaffold(
      bottomNavigationBar: const ManagerBottomMenu(1),
      appBar: AppBar(
        title: const Text('Activity'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.h),
            // Activity List
            Expanded(
              child: Obx(
                    () {
                  if (notificationController.loading.value) {
                    return Center(
                      child: CupertinoActivityIndicator(radius: 32.r, color: AppColors.primaryColor),
                    );
                  } else if (notificationController.notificationDetailsModel.value.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppImage.noData, height: 200.h),
                          Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Text(
                              'No activity available now.',
                              style: AppStyles.fontSize20(color: AppColors.hintColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: notificationController.notificationDetailsModel.value.length,
                      itemBuilder: (context, index) {
                        final notificationDetails = notificationController.notificationDetailsModel.value[index];

                        return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.color323B4A),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${notificationDetails.title}',
                                style: AppStyles.fontSize16(fontWeight: FontWeight.w600, color: AppColors.color323B4A),
                              ),
                              SizedBox(height: 8.h),

                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.submittedIcon),
                                  SizedBox(width: 4.w),
                                  Row(
                                    children: [
                                      Text(
                                        'Submitted : ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        '${TimeFormatHelper.formatDateWithDay(DateTime.parse(notificationDetails.createdAt.toString()))}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
