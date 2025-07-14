import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ebook_fisika/app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';

class LatihanSoalController extends GetxController {
  final currentQuestionIndex = 0.obs;
  final selectedAnswers = <int, String>{}.obs;
  final isQuizCompleted = false.obs;
  final isQuizStarted = false.obs;
  final timeSpent = 0.obs;
  final showResult = false.obs;
  
  
  final GlobalKey repaintBoundaryKey = GlobalKey();
  
  
  late DateTime startTime;
  
  
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Selang dengan luas penampang besar dan kecil berturut-turut 400 cm² dan 50 cm² dialiri air dengan kelajuan 2 m/s pada luas penampang besarnya. Volume air yang keluar pada luas penampang kecil selama 5 menit adalah...',
      'options': ['16 m³', '18 m³', '20 m³', '22 m³', '24 m³'],
      'correctAnswer': 'E',
      'explanation': 'Menggunakan persamaan kontinuitas dan volume = A × v × t',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Diketahui sebuah pipa air dengan luas penampang 10 cm² dan kecepatan air yang mengalir pada pipa 1 m/s. Lamanya waktu yang diperlukan untuk mengalirkan air dengan volume 2 m³ adalah...',
      'options': ['3 jam', '2 jam', '1,5 jam', '1 jam', '0,5 jam'],
      'correctAnswer': 'E',
      'explanation': 'Waktu = Volume / (Luas × Kecepatan)',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Aliran yang tidak bergantung waktu disebut aliran...',
      'options': ['Steady', 'Turbulen', 'Non-turbulen', 'Laminar', 'Non-viskos'],
      'correctAnswer': 'A',
      'explanation': 'Aliran steady adalah aliran yang tidak berubah terhadap waktu',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Perhatikan gambar berikut. Sebuah pipa silinder diletakkan mendatar dan dialiri kecepatan aliran di A = 3 m/s dan di B = 5 m/s. Jika tekanan di penampang A = 10⁵ N/m², maka tekanan di penampang B adalah...',
      'options': ['9,1 x 10⁴ N/m²', '10,45 x 10⁴ N/m²', '11,8 x 10⁴ N/m²', '13,5 x 10⁴ N/m²', '19,0 x 10⁴ N/m²'],
      'correctAnswer': 'A',
      'explanation': 'Menggunakan persamaan Bernoulli untuk pipa horizontal',
      'hasImage': true,
      'imagePath': 'assets/images/soal_4.png',
    },
    {
      'question': 'Berikut yang bukan merupakan alat-alat yang menerapkan prinsip hukum Bernoulli adalah...',
      'options': ['Alat penyemprot', 'Gaya angkat sayap pesawat terbang', 'Venturimeter', 'Pompa Hidrolik', 'Karburator'],
      'correctAnswer': 'D',
      'explanation': 'Pompa hidrolik menerapkan hukum Pascal, bukan Bernoulli',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Perhatikan gambar berikut. Sebuah bak penampungan berisi air setinggi 1 meter (g = 10 m/s²) dan pada dinding terdapat lubang kebocoran seperti terlihat pada gambar. Besar kelajuan air yang keluar dari lubang tersebut adalah...',
      'options': ['1 m/s', '2 m/s', '3 m/s', '4 m/s', '5 m/s'],
      'correctAnswer': 'D',
      'explanation': 'Menggunakan persamaan Torricelli: v = √(2gh)',
      'hasImage': true,
      'imagePath': 'assets/images/soal_6.png',
    },
    {
      'question': 'Air mengalir melalui sebuah pipa yang berbentuk corong. Garis tengah lubang corong dimana air itu masuk 30 cm dan keluar 15 cm. Letak pusat lubang pipa yang lebih kecil lebih rendah 60 cm daripada pusat lubang yang besar. Jika cepat aliran air dalam pipa itu 140 liter/detik, sedangkan tekanannya pada lubang yang besar 77,5 cmHg. Besarnya tekanan pada lubang yang kecil adalah...',
      'options': ['59,9 cmHg', '52,7 cmHg', '43,5 cmHg', '40,2 cmHg', '38,4 cmHg'],
      'correctAnswer': 'D',
      'explanation': 'Menggunakan persamaan Bernoulli lengkap dengan perbedaan ketinggian',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Sebuah pipa air digunakan untuk mengisi drum hingga penuh. Jika dengan luas penampang pipa 10 cm² dan volume 2 m³ dimana kecepatan air pada pipa 2 m/s, maka drum terisi penuh selama...',
      'options': ['0,0001 s', '1000 s', '0,01 s', '100 s', '0,1 s'],
      'correctAnswer': 'B',
      'explanation': 'Waktu = Volume / (Luas × Kecepatan)',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Bak air yang volumenya 200 liter diisi penuh dengan air. Pengisian bak tersebut menggunakan keran dengan luas penampang 8 cm². Jika bak air tersebut terisi penuh setelah diisi selama 20 sekon, kelajuan aliran air kerannya adalah...',
      'options': ['12,5 m/s', '15 m/s', '20 m/s', '22,5 m/s', '25 m/s'],
      'correctAnswer': 'A',
      'explanation': 'Kecepatan = Volume / (Luas × Kecepatan)',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Sayap pesawat terbang memiliki luas total 100 cm². Pesawat tersebut bergerak sehingga menghasilkan perbedaan kecepatan aliran udara di bagian atas dan bawah sayap berturut-turut 150 m/s dan 50 m/s. Jika massa jenis udara 1,3 kg/m³, besar gaya angkatnya adalah...',
      'options': ['13.00 N', '1.300 N', '130 N', '13 N', '1 N'],
      'correctAnswer': 'C',
      'explanation': 'Gaya angkat = ½ρA(v₁² - v₂²)',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Perhatikan gambar berikut. Jika air dalam tangki memancar keluar dari lubang A yang terletak pada dasar bejana, tinggi air (h) adalah... (g = 10 m/s²)',
      'options': ['6 m', '4,5 m', '4 m', '3 m', '1,5 m'],
      'correctAnswer': 'C',
      'explanation': 'Menggunakan persamaan gerak parabola dan Torricelli',
      'hasImage': true,
      'imagePath': 'assets/images/soal_12.png',
    },
    {
      'question': 'Pernyataan mengenai gaya angkat pesawat terbang yang benar ditunjukkan oleh pernyataan...',
      'options': [
        'Luas sayap tidak memengaruhi gaya angkat',
        'Tekanan udara bukan faktor yang berpengaruh',
        'Tekanan udara di bawah sayap pesawat lebih kecil dari atas pesawat',
        'Kecepatan aliran udara di bawah sayap pesawat lebih kecil dari atas pesawat',
        'Kecepatan aliran udara di bagian atas maupun bagian bawah sayap tidak berpengaruh'
      ],
      'correctAnswer': 'D',
      'explanation': 'Sesuai prinsip Bernoulli, kecepatan udara di atas sayap lebih besar, tekanan lebih kecil',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Perhatikan gambar berikut. Di dalam sebuah tabung terdapat zat cair (ideal). Terdapat dua lubang kecil pada dinding tabung, sehingga membuat zat cair memancar melalui lubang tersebut. Perbandingan antara x₁ dan x₂ adalah...',
      'options': ['1 : 3', '3 : 1', '4 : 5', '2 : 3', '3 : 2'],
      'correctAnswer': 'C',
      'explanation': 'Menggunakan persamaan gerak parabola untuk kedua pancaran',
      'hasImage': true,
      'imagePath': 'assets/images/soal_17.png',
    },
    {
      'question': 'Alat penyemprot serangga dan parfum memanfaatkan konsep Hukum...',
      'options': ['Pascal', 'Bernoulli', 'Archimedes', 'Hidrostatika', 'Stokes'],
      'correctAnswer': 'B',
      'explanation': 'Alat penyemprot menggunakan prinsip Bernoulli',
      'hasImage': false,
      'imagePath': null,
    },
    {
      'question': 'Tekanan dan kecepatan udara di atas sayap pesawat masing-masing P₁ dan v₁, sedangkan di bawah sayap adalah P₂ dan v₂. Agar sayap pesawat dapat mengangkat pesawat, persamaan berikut yang benar adalah...',
      'options': [
        'P₁ < P₂ dan v₁ > v₂',
        'P₁ < P₂ dan v₁ < v₂',
        'P₁ = P₂ dan v₁ > v₂',
        'P₁ > P₂ dan v₁ > v₂',
        'P₁ > P₂ dan v₁ = v₂'
      ],
      'correctAnswer': 'A',
      'explanation': 'Prinsip Bernoulli: kecepatan tinggi = tekanan rendah',
      'hasImage': false,
      'imagePath': null,
    },
  ];

  
  final Map<int, String> answerKey = {
    0: 'E', 1: 'E', 2: 'A', 3: 'A', 4: 'D', 5: 'D', 6: 'D', 7: 'B', 8: 'A', 9: 'C',
    10: 'C', 11: 'D', 12: 'C', 13: 'B', 14: 'A'
  };

  void startQuiz() {
    isQuizStarted.value = true;
    startTime = DateTime.now();
    currentQuestionIndex.value = 0;
    selectedAnswers.clear();
    isQuizCompleted.value = false;
    showResult.value = false;
  }

  void selectAnswer(String answer) {
    selectedAnswers[currentQuestionIndex.value] = answer;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {
      completeQuiz();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      currentQuestionIndex.value = index;
    }
  }

  void completeQuiz() {
    isQuizCompleted.value = true;
    showResult.value = true;
    timeSpent.value = DateTime.now().difference(startTime).inSeconds;
    
    
    _calculateAndSaveResults();
  }

  void _calculateAndSaveResults() {
    int correctAnswers = 0;
    List<Map<String, dynamic>> detailedAnswers = [];
    
    for (int i = 0; i < questions.length; i++) {
      String userAnswer = selectedAnswers[i] ?? '';
      String correctAnswer = answerKey[i] ?? '';
      bool isCorrect = userAnswer == correctAnswer;
      
      if (isCorrect) correctAnswers++;
      
      detailedAnswers.add({
        'questionIndex': i,
        'question': questions[i]['question'],
        'userAnswer': userAnswer,
        'correctAnswer': correctAnswer,
        'isCorrect': isCorrect,
        'options': questions[i]['options'],
        'explanation': questions[i]['explanation'],
      });
    }
    
    double percentage = (correctAnswers / questions.length) * 100;
    String grade = StorageService.calculateGrade(percentage);
    
    
    StorageService.to.saveQuizResult(
      quizTitle: 'Latihan Soal Fluida Dinamis',
      score: correctAnswers,
      totalQuestions: questions.length,
      percentage: percentage,
      grade: grade,
      completedAt: DateTime.now(),
      timeSpent: Duration(seconds: timeSpent.value),
      answers: detailedAnswers,
    );
  }

  
  Future<void> saveResultAsImage() async {
    try {
      bool hasPermission = await _requestStoragePermission();
      
      if (!hasPermission) {
        Get.snackbar(
          'Izin Diperlukan',
          'Aplikasi membutuhkan izin akses galeri untuk menyimpan screenshot',
          backgroundColor: AppColors.warning,
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          mainButton: TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text(
              'Pengaturan',
              style: AppText.pSmall(color: Colors.white),
            ),
          ),
        );
        return;
      }

      
      Get.dialog(
        Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.primary),
                SizedBox(height: 16),
                Text(
                  'Menyimpan screenshot...',
                  style: AppText.p(color: AppColors.dark),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      
      await Gal.putImageBytes(
        pngBytes,
        name: "quiz_result_${DateTime.now().millisecondsSinceEpoch}.png",
      );

      
      Get.back();

      Get.snackbar(
        'Berhasil!',
        'Screenshot hasil quiz berhasil disimpan ke galeri',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      
      Get.snackbar(
        'Error',
        'Gagal menyimpan screenshot: ${e.toString()}',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
    }
  }

  
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      
      int androidVersion = await _getAndroidVersion();
      
      if (androidVersion >= 33) {
        
        var status = await Permission.photos.status;
        if (status.isGranted) return true;
        
        
        status = await Permission.photos.request();
        
        if (status.isDenied) {
          _showPermissionDeniedDialog();
          return false;
        } else if (status.isPermanentlyDenied) {
          _showPermissionPermanentlyDeniedDialog();
          return false;
        }
        
        return status.isGranted;
      } else if (androidVersion >= 30) {
        
        var status = await Permission.manageExternalStorage.status;
        if (status.isGranted) return true;
        
        status = await Permission.manageExternalStorage.request();
        
        if (status.isDenied) {
          
          return await _requestLegacyStoragePermission();
        } else if (status.isPermanentlyDenied) {
          _showPermissionPermanentlyDeniedDialog();
          return false;
        }
        
        return status.isGranted;
      } else {
        
        return await _requestLegacyStoragePermission();
      }
    } else if (Platform.isIOS) {
      
      var status = await Permission.photos.status;
      if (status.isGranted) return true;
      
      status = await Permission.photos.request();
      
      if (status.isDenied) {
        _showPermissionDeniedDialog();
        return false;
      } else if (status.isPermanentlyDenied) {
        _showPermissionPermanentlyDeniedDialog();
        return false;
      }
      
      return status.isGranted;
    }
    
    return false;
  }

  Future<bool> _requestLegacyStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) return true;
    
    status = await Permission.storage.request();
    
    if (status.isDenied) {
      _showPermissionDeniedDialog();
      return false;
    } else if (status.isPermanentlyDenied) {
      _showPermissionPermanentlyDeniedDialog();
      return false;
    }
    
    return status.isGranted;
  }

  void _showPermissionDeniedDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Izin Diperlukan',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Aplikasi membutuhkan izin akses galeri untuk menyimpan screenshot hasil quiz. Silakan berikan izin untuk melanjutkan.',
          style: AppText.p(color: AppColors.dark),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: AppText.pSmall(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              saveResultAsImage(); 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Coba Lagi',
              style: AppText.pSmall(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showPermissionPermanentlyDeniedDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Izin Ditolak Permanen',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Izin akses galeri telah ditolak secara permanen. Untuk menyimpan screenshot, silakan buka Pengaturan aplikasi dan berikan izin secara manual.',
          style: AppText.p(color: AppColors.dark),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Batal',
              style: AppText.pSmall(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Buka Pengaturan',
              style: AppText.pSmall(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<int> _getAndroidVersion() async {
    try {
      
      
      if (Platform.isAndroid) {
        
        
        return 33; 
      }
      return 0;
    } catch (e) {
      return 30; 
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswers.clear();
    isQuizCompleted.value = false;
    isQuizStarted.value = false;
    showResult.value = false;
    timeSpent.value = 0;
  }

  void showQuizHistory() {
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: Get.height * 0.7,
          child: Column(
            children: [
              Text(
                'Riwayat Quiz',
                style: AppText.h5(color: AppColors.dark),
              ),
              SizedBox(height: 16),
              Expanded(
                child: _buildHistoryList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Tutup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    List<Map<String, dynamic>> results = StorageService.to.getQuizResults();
    
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: AppColors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Belum ada riwayat quiz',
              style: AppText.p(color: AppColors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        var result = results[index];
        DateTime completedAt = DateTime.parse(result['completedAt']);
        
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _getGradeColor(result['grade']),
            child: Text(
              result['grade'],
              style: AppText.h6(color: Colors.white),
            ),
          ),
          title: Text(
            '${result['score']}/${result['totalQuestions']} (${result['percentage'].toStringAsFixed(1)}%)',
            style: AppText.pSmallBold(),
          ),
          subtitle: Text(
            '${_formatDate(completedAt)} • ${_formatDuration(result['timeSpent'])}',
            style: AppText.small(color: AppColors.grey),
          ),
          onTap: () => _showDetailedResult(result),
        );
      },
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A': return AppColors.success;
      case 'B': return AppColors.info;
      case 'C': return AppColors.warning;
      case 'D': return AppColors.secondary;
      default: return AppColors.danger;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  void _showDetailedResult(Map<String, dynamic> result) {
    Get.back();
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: Get.height * 0.8,
          child: Column(
            children: [
              Text(
                'Detail Hasil Quiz',
                style: AppText.h5(color: AppColors.dark),
              ),
              SizedBox(height: 16),
              
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getGradeColor(result['grade']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getGradeColor(result['grade']).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getGradeColor(result['grade']),
                      child: Text(
                        result['grade'],
                        style: AppText.h6(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${result['score']}/${result['totalQuestions']} (${result['percentage'].toStringAsFixed(1)}%)',
                            style: AppText.h6(color: AppColors.dark),
                          ),
                          Text(
                            '${_formatDate(DateTime.parse(result['completedAt']))} • ${_formatDuration(result['timeSpent'])}',
                            style: AppText.small(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Jawaban:',
                        style: AppText.pSmallBold(color: AppColors.dark),
                      ),
                      SizedBox(height: 12),
                      
                      ...List.generate(
                        (result['answers'] as List).length,
                        (index) {
                          var answer = result['answers'][index];
                          bool isCorrect = answer['isCorrect'];
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCorrect ? AppColors.success : AppColors.danger,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isCorrect ? AppColors.success : AppColors.danger,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        isCorrect ? Icons.check : Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Soal ${index + 1}',
                                      style: AppText.pSmallBold(color: AppColors.dark),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  answer['question'],
                                  style: AppText.pSmall(color: AppColors.dark),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Jawaban Anda: ',
                                      style: AppText.small(color: AppColors.grey),
                                    ),
                                    Text(
                                      answer['userAnswer'].isEmpty ? 'Tidak dijawab' : answer['userAnswer'],
                                      style: AppText.smallBold(
                                        color: answer['userAnswer'].isEmpty 
                                            ? AppColors.danger 
                                            : (isCorrect ? AppColors.success : AppColors.danger),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Jawaban Benar: ',
                                      style: AppText.small(color: AppColors.grey),
                                    ),
                                    Text(
                                      answer['correctAnswer'],
                                      style: AppText.smallBold(color: AppColors.success),
                                    ),
                                  ],
                                ),
                                if (answer['explanation'] != null) ...[
                                  SizedBox(height: 4),
                                  Text(
                                    'Penjelasan: ${answer['explanation']}',
                                    style: AppText.small(color: AppColors.info),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Tutup',
                    style: AppText.pSmall(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    
    
    print('📝 LatihanSoalController initialized');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  
  
  
  Map<String, dynamic> getCurrentQuestion() {
    return questions[currentQuestionIndex.value];
  }

  
  bool isCurrentQuestionAnswered() {
    return selectedAnswers.containsKey(currentQuestionIndex.value);
  }

  
  double getProgressPercentage() {
    return (currentQuestionIndex.value + 1) / questions.length;
  }

  
  int getAnsweredQuestionsCount() {
    return selectedAnswers.length;
  }

  
  int getUnansweredQuestionsCount() {
    return questions.length - selectedAnswers.length;
  }

  
  bool canCompleteQuiz() {
    return selectedAnswers.length == questions.length;
  }

  
  Map<String, dynamic> getCurrentQuizStats() {
    int correctAnswers = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == answerKey[i]) {
        correctAnswers++;
      }
    }
    
    double percentage = selectedAnswers.isNotEmpty 
        ? (correctAnswers / selectedAnswers.length) * 100 
        : 0.0;
    
    return {
      'totalQuestions': questions.length,
      'answeredQuestions': selectedAnswers.length,
      'correctAnswers': correctAnswers,
      'percentage': percentage,
      'grade': StorageService.calculateGrade(percentage),
    };
  }

  
  void showCompleteQuizDialog() {
    if (!canCompleteQuiz()) {
      Get.dialog(
        AlertDialog(
          title: Text(
            'Quiz Belum Selesai',
            style: AppText.h6(color: AppColors.dark),
          ),
          content: Text(
            'Anda masih memiliki ${getUnansweredQuestionsCount()} soal yang belum dijawab. Apakah Anda yakin ingin menyelesaikan quiz?',
            style: AppText.p(color: AppColors.dark),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Batal',
                style: AppText.pSmall(color: AppColors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                completeQuiz();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Selesaikan',
                style: AppText.pSmall(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } else {
      completeQuiz();
    }
  }

  
  void showQuizNavigationDialog() {
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: Get.height * 0.6,
          child: Column(
            children: [
              Text(
                'Navigasi Soal',
                style: AppText.h6(color: AppColors.dark),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    bool isAnswered = selectedAnswers.containsKey(index);
                    bool isCurrent = index == currentQuestionIndex.value;
                    
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Get.back();
                          goToQuestion(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCurrent 
                                ? AppColors.primary
                                : isAnswered 
                                    ? AppColors.success.withOpacity(0.7)
                                    : AppColors.muted,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isCurrent 
                                  ? AppColors.primary
                                  : isAnswered 
                                      ? AppColors.success
                                      : AppColors.grey,
                              width: isCurrent ? 2 : 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: AppText.pSmallBold(
                                color: isCurrent || isAnswered 
                                    ? Colors.white 
                                    : AppColors.dark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  _buildLegendItem(AppColors.primary, 'Saat ini'),
                  SizedBox(width: 16),
                  _buildLegendItem(AppColors.success, 'Sudah dijawab'),
                  SizedBox(width: 16),
                  _buildLegendItem(AppColors.muted, 'Belum dijawab'),
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: AppText.small(color: AppColors.dark),
        ),
      ],
    );
  }
}