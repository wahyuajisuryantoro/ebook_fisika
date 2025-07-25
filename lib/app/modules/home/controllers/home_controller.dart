import 'package:ebook_fisika/app/routes/app_pages.dart';
import 'package:ebook_fisika/app/service/storage_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentCarouselIndex = 0.obs;
  final userName = "John Doe".obs;
  final profileImagePath = ''.obs;

  final List<String> carouselImages = [
    'assets/images/slider_1.png',
    'assets/images/slider_2.png',
    'assets/images/slider_3.png',
  ];

  final List<Map<String, String>> menuItems = [
    {
      'image': 'assets/images/materi.png',
      'title': 'Materi',
      'route': '/materi'
    },
    {
      'image': 'assets/images/contoh_soal.png',
      'title': 'Contoh Soal',
      'route': '/contoh-soal'
    },
    {
      'image': 'assets/images/latihan_soal.png',
      'title': 'Latihan Soal',
      'route': '/latihan-soal'
    },
    {
      'image': 'assets/images/video_pembelajaran.png',
      'title': 'Video Pembelajaran',
      'route': '/video-pembelajaran'
    },
    {
      'image': 'assets/images/tentang_kami.png',
      'title': 'Tentang Kami',
      'route': '/tentang-kami'
    },
  ];

 String get greeting {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Selamat Pagi\nSelamat Datang di Physics Fun';
  } else if (hour < 17) {
    return 'Selamat Siang\nSelamat Datang di Physics Fun';
  } else {
    return 'Selamat Malam\nSelamat Datang di Physics Fun';
  }
}

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  void loadUserProfile() {
    try {
      final profile = StorageService.to.getUserProfile();
      userName.value =
          profile['name']?.isNotEmpty == true ? profile['name']! : 'Pengguna';
      profileImagePath.value = profile['profileImage'] ?? '';
    } catch (e) {
      print('Error loading profile: $e');
      userName.value = 'Pengguna';
      profileImagePath.value = '';
    }
  }

  void refreshProfile() {
    loadUserProfile();
  }

  void navigateToProfile() {
    Get.toNamed(Routes.PROFILE);
  }

  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }

  void navigateToMenu(String route) {
    Get.toNamed(route);
  }
}
