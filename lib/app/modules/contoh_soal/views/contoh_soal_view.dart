import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_responsive.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contoh_soal_controller.dart';

class ContohSoalView extends GetView<ContohSoalController> {
  const ContohSoalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Contoh Soal',
          style: AppText.h6(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                              'Pilih Contoh Soal',
                              style: AppText.h5(color: AppColors.dark),
                            ),
                            SizedBox(height: AppResponsive.height(context, 0.5)),
                            Text(
                              'Pelajari contoh soal dan penyelesaiannya',
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

            // List Contoh Soal
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.contohSoalList.length,
              separatorBuilder: (context, index) => SizedBox(
                height: AppResponsive.height(context, 1.5),
              ),
              itemBuilder: (context, index) {
                final soal = controller.contohSoalList[index];
                final bool hasPenyelesaian = (soal['penyelesaianImages'] as List).isNotEmpty;
                
                return Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.selectedIndex.value == index
                          ? AppColors.primary
                          : AppColors.muted,
                      width: controller.selectedIndex.value == index ? 2 : 1,
                    ),
                    boxShadow: controller.selectedIndex.value == index
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ]
                        : [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            )
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        controller.navigateToContohSoal(index);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(AppResponsive.width(context, 4)),
                        child: Row(
                          children: [
                            // Icon Container
                            Container(
                              width: AppResponsive.width(context, 12),
                              height: AppResponsive.width(context, 12),
                              decoration: BoxDecoration(
                                color: soal['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: soal['color'].withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                soal['icon'],
                                color: soal['color'],
                                size: 24,
                              ),
                            ),

                            SizedBox(width: AppResponsive.width(context, 4)),

                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          soal['title'],
                                          style: AppText.h6(color: AppColors.dark),
                                        ),
                                      ),
                                      // Status badge
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppResponsive.width(context, 2),
                                          vertical: AppResponsive.height(context, 0.3),
                                        ),
                                        decoration: BoxDecoration(
                                          color: hasPenyelesaian 
                                              ? AppColors.success.withOpacity(0.1)
                                              : AppColors.warning.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: hasPenyelesaian 
                                                ? AppColors.success.withOpacity(0.3)
                                                : AppColors.warning.withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              hasPenyelesaian 
                                                  ? Icons.check_circle
                                                  : Icons.help_outline,
                                              size: 12,
                                              color: hasPenyelesaian 
                                                  ? AppColors.success
                                                  : AppColors.warning,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              hasPenyelesaian ? 'Lengkap' : 'Soal',
                                              style: AppText.overline(
                                                color: hasPenyelesaian 
                                                    ? AppColors.success
                                                    : AppColors.warning,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppResponsive.height(context, 0.5)),
                                  Text(
                                    soal['description'],
                                    style: AppText.pSmall(color: AppColors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (hasPenyelesaian) ...[
                                    SizedBox(height: AppResponsive.height(context, 0.5)),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lightbulb_outline,
                                          size: 14,
                                          color: AppColors.success,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${(soal['penyelesaianImages'] as List).length} penyelesaian',
                                          style: AppText.small(color: AppColors.success),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Arrow Icon
                            Container(
                              padding: EdgeInsets.all(AppResponsive.width(context, 1.5)),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == index
                                    ? soal['color']
                                    : AppColors.muted,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.chevron_right,
                                color: controller.selectedIndex.value == index
                                    ? Colors.white
                                    : AppColors.grey,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
              },
            ),

            SizedBox(height: AppResponsive.height(context, 3)),

            // Info Card
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                        size: 20,
                      ),
                      SizedBox(width: AppResponsive.width(context, 2)),
                      Expanded(
                        child: Text(
                          'Tips belajar yang efektif',
                          style: AppText.pSmallBold(color: AppColors.dark),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppResponsive.height(context, 1)),
                  Text(
                    '• Pahami soal terlebih dahulu sebelum melihat penyelesaian\n• Coba kerjakan sendiri, lalu bandingkan dengan penyelesaian\n• Pelajari langkah-langkah penyelesaian secara detail',
                    style: AppText.pSmall(color: AppColors.dark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}