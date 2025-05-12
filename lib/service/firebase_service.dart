import 'package:aim_construction/common/prefs_helper/prefs_helpers.dart';
import 'package:aim_construction/utils/app_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationHelper {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> getFcmToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      PrefsHelper.setString(AppConstants.fcmToken, fcmToken);
    }
    print('FCM Token: $fcmToken');
  }
}
