part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();
  static const signIn_screen = _Paths.SIGN_IN;
  static const SIGNUP = _Paths.SIGNUP;
  static const splashScreen = _Paths.splashScreen;
  static const onboardingScreen = _Paths.onboardingScreen;
  static const successfullScreen = _Paths.successfullScreen;
  static const FORGET_PASSWORD = _Paths.FORGET_PASSWORD;
  static const verify_email_screen = _Paths.VERIFY_EMAIL;
  static const resetPasswordScreen = _Paths.resetPasswordScreen;
  static const ROLE_SUPERVISOR_HOME_SCREEN = _Paths.ROLE_SUPERVISOR_HOME_SCREEN;
  static const supervisorMoreScreen = _Paths.supervisorMoreScreen;
  static const supervisorProjectTools = _Paths.supervisorProjectTools;
  static const personalInformationScreen = _Paths.personalInformationScreen;
  static const editPersonalInformation = _Paths.editPersonalInformation;
  static const settingScreen = _Paths.settingScreen;
  static const changePasswordScreen = _Paths.changePasswordScreen;
  static const contactUsScreen = _Paths.contactUsScreen;
  static const privacyPolicyScreen = _Paths.privacyPolicyScreen;
  static const termsandConditionsScreen = _Paths.termsandConditionsScreen;
  static const aboutUsScreen = _Paths.aboutUsScreen;
  static const ROLE_SUPERVISOR_ACTIVITY_SCREEN = _Paths.ROLE_SUPERVISOR_ACTIVITY_SCREEN;
  static const supervisor_dailyLog_screen = _Paths.ROLE_SUPERVISOR_DAILY_LOG;
  static const taskViewScreen = _Paths.taskViewScreen;
  static const projectImagers = _Paths.Project_Images_View;
  static const supervisorDocuments = _Paths.supervisorDocuments;

  static const dailyNoteDetailsScreen = _Paths.dailyNoteDetailsScreen;
  static const addNewNoteScreen = _Paths.addNewNoteScreen;

  //manager
  static const managerHomeScreen = _Paths.managerHomeScreen;
  static const managerMoreScreen = _Paths.managerMoreScreen;
  static const managerActivityScreen = _Paths.managerActivityScreen;
  static const mySupervisorListScreen = _Paths.mySupervisorListScreen;
  static const indivitualSupervisorInfoScreen = _Paths.indivitualSupervisorInfoScreen;
  static const managerProjectToolsScreen = _Paths.managerProjectToolsScreen;
  static const managerContactScreen = _Paths.managerContactScreen;
  static const managerDailyLogScreen = _Paths.managerDailyLogScreen;
  static const managerNoteAcceptScreen = _Paths.managerNoteAcceptScreen;
  static const projectCreateScreen = _Paths.projectCreateScreen;
  static const managerTaskCreate = _Paths.managerTaskCreate;
  static const supervisorTaskDetailsScreen = _Paths.supervisorTaskDetailsScreen;
  static const managerTaskDetailsScreen = _Paths.managerTaskDetailsScreen;
}

abstract class _Paths {
  _Paths._();
  static const splashScreen = '/splashScreen';
  static const onboardingScreen = '/onboardingScreen';
  static const SIGN_IN = '/sign-in';
  static const SIGNUP = '/signup';
  static const FORGET_PASSWORD = '/forget-password';
  static const VERIFY_EMAIL = '/verify-email';
  static const successfullScreen = '/successfullScreen';
  static const resetPasswordScreen = '/reset-password';
  static const settingScreen = '/settingScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const contactUsScreen = '/contactUsScreen';
  static const privacyPolicyScreen = '/privacyPolicyScreen';
  static const termsandConditionsScreen = '/termsandConditionsScreen';
  static const aboutUsScreen = '/aboutUsScreen';

  static const ROLE_SUPERVISOR_HOME_SCREEN = '/home-screen';
  static const supervisorMoreScreen = '/superVieror_more';
  static const supervisorProjectTools = '/supervisor_project-tool';
  static const personalInformationScreen = '/personal-information-screen';
  static const editPersonalInformation = '/edit-personal-information';

  static const ROLE_SUPERVISOR_ACTIVITY_SCREEN = '/activity-screen';
  static const ROLE_SUPERVISOR_DAILY_LOG = '/daily-log';
  static const taskViewScreen = '/all_task_screen';
  static const Project_Images_View = '/images';
  static const supervisorDocuments = '/documents';

  static const dailyNoteDetailsScreen = '/dailyNoteDetailsScreen';
  static const addNewNoteScreen = '/addNewNoteScreen';
  static const supervisorTaskDetailsScreen = '/supervisorTaskDetailsScreen';




  //manager
  static const managerHomeScreen = '/managerHomeScreen';
  static const managerMoreScreen = '/managerMoreScreen';
  static const managerActivityScreen = '/managerActivityScreen';
  static const mySupervisorListScreen = '/mySupervisorListScreen';
  static const indivitualSupervisorInfoScreen = '/indivitualSupervisorInfoScreen';
  static const managerProjectToolsScreen = '/managerProjectToolsScreen';
  static const managerContactScreen = '/managerContactScreen';
  static const managerDailyLogScreen = '/managerDailyLogScreen';
  static const managerNoteAcceptScreen = '/managerNoteAcceptScreen';
  static const projectCreateScreen = '/projectCreateScreen';
  static const managerTaskCreate = '/managerTaskCreate';
  static const managerTaskDetailsScreen = '/managerTaskDetailsScreen';

}
