import 'package:aim_construction/app/data/api_constants.dart';
import 'package:aim_construction/app/model/project_imageDocument_model.dart';
import 'package:aim_construction/service/api_checker.dart';
import 'package:aim_construction/service/api_client.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProjectImageAndDocumentController extends GetxController {
  //==================== >>>>   Project Image / Document  <<<<   ==========================

  RxList<GetAllImageAndDocumentModel> getAllImageAndDocumentModel = <GetAllImageAndDocumentModel>[].obs;
  var isLoading = false.obs;

  getAllImageAndDocument(
      {String? projectId,
        String? noteOrTaskOrProject,
        String? imageOrDocument,
        String? uploaderRole
      }) async {
    isLoading(true);
    List<String> queryParams = [];
    if (projectId != null) queryParams.add('projectId=$projectId');
    if (noteOrTaskOrProject != null) queryParams.add('noteOrTaskOrProject=$noteOrTaskOrProject');
    if (imageOrDocument != null) queryParams.add('imageOrDocument=$imageOrDocument');
    if (uploaderRole != null) queryParams.add('uploaderRole=$uploaderRole');

    var url = ApiConstants.getAllImageAndDocumentEndPoint;

    if (queryParams.isNotEmpty) {
      url +='?${queryParams.join('&')}';
    }

    var response = await ApiClient.getData(url);

    // Handle response
    if (response.statusCode == 200) {
      getAllImageAndDocumentModel.value = List.from(response.body['data']['attributes'].map((x) => GetAllImageAndDocumentModel.fromJson(x)));
      isLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      update();
    }
  }

}