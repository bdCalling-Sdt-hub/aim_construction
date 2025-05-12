import 'package:aim_construction/app/modules/resetPassword/bindings/reset_password_binding.dart';
import 'package:aim_construction/app/modules/resetPassword/views/reset_password_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/forgetPassword/bindings/forget_password_binding.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/forgetPassword/views/forget_password_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/sign_in/bindings/sign_in_binding.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/sign_in/views/signInScreen.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/signup/bindings/signup_binding.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/signup/views/signupScreen.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/verifyEmail/bindings/verify_email_binding.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/verifyEmail/views/successfull_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/auth/verifyEmail/views/verify_email_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/documents/views/role_supervisor_documents_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/personalInformationScreen/edit_personal_information_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/personalInformationScreen/personal_information_screen_view.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/aboutus/aboutUs_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/chnagePassword/changePassword_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/contactUs/contactUs_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/privacyPolicy/privacy_policy_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/settings_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/settings/termsConditions/terms_condition_screen.dart';
import 'package:aim_construction/app/modules/role/common_widget/task/views/managerTaskDetailsScreen.dart';
import 'package:aim_construction/app/modules/role/common_widget/task/views/supervisor_taskDetailsScreen.dart';
import 'package:aim_construction/app/modules/role/common_widget/task/views/task_view_screen.dart';
import 'package:aim_construction/app/modules/role/manager/home/createProject/projectCreateScreen.dart';
import 'package:aim_construction/app/modules/role/common_widget/task/views/createTask/managerTaskCreate.dart';
import 'package:aim_construction/app/modules/role/manager/home/managerContarctScreen.dart';
import 'package:aim_construction/app/modules/role/manager/home/managerDailyLogs/managerNoteAcceptScreen.dart';
import 'package:aim_construction/app/modules/role/manager/home/managerDailyLogs/managerDailyLogScreen.dart';
import 'package:aim_construction/app/modules/role/manager/home/manager_project_tools.dart';
import 'package:aim_construction/app/modules/role/manager/home/managerhomeScreen.dart';
import 'package:aim_construction/app/modules/role/manager/managerActivity/manager_activity_screen.dart';
import 'package:aim_construction/app/modules/role/manager/more/indivisualSupervisorInformation.dart';
import 'package:aim_construction/app/modules/role/manager/more/managerMoreScreen.dart';
import 'package:aim_construction/app/modules/role/manager/more/mysupervisorListScreen.dart';
import 'package:aim_construction/app/modules/role/supervisor/activityScreen/views/role_supervisor_activity_screen_view.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/dailylog_note_details_screen.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/noteAddDetailsScreen.dart';
import 'package:aim_construction/app/modules/role/supervisor/dailyLog/views/role_supervisor_daily_log_view.dart';
import 'package:aim_construction/app/modules/role/supervisor/homeScreen/views/role_supervisor_home_screen_view.dart';
import 'package:aim_construction/app/modules/role/supervisor/more/views/role_supervisor_more_view.dart';
import 'package:aim_construction/app/modules/role/supervisor/projectTool/views/supervisor_project_tool_view.dart';
import 'package:aim_construction/onboarding_screen.dart';
import 'package:aim_construction/splash_screen.dart';
import 'package:get/get.dart';
import '../modules/role/common_widget/images/views/images_view_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = AppRoutes.signIn_screen;

  static final routes = [
    GetPage(name: _Paths.splashScreen, page: () => const SplashScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.onboardingScreen, page: () => const OnboardingScreen(),transition: Transition.noTransition),

    GetPage(name: _Paths.SIGN_IN, page: () => const SignInScreen(), binding: SignInBinding(),transition: Transition.noTransition),
    GetPage(name: _Paths.SIGNUP, page: () => const SignUpScreen(), binding: SignupBinding(),transition: Transition.noTransition),

    GetPage(name: _Paths.FORGET_PASSWORD, page: () =>  ForgotPasswordScreen(),binding: ForgetPasswordBinding(),transition: Transition.noTransition),
    GetPage(name: _Paths.VERIFY_EMAIL, page: () =>  VerifyCodeScreen(),binding: VerifyEmailBinding(),transition: Transition.noTransition),
    GetPage(name: _Paths.resetPasswordScreen, page: () =>  ResetPasswordScreen(),binding: ResetPasswordBinding()),
    GetPage(name: _Paths.successfullScreen, page: () =>  SuccessfullScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.settingScreen, page: () =>  SettingScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.changePasswordScreen, page: () =>  ChangePasswordScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.contactUsScreen, page: () =>  ContactUsScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.privacyPolicyScreen, page: () =>  PrivacyPolicyScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.termsandConditionsScreen, page: () =>  TermsandConditionsScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.aboutUsScreen, page: () =>  AboutUsScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.editPersonalInformation, page: () =>  EditPersonalInformationScreen(),transition: Transition.noTransition),

    // ROLE_SUPERVISOR
    GetPage(name: _Paths.ROLE_SUPERVISOR_HOME_SCREEN, page: () =>  SupervisorHomeScreenView(),transition: Transition.noTransition),
    GetPage(name: _Paths.supervisorMoreScreen, page: () =>  SupervisorMoreView(),transition: Transition.noTransition),
    GetPage(name: _Paths.supervisorProjectTools, page: () =>  SupervisorProjectToolScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.personalInformationScreen, page: () =>  PersonalInformationScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.ROLE_SUPERVISOR_ACTIVITY_SCREEN, page: () =>  RoleSupervisorActivityScreenView(),transition: Transition.noTransition),
    GetPage(name: _Paths.ROLE_SUPERVISOR_DAILY_LOG, page: () =>  RoleSupervisorDailyLogView(),transition: Transition.noTransition),
    GetPage(name: _Paths.taskViewScreen, page: () =>  TaskViewScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.supervisorDocuments, page: () =>  RoleSupervisorDocumentsView(),transition: Transition.noTransition),
    GetPage(name: _Paths.dailyNoteDetailsScreen, page: () =>  DailyNoteDetailsScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.addNewNoteScreen, page: () =>  AddNewNoteScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.supervisorTaskDetailsScreen, page: () =>  SupervisorTaskDetailsScreen(),transition: Transition.noTransition),

    GetPage(name: _Paths.Project_Images_View, page: () =>  ProjectImagesView(),transition: Transition.noTransition),
    // Manager
    GetPage(name: _Paths.managerHomeScreen, page: () =>  ManagerHomeScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerMoreScreen, page: () =>  ManagerMoreScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerActivityScreen, page: () =>  ManagerActivityScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.mySupervisorListScreen, page: () =>  MySupervisorListScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.indivitualSupervisorInfoScreen, page: () =>  IndivitualSupervisorInfoScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerProjectToolsScreen, page: () =>  ManagerProjectToolsScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerContactScreen, page: () =>  ManagerContactScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerDailyLogScreen, page: () =>  ManagerDailyLogScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerNoteAcceptScreen, page: () =>  ManagerNoteAcceptScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.projectCreateScreen, page: () =>  ProjectCreateScreen(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerTaskCreate, page: () =>  ManagerTaskCreate(),transition: Transition.noTransition),
    GetPage(name: _Paths.managerTaskDetailsScreen, page: () =>  ManagerTaskDetailsScreen(),transition: Transition.noTransition),

  ];
}
