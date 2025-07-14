import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContohSoalController extends GetxController {
  final selectedIndex = (-1).obs;

  // Data struktur contoh soal dengan mapping gambar soal dan penyelesaian
  final List<Map<String, dynamic>> contohSoalList = [
    {
      'title': 'Contoh Soal 1.1',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 1',
      'soalImage': 'assets/images/1.1.1.png',
      'penyelesaianImages': ['assets/images/1.1.2.png'],
    },
    {
      'title': 'Contoh Soal 2.1',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 2.1',
      'soalImage': 'assets/images/2.1.1.png',
      'penyelesaianImages': ['assets/images/2.1.2.png'],
    },
    {
      'title': 'Contoh Soal 2.2',
      'icon': Icons.quiz,
      'color': AppColors.secondary,
      'description': 'Soal tanpa penyelesaian',
      'soalImage': 'assets/images/2.2.png',
      'penyelesaianImages': [], // Tidak ada penyelesaian
    },
    {
      'title': 'Contoh Soal 3.1',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 3',
      'soalImage': 'assets/images/3.1.1.png',
      'penyelesaianImages': ['assets/images/3.1.2.png'],
    },
    {
      'title': 'Contoh Soal 4.1',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dengan 2 penyelesaian',
      'soalImage': 'assets/images/4.1.1.png',
      'penyelesaianImages': ['assets/images/4.1.2.png', 'assets/images/4.1.3.png'],
    },
    {
      'title': 'Contoh Soal 4.2',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.2',
      'soalImage': 'assets/images/4.2.1.png',
      'penyelesaianImages': ['assets/images/4.2.2.png'],
    },
    {
      'title': 'Contoh Soal 4.3',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.3',
      'soalImage': 'assets/images/4.3.1.png',
      'penyelesaianImages': ['assets/images/4.3.2.png'],
    },
    {
      'title': 'Contoh Soal 4.4',
      'icon': Icons.quiz,
      'color': AppColors.secondary,
      'description': 'Soal tanpa penyelesaian',
      'soalImage': 'assets/images/4.4.png',
      'penyelesaianImages': [], // Tidak ada penyelesaian
    },
    {
      'title': 'Contoh Soal 4.5',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.5',
      'soalImage': 'assets/images/4.5.1.png',
      'penyelesaianImages': ['assets/images/4.5.2.png'],
    },
    {
      'title': 'Contoh Soal 4.6',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.6',
      'soalImage': 'assets/images/4.6.1.png',
      'penyelesaianImages': ['assets/images/4.6.2.png'],
    },
    {
      'title': 'Contoh Soal 4.7',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.7',
      'soalImage': 'assets/images/4.7.1.png',
      'penyelesaianImages': ['assets/images/4.7.2.png'],
    },
    {
      'title': 'Contoh Soal 4.8',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dan penyelesaian bab 4.8',
      'soalImage': 'assets/images/4.8.1.png',
      'penyelesaianImages': ['assets/images/4.8.2.png'],
    },
    {
      'title': 'Contoh Soal 4.9',
      'icon': Icons.quiz,
      'color': AppColors.primary,
      'description': 'Soal dengan 2 penyelesaian',
      'soalImage': 'assets/images/4.9.1.png',
      'penyelesaianImages': ['assets/images/4.9.2.png', 'assets/images/4.9.3.png'],
    },
  ];

  void navigateToContohSoal(int index) {
    selectedIndex.value = index;
    final soal = contohSoalList[index];
    showContohSoalModal(soal, index);
  }

  void showContohSoalModal(Map<String, dynamic> soal, int index) {
    final currentViewIndex = 0.obs; // 0 = soal, 1+ = penyelesaian
    final List<String> penyelesaianImages = List<String>.from(soal['penyelesaianImages']);
    final bool hasPenyelesaian = penyelesaianImages.isNotEmpty;
    
    // Total views = 1 (soal) + jumlah penyelesaian
    final totalViews = 1 + penyelesaianImages.length;

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                height: Get.height * 0.9, // Batasi tinggi maksimal
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Obx(() {
                              String title = soal['title'];
                              if (currentViewIndex.value == 0) {
                                title += ' - Soal';
                              } else {
                                if (penyelesaianImages.length > 1) {
                                  title += ' - Penyelesaian ${currentViewIndex.value}/${penyelesaianImages.length}';
                                } else {
                                  title += ' - Penyelesaian';
                                }
                              }
                              return Text(
                                title,
                                style: AppText.h6(color: Colors.white),
                              );
                            }),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content Area
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: PageView.builder(
                        itemCount: totalViews,
                        onPageChanged: (index) {
                          currentViewIndex.value = index;
                        },
                        itemBuilder: (context, pageIndex) {
                          String imagePath;
                          
                          if (pageIndex == 0) {
                            // Halaman soal
                            imagePath = soal['soalImage'];
                          } else {
                            // Halaman penyelesaian
                            imagePath = penyelesaianImages[pageIndex - 1];
                          }

                          return InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.muted,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 60,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Gambar tidak ditemukan',
                                            style: AppText.pSmall(color: AppColors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ),

                    // Navigation dots (hanya tampil jika ada penyelesaian)
                    if (hasPenyelesaian)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(totalViews, (index) {
                                return Container(
                                  width: currentViewIndex.value == index ? 12 : 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: currentViewIndex.value == index
                                        ? (index == 0 ? AppColors.info : AppColors.success)
                                        : AppColors.muted,
                                  ),
                                );
                              }),
                            )),
                      ),

                    // Navigation buttons
                    if (hasPenyelesaian)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Obx(() => Row(
                              children: [
                                // Button Soal
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: currentViewIndex.value == 0
                                        ? null
                                        : () => currentViewIndex.value = 0,
                                    icon: Icon(
                                      Icons.quiz,
                                      size: 16,
                                      color: currentViewIndex.value == 0
                                          ? Colors.white
                                          : AppColors.info,
                                    ),
                                    label: Text(
                                      'Soal',
                                      style: AppText.pSmall(
                                        color: currentViewIndex.value == 0
                                            ? Colors.white
                                            : AppColors.info,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentViewIndex.value == 0
                                          ? AppColors.info
                                          : AppColors.info.withOpacity(0.1),
                                      elevation: currentViewIndex.value == 0 ? 2 : 0,
                                      side: BorderSide(
                                        color: AppColors.info,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Button Penyelesaian
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: currentViewIndex.value > 0
                                        ? null
                                        : () => currentViewIndex.value = 1,
                                    icon: Icon(
                                      Icons.lightbulb,
                                      size: 16,
                                      color: currentViewIndex.value > 0
                                          ? Colors.white
                                          : AppColors.success,
                                    ),
                                    label: Text(
                                      'Penyelesaian',
                                      style: AppText.pSmall(
                                        color: currentViewIndex.value > 0
                                            ? Colors.white
                                            : AppColors.success,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentViewIndex.value > 0
                                          ? AppColors.success
                                          : AppColors.success.withOpacity(0.1),
                                      elevation: currentViewIndex.value > 0 ? 2 : 0,
                                      side: BorderSide(
                                        color: AppColors.success,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),

                    // Footer info
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            hasPenyelesaian ? Icons.swipe : Icons.zoom_in,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              hasPenyelesaian
                                  ? 'Swipe untuk navigasi atau gunakan tombol di atas'
                                  : 'Pinch atau scroll untuk zoom in/out',
                              style: AppText.pSmall(color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

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