import 'package:aim_construction/app/routes/app_pages.dart';import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';

class ManagerBottomMenu extends StatelessWidget {
  final int menuIndex;
  const ManagerBottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.white : AppColors.blackColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding:  EdgeInsets.only(top: 4.h),
          child: SvgPicture.asset(
            image,
            height: 24.0.h,
            width: 24.0.w,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(menuIndex == 0 ? AppIcons.homeIcon : AppIcons.homeIconBlack, 'Project', theme, 0),
      getItem(menuIndex == 1 ? AppIcons.activatesIcon : AppIcons.activateBlackIcon,'Activates', theme, 1),
      getItem(menuIndex == 2 ? AppIcons.moreIcon : AppIcons.moreBlackIcon, 'More', theme, 2),

    ];

    return BottomNavigationBar(
      //   backgroundColor: AppColors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.white,
      currentIndex: menuIndex,
      onTap: (value) {
        switch (value) {
          case 0:
            Get.offAndToNamed(AppRoutes.managerHomeScreen);
            break;
          case 1:
            Get.offAndToNamed(AppRoutes.managerActivityScreen);
            break;
          case 2:
            Get.offAndToNamed(AppRoutes.managerMoreScreen);
            break;

        }
      },
      items: menuItems,
    );


  }
}
