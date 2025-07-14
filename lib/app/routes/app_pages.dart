import 'package:get/get.dart';

import '../modules/contoh_soal/bindings/contoh_soal_binding.dart';
import '../modules/contoh_soal/views/contoh_soal_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/latihan_soal/bindings/latihan_soal_binding.dart';
import '../modules/latihan_soal/views/latihan_soal_view.dart';
import '../modules/materi/bindings/materi_binding.dart';
import '../modules/materi/views/materi_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/riwayat_kuis/bindings/riwayat_kuis_binding.dart';
import '../modules/riwayat_kuis/views/riwayat_kuis_view.dart';
import '../modules/tentang_kami/bindings/tentang_kami_binding.dart';
import '../modules/tentang_kami/views/tentang_kami_view.dart';
import '../modules/video_pembelajaran/bindings/video_pembelajaran_binding.dart';
import '../modules/video_pembelajaran/views/video_pembelajaran_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LATIHAN_SOAL,
      page: () => const LatihanSoalView(),
      binding: LatihanSoalBinding(),
    ),
    GetPage(
      name: _Paths.CONTOH_SOAL,
      page: () => const ContohSoalView(),
      binding: ContohSoalBinding(),
    ),
    GetPage(
      name: _Paths.MATERI,
      page: () => const MateriView(),
      binding: MateriBinding(),
    ),
    GetPage(
      name: _Paths.TENTANG_KAMI,
      page: () => const TentangKamiView(),
      binding: TentangKamiBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PEMBELAJARAN,
      page: () => const VideoPembelajaranView(),
      binding: VideoPembelajaranBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_KUIS,
      page: () => const RiwayatKuisView(),
      binding: RiwayatKuisBinding(),
    ),
  ];
}
