import 'dart:io';

import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../utils/app_text.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppResponsive.width(context, 5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppResponsive.width(context, 4)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Profile Avatar
                    GestureDetector(
                      onTap: controller.navigateToProfile,
                      child: Obx(() => CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primary,
                            child: controller.profileImagePath.value.isNotEmpty
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller.profileImagePath.value),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        );
                                      },
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                          )),
                    ),

                    SizedBox(width: AppResponsive.width(context, 3)),

                    // Greeting and Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.greeting,
                            style: AppText.h5(color: AppColors.dark),
                          ),
                          SizedBox(height: AppResponsive.height(context, 0.5)),
                          Obx(() => Text(
                                controller.userName.value,
                                style: AppText.h3(color: AppColors.primary),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppResponsive.height(context, 3)),
              Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: AppResponsive.height(context, 20),
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        controller.onCarouselChanged(index);
                      },
                    ),
                    items: controller.carouselImages.map((imagePath) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: AppResponsive.width(context, 1),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.muted,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: AppColors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: AppResponsive.height(context, 2)),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.carouselImages
                            .asMap()
                            .entries
                            .map((entry) {
                          return Container(
                            width: controller.currentCarouselIndex.value ==
                                    entry.key
                                ? 12
                                : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: controller.currentCarouselIndex.value ==
                                      entry.key
                                  ? AppColors.primary
                                  : AppColors.muted,
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
              SizedBox(height: AppResponsive.height(context, 4)),
              Text(
                'Menu Utama',
                style: AppText.h4(color: AppColors.dark),
              ),
              SizedBox(height: AppResponsive.height(context, 2)),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppResponsive.width(context, 3),
                  mainAxisSpacing: AppResponsive.height(context, 2),
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.menuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = controller.menuItems[index];
                  return Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.navigateToMenu(menuItem['route']!);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: 9 / 16,
                                child: Image.asset(
                                  menuItem['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppColors.muted,
                                      child: Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          size: 40,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppResponsive.height(context, 1)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.navigateToMenu(menuItem['route']!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppResponsive.width(context, 3),
                              vertical: AppResponsive.height(context, 0.8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                menuItem['title']!,
                                style: AppText.pSmall(color: Colors.white),
                              ),
                              SizedBox(width: AppResponsive.width(context, 1)),
                              Icon(
                                Icons.chevron_right,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: AppResponsive.height(context, 2)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
