
import 'package:ebook_fisika/app/components/custom_navbar_bottom_controller.dart';
import 'package:ebook_fisika/app/utils/app_colors.dart';
import 'package:ebook_fisika/app/utils/app_responsive.dart';
import 'package:ebook_fisika/app/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({super.key});

  final BottomNavigationBarController navigationController =
      Get.put(BottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigationController.updateIndexBasedOnRoute(Get.currentRoute);
    });

    return Container(
      height: AppResponsive.height(context, 8),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.secondary,
      ),
      child: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex.value,
          onTap: (index) {
            navigationController.changePage(index);
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade300,
          showUnselectedLabels: false, 
          selectedLabelStyle: AppText.small(color: Colors.white),
          unselectedLabelStyle: AppText.small(color: Colors.grey.shade300),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: [
            _buildNavItem(
              context,
              icon: Remix.home_2_line,
              label: "", 
              index: 0,
            ),
            _buildNavItem(
              context,
              icon: Remix.book_2_line,
              label: "",  
              index: 1,
            ),
            _buildNavItem(
              context,
              icon: Remix.book_shelf_line,
              label: "",  
              index: 2,
            ),
            _buildNavItem(
              context,
              icon: Remix.puzzle_2_line,
              label: "",  
              index: 3,
            ),
            _buildNavItem(
              context,
              icon: Remix.video_line,
              label: "",  
              index: 4,
            ),
             _buildNavItem(
              context,
              icon: Remix.user_2_line,
              label: "",  
              index: 5,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = navigationController.currentIndex.value == index;

    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
              padding: EdgeInsets.all(AppResponsive.width(context, 2.5)),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppResponsive.width(context, 5.5),
              ),
            )
          : Icon(
              icon,
              size: AppResponsive.width(context,5.5),
              color: Colors.grey.shade300,
            ),
      label: label, 
    );
  }
}