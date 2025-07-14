import 'package:get/get.dart';

import '../controllers/video_pembelajaran_controller.dart';

class VideoPembelajaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPembelajaranController>(
      () => VideoPembelajaranController(),
    );
  }
}
