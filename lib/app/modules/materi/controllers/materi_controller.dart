import 'package:ebook_fisika/app/routes/app_pages.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MateriController extends GetxController {
  final selectedIndex = (-1).obs;

  final List<Map<String, dynamic>> materiList = [
    {
      'title': 'Peta Konsep',
      'icon': Icons.map,
      'color': AppColors.info,
      'route': null,
      'description': 'Visualisasi konsep pembelajaran'
    },
    {
      'title': 'Sub Bab 1',
      'icon': Icons.book_outlined,
      'color': AppColors.primary,
      'route': null,
      'description': 'Materi pembelajaran bagian 1'
    },
    {
      'title': 'Sub Bab 2',
      'icon': Icons.book_outlined,
      'color': AppColors.primary,
      'route': null,
      'description': 'Materi pembelajaran bagian 2'
    },
    {
      'title': 'Sub Bab 3',
      'icon': Icons.book_outlined,
      'color': AppColors.primary,
      'route': null,
      'description': 'Materi pembelajaran bagian 3'
    },
    {
      'title': 'Sub Bab 4',
      'icon': Icons.book_outlined,
      'color': AppColors.primary,
      'route': null,
      'description': 'Materi pembelajaran bagian 4'
    },
    {
      'title': 'Rangkuman',
      'icon': Icons.summarize,
      'color': AppColors.success,
      'route': null,
      'description': 'Ringkasan materi pembelajaran'
    },
    {
      'title': 'Glosarium',
      'icon': Icons.library_books,
      'color': AppColors.warning,
      'route': null,
      'description': 'Kamus istilah penting'
    },
    {
      'title': 'Physics Around Us',
      'icon': Icons.explore,
      'color': AppColors.secondary,
      'route': null,
      'description': 'Fisika dalam kehidupan sehari-hari'
    },
  ];

  void navigateToMateri(String? route, int index) {
    selectedIndex.value = index;

    if (index == 0) {
      showPetaKonsepModal();
      return;
    }

    if (index == 1) {
      showSubBab1Modal();
      return;
    }

    if (index == 2) {
      showSubBab2Modal();
      return;
    }

    if (index == 3) {
      showSubBab3Modal();
      return;
    }

    if (index == 4) {
      showSubBab4Modal();
      return;
    }

    if (index == 5) {
      showRangkumanModal();
      return;
    }

    if (index == 6) {
      showGlosariumModal();
      return;
    }

    if (route != null) {
      Get.toNamed(route);
    }
  }

  void showPetaKonsepModal() {
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
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          Text(
                            'Peta Konsep',
                            style: AppText.h6(color: Colors.white),
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
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: EdgeInsets.all(20),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/images/peta_konsep.png',
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
                                        style: AppText.pSmall(
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.zoom_in,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Pinch atau scroll untuk zoom in/out',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showSubBab1Modal() {
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          Text(
                            'Sub Bab 1',
                            style: AppText.h6(color: Colors.white),
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
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: EdgeInsets.all(20),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/images/1.1.jpg',
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
                                        style: AppText.pSmall(
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.zoom_in,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Pinch atau scroll untuk zoom in/out',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showSubBab2Modal() {
    final currentImageIndex = 0.obs;
    final subBab2Images = [
      'assets/images/2.1.png',
      'assets/images/2.2.png',
      'assets/images/2.3.png',
      'assets/images/2.4.png',
    ];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          Obx(() => Text(
                                'Sub Bab 2 - Gambar ${currentImageIndex.value + 1}/${subBab2Images.length}',
                                style: AppText.h6(color: Colors.white),
                              )),
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
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: subBab2Images.length,
                        onPageChanged: (index) {
                          currentImageIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                subBab2Images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.muted,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 60,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Gambar ${index + 1} tidak ditemukan',
                                            style: AppText.pSmall(
                                                color: AppColors.grey),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                subBab2Images.asMap().entries.map((entry) {
                              return Container(
                                width: currentImageIndex.value == entry.key
                                    ? 12
                                    : 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: currentImageIndex.value == entry.key
                                      ? AppColors.primary
                                      : AppColors.muted,
                                ),
                              );
                            }).toList(),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swipe,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Swipe untuk ganti gambar',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showSubBab3Modal() {
    final currentImageIndex = 0.obs;
    final subBab3Images = [
      'assets/images/3.1.png',
      'assets/images/3.2.png',
      'assets/images/3.3.png',
    ];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          Obx(() => Text(
                                'Sub Bab 3 - Gambar ${currentImageIndex.value + 1}/${subBab3Images.length}',
                                style: AppText.h6(color: Colors.white),
                              )),
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
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: subBab3Images.length,
                        onPageChanged: (index) {
                          currentImageIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                subBab3Images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.muted,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 60,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Gambar ${index + 1} tidak ditemukan',
                                            style: AppText.pSmall(
                                                color: AppColors.grey),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                subBab3Images.asMap().entries.map((entry) {
                              return Container(
                                width: currentImageIndex.value == entry.key
                                    ? 12
                                    : 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: currentImageIndex.value == entry.key
                                      ? AppColors.primary
                                      : AppColors.muted,
                                ),
                              );
                            }).toList(),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swipe,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Swipe untuk ganti gambar',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showSubBab4Modal() {
    final currentImageIndex = 0.obs;
    final subBab4Images = [
      'assets/images/4.01.png',
      'assets/images/4.02.png',
      'assets/images/4.03.png',
      'assets/images/4.04.png',
      'assets/images/4.05.png',
      'assets/images/4.06.png',
      'assets/images/4.07.png',
      'assets/images/4.08.png',
      'assets/images/4.09.png',
      'assets/images/4.10.png',
      'assets/images/4.11.png',
      'assets/images/4.12.png',
    ];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          Obx(() => Text(
                                'Sub Bab 4 - Gambar ${currentImageIndex.value + 1}/${subBab4Images.length}',
                                style: AppText.h6(color: Colors.white),
                              )),
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
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: subBab4Images.length,
                        onPageChanged: (index) {
                          currentImageIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                subBab4Images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.muted,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 60,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Gambar ${index + 1} tidak ditemukan',
                                            style: AppText.pSmall(
                                                color: AppColors.grey),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                subBab4Images.asMap().entries.map((entry) {
                              return Container(
                                width: currentImageIndex.value == entry.key
                                    ? 12
                                    : 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: currentImageIndex.value == entry.key
                                      ? AppColors.primary
                                      : AppColors.muted,
                                ),
                              );
                            }).toList(),
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swipe,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Swipe untuk ganti gambar',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showRangkumanModal() {
    final currentImageIndex = 0.obs;
    final rangkumanImages = [
      'assets/images/rangkum_1.png',
      'assets/images/rangkum_2.png',
      'assets/images/rangkum_3.png',
    ];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
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
                          Obx(() => Text(
                                'Rangkuman - Halaman ${currentImageIndex.value + 1}/${rangkumanImages.length}',
                                style: AppText.h6(color: Colors.white),
                              )),
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
                    
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: rangkumanImages.length,
                        onPageChanged: (index) {
                          currentImageIndex.value = index;
                        },
                        itemBuilder: (context, index) {
                          return InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                rangkumanImages[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.muted,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 60,
                                            color: AppColors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Halaman ${index + 1} tidak ditemukan',
                                            style: AppText.pSmall(
                                                color: AppColors.grey),
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
                    
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                rangkumanImages.asMap().entries.map((entry) {
                              return Container(
                                width: currentImageIndex.value == entry.key
                                    ? 12
                                    : 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: currentImageIndex.value == entry.key
                                      ? AppColors.primary
                                      : AppColors.muted,
                                ),
                              );
                            }).toList(),
                          )),
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.swipe,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Swipe untuk ganti halaman',
                            style: AppText.pSmall(color: AppColors.grey),
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

  void showGlosariumModal() {
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
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
                          Text(
                            'Glosarium',
                            style: AppText.h6(color: Colors.white),
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
                    
                    Container(
                      height: Get.height * 0.7,
                      width: double.infinity,
                      child: InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: EdgeInsets.all(20),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Image.asset(
                            'assets/images/glosarium.jpg',
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
                                        style: AppText.pSmall(
                                            color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.zoom_in,
                            size: 16,
                            color: AppColors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Pinch atau scroll untuk zoom in/out',
                            style: AppText.pSmall(color: AppColors.grey),
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
