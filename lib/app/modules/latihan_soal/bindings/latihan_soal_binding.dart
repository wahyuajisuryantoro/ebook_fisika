import 'package:get/get.dart';

import '../controllers/latihan_soal_controller.dart';

class LatihanSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LatihanSoalController>(
      () => LatihanSoalController(),
    );
  }
}
