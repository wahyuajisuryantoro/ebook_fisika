import 'package:get/get.dart';

import '../controllers/riwayat_kuis_controller.dart';

class RiwayatKuisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatKuisController>(
      () => RiwayatKuisController(),
    );
  }
}
