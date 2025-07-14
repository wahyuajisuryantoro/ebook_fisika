import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_responsive.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/latihan_soal_controller.dart';

class LatihanSoalView extends GetView<LatihanSoalController> {
  const LatihanSoalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Latihan Soal',
          style: AppText.h6(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.showQuizHistory,
            icon: Icon(Icons.history, color: Colors.white),
            tooltip: 'Riwayat Quiz',
          ),
        ],
      ),
      body: Obx(() {
        if (!controller.isQuizStarted.value) {
          return _buildStartScreen(context);
        } else if (controller.showResult.value) {
          return _buildResultScreen(context);
        } else {
          return _buildQuizScreen(context);
        }
      }),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildStartScreen(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppResponsive.width(context, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppResponsive.width(context, 4)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppResponsive.width(context, 2)),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.quiz,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: AppResponsive.width(context, 3)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latihan Soal Fluida Dinamis',
                            style: AppText.h5(color: AppColors.dark),
                          ),
                          SizedBox(height: AppResponsive.height(context, 0.5)),
                          Text(
                            'Uji pemahaman Anda tentang materi fluida dinamis',
                            style: AppText.pSmall(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: AppResponsive.height(context, 3)),

          // Quiz Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppResponsive.width(context, 4)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.muted, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Quiz',
                  style: AppText.h6(color: AppColors.dark),
                ),
                SizedBox(height: AppResponsive.height(context, 2)),
                _buildInfoRow(Icons.quiz, 'Jumlah Soal', '${controller.questions.length} soal'),
                SizedBox(height: AppResponsive.height(context, 1)),
                _buildInfoRow(Icons.timer, 'Waktu', 'Tidak terbatas'),
                SizedBox(height: AppResponsive.height(context, 1)),
                _buildInfoRow(Icons.image, 'Tipe Soal', 'Pilihan ganda + gambar'),
                SizedBox(height: AppResponsive.height(context, 1)),
                _buildInfoRow(Icons.grade, 'Penilaian', 'A (≥90%), B (≥80%), C (≥70%), D (≥60%), E (<60%)'),
              ],
            ),
          ),

          SizedBox(height: AppResponsive.height(context, 3)),

          // Start Button
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.startQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: AppResponsive.height(context, 2)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Mulai Quiz',
                    style: AppText.h6(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: AppResponsive.height(context, 2)),

          // Tips Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppResponsive.width(context, 4)),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.info.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.info,
                      size: 20,
                    ),
                    SizedBox(width: AppResponsive.width(context, 2)),
                    Text(
                      'Tips Mengerjakan',
                      style: AppText.pSmallBold(color: AppColors.dark),
                    ),
                  ],
                ),
                SizedBox(height: AppResponsive.height(context, 1)),
                Text(
                  '• Baca soal dengan cermat, terutama yang ada gambarnya\n• Perhatikan satuan dalam perhitungan\n• Gunakan rumus yang tepat untuk setiap konsep\n• Hasil quiz akan tersimpan dalam riwayat',
                  style: AppText.pSmall(color: AppColors.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: AppText.pSmall(color: AppColors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: AppText.pSmall(color: AppColors.dark),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizScreen(BuildContext context) {
    return Column(
      children: [
        // Progress Bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        'Soal ${controller.currentQuestionIndex.value + 1} dari ${controller.questions.length}',
                        style: AppText.pSmallBold(color: AppColors.dark),
                      )),
                  Text(
                    'Latihan Soal',
                    style: AppText.pSmall(color: AppColors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Obx(() => LinearProgressIndicator(
                    value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
                    backgroundColor: AppColors.muted,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  )),
            ],
          ),
        ),

        // Question Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Obx(() {
              final question = controller.questions[controller.currentQuestionIndex.value];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question Text
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.muted, width: 1),
                    ),
                    child: Text(
                      question['question'],
                      style: AppText.p(color: AppColors.dark),
                    ),
                  ),

                  // Question Image (if exists)
                  if (question['hasImage'] == true) ...[
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.muted, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: InteractiveViewer(
                          panEnabled: true,
                          boundaryMargin: EdgeInsets.all(20),
                          minScale: 0.5,
                          maxScale: 3.0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Image.asset(
                              question['imagePath'],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: AppColors.muted,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                          color: AppColors.grey,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Gambar tidak tersedia',
                                          style: AppText.pSmall(color: AppColors.grey),
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
                    ),
                  ],

                  SizedBox(height: 16),

                  // Answer Options
                  Text(
                    'Pilih jawaban yang tepat:',
                    style: AppText.pSmallBold(color: AppColors.dark),
                  ),
                  SizedBox(height: 12),

                  ...List.generate(
                    question['options'].length,
                    (index) {
                      final option = question['options'][index];
                      final optionLetter = String.fromCharCode(65 + index); // A, B, C, D, E
                      final isSelected = controller.selectedAnswers[controller.currentQuestionIndex.value] == optionLetter;

                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => controller.selectAnswer(optionLetter),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.muted,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.primary : AppColors.muted,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        optionLetter,
                                        style: AppText.pSmallBold(
                                          color: isSelected ? Colors.white : AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: AppText.p(
                                        color: isSelected ? AppColors.primary : AppColors.dark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ),

        // Navigation Buttons
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Previous Button
              Obx(() => Expanded(
                    child: ElevatedButton(
                      onPressed: controller.currentQuestionIndex.value > 0
                          ? controller.previousQuestion
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.muted,
                        foregroundColor: AppColors.dark,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chevron_left, size: 20),
                          Text('Sebelumnya', style: AppText.pSmall()),
                        ],
                      ),
                    ),
                  )),

              SizedBox(width: 12),

              // Next/Finish Button
              Obx(() => Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.selectedAnswers.containsKey(controller.currentQuestionIndex.value)) {
                          controller.nextQuestion();
                        } else {
                          Get.snackbar(
                            'Perhatian',
                            'Silakan pilih jawaban terlebih dahulu',
                            backgroundColor: AppColors.warning,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.currentQuestionIndex.value == controller.questions.length - 1
                                ? 'Selesai'
                                : 'Selanjutnya',
                            style: AppText.pSmall(color: Colors.white),
                          ),
                          Icon(
                            controller.currentQuestionIndex.value == controller.questions.length - 1
                                ? Icons.check
                                : Icons.chevron_right,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultScreen(BuildContext context) {
    return RepaintBoundary(
      key: controller.repaintBoundaryKey,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Obx(() {
            int correctAnswers = 0;
            for (int i = 0; i < controller.questions.length; i++) {
              if (controller.selectedAnswers[i] == controller.answerKey[i]) {
                correctAnswers++;
              }
            }
            
            double percentage = (correctAnswers / controller.questions.length) * 100;
            String grade = _getGrade(percentage);
            Color gradeColor = _getGradeColor(grade);

            return Column(
              children: [
                // Result Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradeColor.withOpacity(0.1), gradeColor.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: gradeColor.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: gradeColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            grade,
                            style: AppText.h2(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Quiz Selesai!',
                        style: AppText.h5(color: AppColors.dark),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: AppText.h3(color: gradeColor),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$correctAnswers dari ${controller.questions.length} jawaban benar',
                        style: AppText.p(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Statistics
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Waktu',
                        _formatTime(controller.timeSpent.value),
                        Icons.timer,
                        AppColors.info,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Akurasi',
                        '${percentage.toStringAsFixed(0)}%',
                        Icons.crisis_alert,
                        AppColors.success,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Action Buttons
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.saveResultAsImage,
                        icon: Icon(Icons.download, color: Colors.white),
                        label: Text(
                          'Simpan Screenshot',
                          style: AppText.pSmallBold(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.resetQuiz,
                            icon: Icon(Icons.refresh, size: 20),
                            label: Text('Ulangi', style: AppText.pSmall()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.showQuizHistory,
                            icon: Icon(Icons.history, size: 20),
                            label: Text('Riwayat', style: AppText.pSmall()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.muted,
                              foregroundColor: AppColors.dark,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Review Answers
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.muted.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Review Jawaban',
                        style: AppText.h6(color: AppColors.dark),
                      ),
                      SizedBox(height: 12),
                      ...List.generate(
                        controller.questions.length,
                        (index) {
                          String userAnswer = controller.selectedAnswers[index] ?? '';
                          String correctAnswer = controller.answerKey[index] ?? '';
                          bool isCorrect = userAnswer == correctAnswer;

                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isCorrect ? AppColors.success : AppColors.danger,
                                width: 1,
                              ),
                            ),
                            child: Row(
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
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Soal ${index + 1}',
                                        style: AppText.pSmallBold(color: AppColors.dark),
                                      ),
                                      Text(
                                        'Jawaban Anda: ${userAnswer.isEmpty ? "Tidak dijawab" : userAnswer} • Jawaban Benar: $correctAnswer',
                                        style: AppText.small(color: AppColors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(value, style: AppText.h6(color: color)),
          Text(title, style: AppText.small(color: AppColors.grey)),
        ],
      ),
    );
  }

  String _getGrade(double percentage) {
    if (percentage >= 90) return 'A';
    if (percentage >= 80) return 'B';
    if (percentage >= 70) return 'C';
    if (percentage >= 60) return 'D';
    return 'E';
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

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}