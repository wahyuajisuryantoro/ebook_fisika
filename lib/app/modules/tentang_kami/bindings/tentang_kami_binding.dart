import 'package:get/get.dart';

import '../controllers/tentang_kami_controller.dart';

class TentangKamiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TentangKamiController>(
      () => TentangKamiController(),
    );
  }
}
