import 'package:ebook_fisika/app/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';

class RiwayatKuisController extends GetxController {
  final StorageService _storageService = StorageService.to;

  final isLoading = false.obs;
  final quizResults = <Map<String, dynamic>>[].obs;
  final filteredResults = <Map<String, dynamic>>[].obs;
  final selectedFilter = 'Semua'.obs;
  final searchQuery = ''.obs;

  final searchController = TextEditingController();

  final List<String> filterOptions = [
    'Semua',
    'Grade A',
    'Grade B',
    'Grade C',
    'Grade D',
    'Grade E'
  ];

  @override
  void onInit() {
    super.onInit();
    loadQuizResults();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadQuizResults() {
    try {
      isLoading.value = true;
      final results = _storageService.getQuizResults();
      quizResults.value = results;
      applyFilter();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat riwayat quiz: $e',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    List<Map<String, dynamic>> filtered = List.from(quizResults);

    if (selectedFilter.value != 'Semua') {
      String targetGrade = selectedFilter.value.split(' ')[1];
      filtered =
          filtered.where((result) => result['grade'] == targetGrade).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((result) {
        String title = result['quizTitle'].toString().toLowerCase();
        String date =
            formatDate(DateTime.parse(result['completedAt'])).toLowerCase();
        String query = searchQuery.value.toLowerCase();
        return title.contains(query) || date.contains(query);
      }).toList();
    }

    filteredResults.value = filtered;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    applyFilter();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    applyFilter();
  }

  void deleteQuizResult(String resultId) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Hapus Riwayat',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus riwayat quiz ini?',
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
              _performDelete(resultId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Hapus',
              style: AppText.pSmall(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _performDelete(String resultId) {
    try {
      _storageService.deleteQuizResult(resultId);
      loadQuizResults();
      Get.snackbar(
        'Berhasil',
        'Riwayat quiz berhasil dihapus',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus riwayat: $e',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    }
  }

  void clearAllResults() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Hapus Semua Riwayat',
          style: AppText.h6(color: AppColors.dark),
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus SEMUA riwayat quiz? Tindakan ini tidak dapat dibatalkan.',
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
              _performClearAll();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Hapus Semua',
              style: AppText.pSmall(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _performClearAll() {
    try {
      _storageService.clearAllQuizResults();
      loadQuizResults();
      Get.snackbar(
        'Berhasil',
        'Semua riwayat quiz berhasil dihapus',
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus semua riwayat: $e',
        backgroundColor: AppColors.danger,
        colorText: Colors.white,
      );
    }
  }

  void showDetailedResult(Map<String, dynamic> result) {
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: Get.height * 0.8,
          child: Column(
            children: [
              Text(
                'Detail Hasil Quiz',
                style: AppText.h5(color: AppColors.dark),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: getGradeColor(result['grade']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: getGradeColor(result['grade']).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: getGradeColor(result['grade']),
                      child: Text(
                        result['grade'],
                        style: AppText.h6(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${result['score']}/${result['totalQuestions']} (${result['percentage'].toStringAsFixed(1)}%)',
                            style: AppText.h6(color: AppColors.dark),
                          ),
                          Text(
                            '${formatDate(DateTime.parse(result['completedAt']))} • ${formatDuration(result['timeSpent'])}',
                            style: AppText.small(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Jawaban:',
                        style: AppText.pSmallBold(color: AppColors.dark),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        (result['answers'] as List).length,
                        (index) {
                          var answer = result['answers'][index];
                          bool isCorrect = answer['isCorrect'];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCorrect
                                    ? AppColors.success
                                    : AppColors.danger,
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
                                        color: isCorrect
                                            ? AppColors.success
                                            : AppColors.danger,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        isCorrect ? Icons.check : Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Soal ${index + 1}',
                                      style: AppText.pSmallBold(
                                          color: AppColors.dark),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  answer['question'],
                                  style: AppText.pSmall(color: AppColors.dark),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Jawaban Anda: ',
                                      style:
                                          AppText.small(color: AppColors.grey),
                                    ),
                                    Text(
                                      answer['userAnswer'].isEmpty
                                          ? 'Tidak dijawab'
                                          : answer['userAnswer'],
                                      style: AppText.smallBold(
                                        color: answer['userAnswer'].isEmpty
                                            ? AppColors.danger
                                            : (isCorrect
                                                ? AppColors.success
                                                : AppColors.danger),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Jawaban Benar: ',
                                      style:
                                          AppText.small(color: AppColors.grey),
                                    ),
                                    Text(
                                      answer['correctAnswer'],
                                      style: AppText.smallBold(
                                          color: AppColors.success),
                                    ),
                                  ],
                                ),
                                if (answer['explanation'] != null) ...[
                                  const SizedBox(height: 4),
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
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

  void showStatistics() {
    final stats = _storageService.getStatistics();

    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Statistik Quiz',
                style: AppText.h5(color: AppColors.dark),
              ),
              const SizedBox(height: 20),
              _buildStatItem(
                  'Total Percobaan', '${stats['totalAttempts']}', Icons.quiz),
              _buildStatItem('Skor Terbaik',
                  '${stats['bestScore'].toStringAsFixed(1)}%', Icons.star),
              _buildStatItem(
                  'Rata-rata Skor',
                  '${stats['averageScore'].toStringAsFixed(1)}%',
                  Icons.trending_up),
              _buildStatItem('Skor Terakhir',
                  '${stats['lastScore'].toStringAsFixed(1)}%', Icons.history),
              _buildStatItem('Perfect Scores', '${stats['perfectScores']}',
                  Icons.emoji_events),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteOld,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.muted),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.pSmall(color: AppColors.grey),
                ),
                Text(
                  value,
                  style: AppText.h6(color: AppColors.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return AppColors.success;
      case 'B':
        return AppColors.info;
      case 'C':
        return AppColors.warning;
      case 'D':
        return AppColors.secondary;
      default:
        return AppColors.danger;
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}
