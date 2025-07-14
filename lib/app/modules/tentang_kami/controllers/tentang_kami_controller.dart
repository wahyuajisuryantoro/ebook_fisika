import 'package:get/get.dart';

class TentangKamiController extends GetxController {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Fanny Verawaty',
      'role': 'Mahasiswa',
      'description': 'Mahasiswa Pendidikan Fisika di Universitas Negeri Yogyakarta',
      'image': 'assets/images/team_1.png',
      'email': 'fannyverawaty.2018@student.uny.ac.id',
      'youtube': '@fannyverawaty',
    },
    {
      'name': 'Dr. Supahar, M.Si.',
      'role': 'Dosen Pembimbing',
      'description': 'Dosen Pendidikan Fisika di Universitas Negeri Yogyakarta dengan bidang keahlian Penilaian dan Evaluasi Pembelajaran Fisika',
      'image': 'assets/images/team_2.png',
      'email': 'supahar@uny.ac.id',
      'youtube': '',
    },
  ];

  final String appDescription = 
    'Fanny Verawaty merupakan seorang mahasiswa Pendidikan Fisika di Universitas Negeri Yogyakarta. Aplikasi ini dibuat sebagai produk Skripsi yang berjudul "Pengembangan Aplikasi Pembelajaran Fisika Berbasis Android Untuk Meningkatkan Kemandirian dan Penguasaan Materi Peserta Didik SMA". Harapannya aplikasi pembelajaran ini dapat membantu peserta didik belajar fisika, khususnya materi Fluida Dinamik.';

  final String dosenDescription = 
    'Dr. Supahar, M.Si. merupakan dosen Pendidikan Fisika di Universitas Negeri Yogyakarta dengan bidang keahlian Penilaian dan Evaluasi Pembelajaran Fisika. Beliau menempuh pendidikan S1 bidang Pendidikan Fisika di IKIP Yogyakarta (1987 - 1992), pendidikan S2 bidang Ilmu Fisika di ITB (1998 - 2000), dan pendidikan S3 bidang Penelitian dan Evaluasi Pendidikan di UNY (2010 - 2014).';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}