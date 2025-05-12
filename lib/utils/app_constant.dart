

import 'package:aim_construction/common/model/language_model.dart';

class AppConstants {


  static const token = 'token';
  static const company = 'company';
  static const tempId = 'tempId';

  static const resetPasswordToken = 'resetPasswordToken';



  static String APP_NAME="Aim Construction";
  static String bearerToken="bearerToken";
  static String verificationToken="verificationToken";


  // share preference Key
  static String THEME ="theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
  );
  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel( languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel( languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];

  static String fcmToken = "fcmToken";
  static String isLogged = "IsLogged";
  static String userId = 'userId';

  static String projectID = 'projectID';

  static String role = "Role";
  static String lname = "lname";

}
enum Role {projectManager, projectSupervisor}