import 'package:aim_construction/app/controller/supervisor_dailyLog_controller.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/dailylog_document_screen.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/dailylog_image_screen.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/dailylog_note_screen.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/innerWidget/calender_widget.dart';
import 'package:aim_construction/utils/app_colors.dart';
import 'package:aim_construction/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class RoleSupervisorDailyLogView extends StatefulWidget {
  const RoleSupervisorDailyLogView({super.key});

  @override
  State<RoleSupervisorDailyLogView> createState() => _RoleSupervisorDailyLogViewState();
}

class _RoleSupervisorDailyLogViewState extends State<RoleSupervisorDailyLogView> {
  int _selectedIndex = 0;
  final SupervisorDailyLogController supervisorDailyLogController = Get.put(SupervisorDailyLogController());

  final List<String> _tabs = [
   'Notes',
   'Image',
   'Document',
  ];
  var parameter = Get.parameters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      supervisorDailyLogController.selectedDate;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${parameter['projectName']}"),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text('Daily Logs',textAlign: TextAlign.start,style: AppStyles.fontSize20(fontWeight: FontWeight.w600,color: AppColors.color323B4A)),
              ),
            ],
          ),

          //Calender
          CalendarWithDropdown(),

          //===========================
          //Notes + Images + Documents
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: SizedBox(
              height: 35.h,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedIndex == index
                                ? AppColors.primaryColor
                                : AppColors.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          color: _selectedIndex == index
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              '${_tabs[index]} (${_getTabCount(index) ?? '0'})',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedIndex == index ? Colors.white : AppColors.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),

                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _buildTabContent(),
            ),
          ),

        ],
      ),
    );
  }

  String _getTabCount(int index) {
    switch (index) {
      case 0:
        return '${supervisorDailyLogController.noteCount}';
      case 1:
        return '${supervisorDailyLogController.imageCount}';
      case 2:
        return '${supervisorDailyLogController.documentCount}';
      default:
        return '0';
    }
  }


  Widget? _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return DailyLogNoteScreen();
      case 1:
        return DailyLogImageScreen();
      case 2:
        return DailyLogDocumentScreen();
    }
    return null;
  }
}

