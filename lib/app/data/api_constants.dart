class ApiConstants {
//==========================================>> Online <<=================================
/*
static const String baseUrl = "https://api.carrentpro.com/api/v1";
  static const String imageBaseUrl = "https://api.carrentpro.com";
*/


//==========================================>> Local <<=================================
 static const String baseUrl = "https://sheakh6731.sobhoy.com/api/v1";
  static const String imageBaseUrl = "https://sheakh6731.sobhoy.com";

/*  http://192.168.10.163:8081/api/v1
  http://192.168.10.163:8081/api/v1*/

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String googleApiKey="AIzaSyBUKgC5i0rzRLbGhndTjM0b6QdWbigR6_E";


  //============================ >> User Auth << =================================
  static const String signUpEndPoint = "/auth/register";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPasswordEndPoint = "/auth/forgot-password";
  static const String setNewPasswordEndPoint = "/auth/reset-password";

  static const String getAllCompanyManagerEndPoint = "/user/getAllManagerByCompanyId";
  static const String getAllCompanyEndPoint = "/company/getByName";
  static const String verifyCodeEndPoint = "/auth/verify-email";
  static const String resendOTPEndPoint = "/auth/resend-otp";
  static const String changePasswordEndPoint = "/auth/change-password";

  static const String userprofileDetailsEndPoint = "/user";
  static const String getAllSupervisorByManagerEndPoint = "/user/superVisors";
  static const String projectCreateEndPoint = "/project/create";
  static const String projectTaskCreateEndPoint = "/task/create";
  static const String companyCreateEndPoint = "/company/create";
  static const String projectDetailsEndPoint = "/project/paginate";
  static const String projectTaskDetailsEndPoint = "/task/paginate";
  static const String notificationEndPoint = "/activity/";
  static const String getAllImageAndDocumentEndPoint = "/project/getAllImagesOfAllNotesOfAProjectId/";
  static const String managerContarctCreateEndPoint = "/contract/create";
  static const String getManagerContarctEndPoint = "/contract/paginate";
  static const String supervisorAddNewNoteEndPoint = "/note/create";
  static const String supervisorNoteByDateEndPoint = "/note/getAllByDateAndProjectId/";
  static const String getAllImagesOfAllNotesEndPoint = "/note/getAllImagesOfAllNotesOfADateAndProjectId/";
  static const String noteDetailsEndPoint = "/note";
  static const String daliyLogImageOrDocumentUploadEndPoint = "/note/uploadImagesOrDocuments";
  static const String updateProfileEndPoint = "/user/update-profile";
  static const String noteStatusChnangeEndPoint = "/note/changeStatusOfANote";
  static const String taskStatusChnangeEndPoint = "/task/changeStatus";
  static const String getTaskDetailsByIDEndPoint = "/task";




}
