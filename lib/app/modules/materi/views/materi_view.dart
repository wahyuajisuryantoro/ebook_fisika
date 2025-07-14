import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_responsive.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/materi_controller.dart';

class MateriView extends GetView<MateriController> {
  const MateriView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Materi Pembelajaran',
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
                          Icons.school,
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
                              'Pilih Materi',
                              style: AppText.h5(color: AppColors.dark),
                            ),
                            SizedBox(height: AppResponsive.height(context, 0.5)),
                            Text(
                              'Silakan pilih materi yang ingin dipelajari',
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

            
           ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.materiList.length,
              separatorBuilder: (context, index) => SizedBox(
                height: AppResponsive.height(context, 1.5),
              ),
              itemBuilder: (context, index) {
                final materi = controller.materiList[index];
                return Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.selectedIndex.value == index
                          ? Colors.blueGrey
                          : Colors.blueGrey,
                      width: controller.selectedIndex.value == index ? 2 : 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        controller.navigateToMateri(materi['route'], index);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(AppResponsive.width(context, 4)),
                        child: Row(
                          children: [
                            
                            Container(
                              width: AppResponsive.width(context, 12),
                              height: AppResponsive.width(context, 12),
                              decoration: BoxDecoration(
                                color: materi['color'].withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: materi['color'].withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                materi['icon'],
                                color: materi['color'],
                                size: 24,
                              ),
                            ),

                            SizedBox(width: AppResponsive.width(context, 4)),

                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    materi['title'],
                                    style: AppText.h6(color: AppColors.dark),
                                  ),
                                  SizedBox(height: AppResponsive.height(context, 0.5)),
                                  Text(
                                    materi['description'],
                                    style: AppText.pSmall(color: AppColors.grey),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            
                            Container(
                              padding: EdgeInsets.all(AppResponsive.width(context, 1.5)),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == index
                                    ? materi['color']
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
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.info,
                    size: 20,
                  ),
                  SizedBox(width: AppResponsive.width(context, 2)),
                  Expanded(
                    child: Text(
                      'Pelajari materi secara berurutan untuk pemahaman yang optimal',
                      style: AppText.pSmall(color: AppColors.dark),
                    ),
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
