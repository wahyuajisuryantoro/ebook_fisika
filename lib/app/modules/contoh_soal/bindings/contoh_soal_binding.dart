import 'package:get/get.dart';

import '../controllers/contoh_soal_controller.dart';

class ContohSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContohSoalController>(
      () => ContohSoalController(),
    );
  }
}
