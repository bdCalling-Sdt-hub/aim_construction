import 'package:get/get.dart';

import '../controllers/role_supervisor_project_tool_controller.dart';

class RoleSupervisorProjectToolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSupervisorProjectToolController>(
      () => RoleSupervisorProjectToolController(),
    );
  }
}
