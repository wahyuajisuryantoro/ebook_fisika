import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/riwayat_kuis_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_responsive.dart';

class RiwayatKuisView extends GetView<RiwayatKuisController> {
  const RiwayatKuisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Riwayat Quiz',
          style: AppText.h5(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'statistics':
                  controller.showStatistics();
                  break;
                case 'clear_all':
                  controller.clearAllResults();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'statistics',
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Statistik', style: AppText.p()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    const Icon(Icons.delete_sweep, color: AppColors.danger),
                    const SizedBox(width: 8),
                    Text('Hapus Semua',
                        style: AppText.p(color: AppColors.danger)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(context),
          _buildResultsCount(context),
          Expanded(
            child: _buildQuizResultsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: controller.searchController,
            onChanged: controller.onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Cari berdasarkan judul atau tanggal...',
              hintStyle: AppText.p(color: AppColors.grey),
              prefixIcon: const Icon(Icons.search, color: AppColors.grey),
              suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: AppColors.grey),
                      onPressed: controller.clearSearch,
                    )
                  : const SizedBox()),
              filled: true,
              fillColor: AppColors.whiteOld,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: AppText.p(color: AppColors.dark),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.filterOptions.map((filter) {
                return Obx(() => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(filter),
                        selected: controller.selectedFilter.value == filter,
                        onSelected: (_) => controller.setFilter(filter),
                        backgroundColor: AppColors.whiteOld,
                        selectedColor: AppColors.primary.withOpacity(0.2),
                        checkmarkColor: AppColors.primary,
                        labelStyle: AppText.small(
                          color: controller.selectedFilter.value == filter
                              ? AppColors.primary
                              : AppColors.dark,
                        ),
                        side: BorderSide(
                          color: controller.selectedFilter.value == filter
                              ? AppColors.primary
                              : AppColors.muted,
                        ),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsCount(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColors.whiteOld,
          child: Text(
            'Ditemukan ${controller.filteredResults.length} hasil quiz',
            style: AppText.pSmall(color: AppColors.grey),
          ),
        ));
  }

  Widget _buildQuizResultsList(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }

      if (controller.filteredResults.isEmpty) {
        return _buildEmptyState(context);
      }

      return RefreshIndicator(
        onRefresh: () async => controller.loadQuizResults(),
        color: AppColors.primary,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filteredResults.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final result = controller.filteredResults[index];
            return _buildQuizResultCard(context, result);
          },
        ),
      );
    });
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 80,
            color: AppColors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            controller.quizResults.isEmpty
                ? 'Belum ada riwayat quiz'
                : 'Tidak ada hasil yang sesuai',
            style: AppText.h6(color: AppColors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            controller.quizResults.isEmpty
                ? 'Mulai mengerjakan quiz untuk melihat riwayat'
                : 'Coba ubah filter atau kata kunci pencarian',
            style: AppText.p(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
          if (controller.quizResults.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.toNamed('/latihan-soal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Mulai Quiz',
                style: AppText.button(color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuizResultCard(
      BuildContext context, Map<String, dynamic> result) {
    DateTime completedAt = DateTime.parse(result['completedAt']);
    String grade = result['grade'];
    double percentage = result['percentage'].toDouble();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => controller.showDetailedResult(result),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: controller.getGradeColor(grade),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        grade,
                        style: AppText.h6(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['quizTitle'],
                          style: AppText.pSmallBold(color: AppColors.dark),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.formatDate(completedAt),
                          style: AppText.small(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: AppColors.grey),
                    onSelected: (value) {
                      switch (value) {
                        case 'detail':
                          controller.showDetailedResult(result);
                          break;
                        case 'delete':
                          controller.deleteQuizResult(result['id']);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'detail',
                        child: Row(
                          children: [
                            const Icon(Icons.visibility, color: AppColors.info),
                            const SizedBox(width: 8),
                            Text('Lihat Detail', style: AppText.pSmall()),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(Icons.delete, color: AppColors.danger),
                            const SizedBox(width: 8),
                            Text('Hapus',
                                style: AppText.pSmall(color: AppColors.danger)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildScoreItem(
                      'Skor',
                      '${result['score']}/${result['totalQuestions']}',
                      Icons.assignment_turned_in,
                    ),
                  ),
                  Expanded(
                    child: _buildScoreItem(
                      'Persentase',
                      '${percentage.toStringAsFixed(1)}%',
                      Icons.percent,
                    ),
                  ),
                  Expanded(
                    child: _buildScoreItem(
                      'Waktu',
                      controller.formatDuration(result['timeSpent']),
                      Icons.access_time,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: AppText.small(color: AppColors.grey),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(1)}%',
                        style: AppText.smallBold(
                            color: controller.getGradeColor(grade)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: AppColors.muted,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      controller.getGradeColor(grade),
                    ),
                    minHeight: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppText.pSmallBold(color: AppColors.dark),
        ),
        Text(
          label,
          style: AppText.small(color: AppColors.grey),
        ),
      ],
    );
  }
}
