import 'package:get/get.dart';

class TentangKamiController extends GetxController {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Fanny Verawaty',
      'role': 'Mahasiswa',
      'description':
          'Mahasiswa Pendidikan Fisika di Universitas Negeri Yogyakarta',
      'image': 'assets/images/team_1.png',
      'email': 'fannyverawaty.2018@student.uny.ac.id',
      'youtube': '@fannyverawaty',
    },
    {
      'name': 'Dr. Supahar, M.Si.',
      'role': 'Dosen Pembimbing',
      'description':
          'Dosen Pendidikan Fisika di Universitas Negeri Yogyakarta dengan bidang keahlian Penilaian dan Evaluasi Pembelajaran Fisika',
      'image': 'assets/images/team_2.png',
      'email': 'supahar@uny.ac.id',
      'youtube': '',
    },
  ];

  final String appDescription =
      'PHYSICS FUN: Menguasai Fluida Dinamis Jadi Lebih Menyenangkan!\n\n'
      'Physics Fun dirancang khusus untuk membuat belajar fisika jadi lebih mudah, interaktif, dan tentunya, lebih menyenangkan! Di Physics Fun kalian akan diberikan materi yang komprehensif dan terstruktur beserta contoh soal dan latihan soalnya. Setiap topik materi diuraikan secara runut, sehingga kalian dapat memahami alur konsep dengan baik. Dalam latihan soalnya, akan langsung diberikan skor supaya kalian dapat mengetahui letak kesalahan dan dapat langsung memperbaikinya. Physics Fun juga memberikan video pembelajaran yang informatif dan membuatmu lebih mudah membayangkan fenomena fluida dinamis yang sedang terjadi.';

  final String studentProfile =
      'Fanny Verawaty merupakan seorang mahasiswa Pendidikan Fisika di Universitas Negeri Yogyakarta yang mengembangkan aplikasi Physics Fun sebagai produk skripsinya. Aplikasi ini dibuat dalam rangka penelitian yang berjudul "Pengembangan Aplikasi Pembelajaran Fisika Berbasis Android Untuk Meningkatkan Kemandirian dan Penguasaan Materi Peserta Didik SMA". Melalui aplikasi ini, diharapkan dapat membantu peserta didik belajar fisika dengan lebih efektif, khususnya pada materi Fluida Dinamik.';

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
