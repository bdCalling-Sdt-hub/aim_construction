import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/api_constants.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final  TextEditingController textEditingController = TextEditingController();
  //=========================>> Get All Notification <<============================

  RxList<NotificationDetailsModel> notificationDetailsModel = <NotificationDetailsModel>[].obs;

  var loading = false.obs;

  getAllNotification() async {

    loading(true);
    var response = await ApiClient.getData("${ApiConstants.notificationEndPoint}?sortBy=-createdAt&");
    if (response.statusCode == 200) {
      notificationDetailsModel.value = List.from(response.body['data']['attributes']['results'].map((x) => NotificationDetailsModel.fromJson(x)));
      loading(false);
      update();
    }
    else {
      ApiChecker.checkApi(response);
      loading(false);
      update();
    }
  }
}
