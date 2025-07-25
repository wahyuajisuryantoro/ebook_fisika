import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tentang_kami_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_responsive.dart';

class TentangKamiView extends GetView<TentangKamiController> {
  const TentangKamiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tentang Kami',
          style: AppText.h5(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(context),
            _buildAppDescriptionSection(context),
            _buildTeamSection(context),
            _buildContactSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTeamPhoto('assets/images/team_1.png'),
              _buildTeamPhoto('assets/images/team_2.png'),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'ABOUT US',
            style: AppText.h2(color: Colors.white).copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPhoto(String imagePath) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.muted,
              child: const Icon(
                Icons.person,
                size: 60,
                color: AppColors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppDescriptionSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang Aplikasi',
            style: AppText.h4(color: AppColors.dark),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.whiteOld,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.muted),
            ),
            child: Text(
              controller.appDescription,
              style: AppText.p(color: AppColors.dark),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tim Pengembang',
            style: AppText.h4(color: AppColors.dark),
          ),
          const SizedBox(height: 20),
          _buildTeamMemberCard(
            context,
            controller.teamMembers[0],
            isMainDeveloper: true,
          ),
          const SizedBox(height: 20),
          _buildTeamMemberCard(
            context,
            controller.teamMembers[1],
            isMainDeveloper: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(BuildContext context, Map<String, String> member,
      {required bool isMainDeveloper}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMainDeveloper ? AppColors.primary : AppColors.secondary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isMainDeveloper ? AppColors.primary : AppColors.secondary,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                member['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.muted,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            member['name']!,
            style: AppText.h5(
              color: isMainDeveloper ? AppColors.primary : AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isMainDeveloper
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              member['role']!,
              style: AppText.small(
                color:
                    isMainDeveloper ? AppColors.primary : AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isMainDeveloper
                ? controller.studentProfile
                : controller.dosenDescription,
            style: AppText.pSmall(color: AppColors.dark),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Kontak',
            style: AppText.h5(color: Colors.white),
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.email,
            title: 'Email',
            subtitle: 'fannyverawaty.2018@student.uny.ac.id',
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.email,
            title: 'Email Dosen',
            subtitle: 'supahar@uny.ac.id',
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.play_circle,
            title: 'YouTube',
            subtitle: '@fannyverawaty',
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Universitas Negeri Yogyakarta',
                  style: AppText.h6(color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pendidikan Fisika',
                  style: AppText.pSmall(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppText.smallBold(color: AppColors.primary),
              ),
              Text(
                subtitle,
                style: AppText.small(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
