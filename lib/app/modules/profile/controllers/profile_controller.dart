import 'package:ebook_fisika/app/routes/app_pages.dart';
import 'package:ebook_fisika/app/service/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class ProfileController extends GetxController {
  final StorageService _storageService = StorageService.to;
  final ImagePicker _picker = ImagePicker();

  final isEditing = false.obs;
  final isLoading = false.obs;
  final profileImagePath = ''.obs;

  final nameController = TextEditingController();
  final schoolController = TextEditingController();
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final userName = ''.obs;
  final userSchool = ''.obs;
  final userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    schoolController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void loadUserProfile() {
    try {
      final profile = _storageService.getUserProfile();

      userName.value = profile['name'] ?? '';
      userSchool.value = profile['school'] ?? '';
      userEmail.value = profile['email'] ?? '';
      profileImagePath.value = profile['profileImage'] ?? '';

      nameController.text = userName.value;
      schoolController.text = userSchool.value;
      emailController.text = userEmail.value;
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  void toggleEdit() {
    isEditing.toggle();
    if (!isEditing.value) {
      nameController.text = userName.value;
      schoolController.text = userSchool.value;
      emailController.text = userEmail.value;
    }
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      _storageService.saveUserProfile(
        name: nameController.text.trim(),
        school: schoolController.text.trim(),
        email: emailController.text.trim(),
        profileImage: profileImagePath.value,
      );

      userName.value = nameController.text.trim();
      userSchool.value = schoolController.text.trim();
      userEmail.value = emailController.text.trim();

      isEditing.value = false;

      Get.snackbar(
        'Berhasil',
        'Profile berhasil disimpan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan profile: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToScoreHistory() {
    Get.toNamed(Routes.RIWAYAT_KUIS);
  }

  Map<String, dynamic> getStatistics() {
    return _storageService.getStatistics();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.trim().length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }

  String? validateSchool(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Instansi/sekolah tidak boleh kosong';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  Future<void> changeProfilePhoto() async {
    if (!isEditing.value) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pilih Foto Profile',
              style: AppText.h6(color: AppColors.dark),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text('Kamera', style: AppText.p(color: AppColors.dark)),
              onTap: () {
                Get.back();
                _pickImageWithRetry(ImageSource.camera);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: AppColors.primary),
              title: Text('Galeri', style: AppText.p(color: AppColors.dark)),
              onTap: () {
                Get.back();
                _pickImageWithRetry(ImageSource.gallery);
              },
            ),
            if (profileImagePath.value.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: AppColors.danger),
                title: Text('Hapus Foto',
                    style: AppText.p(color: AppColors.danger)),
                onTap: () {
                  Get.back();
                  _removeProfilePhoto();
                },
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text('Batal', style: AppText.p(color: AppColors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageWithRetry(ImageSource source,
      {int retryCount = 0}) async {
    try {
      await _pickImage(source);
    } on PlatformException catch (e) {
      if (e.code == 'channel-error' && retryCount < 2) {
        await Future.delayed(const Duration(seconds: 1));
        return _pickImageWithRetry(source, retryCount: retryCount + 1);
      } else {
        _showImagePickerFallback(source);
      }
    }
  }

  void _showImagePickerFallback(ImageSource source) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Gagal Mengakses ${source == ImageSource.camera ? 'Kamera' : 'Galeri'}',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Terjadi masalah saat mengakses ${source == ImageSource.camera ? 'kamera' : 'galeri'}. Silakan coba:\n\n'
          '1. Restart aplikasi\n'
          '2. Periksa izin aplikasi di pengaturan\n'
          '3. Coba gunakan ${source == ImageSource.camera ? 'galeri' : 'kamera'} sebagai alternatif',
          style: AppText.p(color: AppColors.dark),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Tutup',
              style: AppText.pSmall(color: AppColors.grey),
            ),
          ),
          if (source == ImageSource.camera)
            ElevatedButton(
              onPressed: () {
                Get.back();
                _pickImageWithRetry(ImageSource.gallery);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Coba Galeri',
                style: AppText.pSmall(color: Colors.white),
              ),
            )
          else
            ElevatedButton(
              onPressed: () {
                Get.back();
                _pickImageWithRetry(ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Coba Kamera',
                style: AppText.pSmall(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      bool hasPermission = await _requestStoragePermission();
      if (!hasPermission) return;

      await Future.delayed(const Duration(milliseconds: 500));

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 512,
        maxHeight: 512,
        requestFullMetadata: false,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (await file.exists()) {
          profileImagePath.value = pickedFile.path;

          Get.snackbar(
            'Berhasil',
            'Foto profile berhasil dipilih',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.success,
            colorText: Colors.white,
          );
        } else {
          throw Exception('File tidak ditemukan');
        }
      }
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code} - ${e.message}');

      if (e.code == 'channel-error') {
        Get.snackbar(
          'Error',
          'Gagal mengakses kamera/galeri. Silakan coba lagi atau restart aplikasi.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.danger,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
      } else if (e.code == 'camera_access_denied') {
        Get.snackbar(
          'Izin Kamera',
          'Izin kamera diperlukan untuk mengambil foto',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.warning,
          colorText: Colors.white,
        );
      } else if (e.code == 'photo_access_denied') {
        Get.snackbar(
          'Izin Galeri',
          'Izin galeri diperlukan untuk memilih foto',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.warning,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'Terjadi kesalahan: ${e.message}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.danger,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('General error: $e');
      Get.snackbar(
        'Error',
        'Gagal memilih foto: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    }
  }

  void _removeProfilePhoto() {
    profileImagePath.value = '';
    Get.snackbar(
      'Berhasil',
      'Foto profile telah dihapus',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
    );
  }

  Future<bool> _requestStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        var photosStatus = await Permission.photos.status;
        if (photosStatus.isGranted) return true;

        photosStatus = await Permission.photos.request();
        if (photosStatus.isGranted) return true;

        var storageStatus = await Permission.storage.status;
        if (storageStatus.isGranted) return true;

        storageStatus = await Permission.storage.request();
        if (storageStatus.isGranted) return true;

        if (photosStatus.isPermanentlyDenied ||
            storageStatus.isPermanentlyDenied) {
          _showPermissionPermanentlyDeniedDialog();
        } else {
          _showPermissionDeniedDialog();
        }
        return false;
      } else if (Platform.isIOS) {
        var status = await Permission.photos.status;
        if (status.isGranted) return true;

        status = await Permission.photos.request();
        if (status.isGranted) return true;

        if (status.isPermanentlyDenied) {
          _showPermissionPermanentlyDeniedDialog();
        } else {
          _showPermissionDeniedDialog();
        }
        return false;
      }

      return true;
    } catch (e) {
      print('Error requesting permission: $e');
      return false;
    }
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

  Future<int> _getAndroidVersion() async {
    return 30;
  }

  void _showPermissionDeniedDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Izin Diperlukan',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Aplikasi membutuhkan izin akses galeri untuk mengubah foto profile. Silakan berikan izin untuk melanjutkan.',
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
              changeProfilePhoto();
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
          'Izin akses galeri telah ditolak permanen. Silakan buka pengaturan aplikasi untuk mengaktifkan izin secara manual.',
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
}
