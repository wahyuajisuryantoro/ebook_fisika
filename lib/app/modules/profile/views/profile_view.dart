import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_responsive.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profil',
          style: AppText.h5(color: Colors.white),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isEditing.value ? Icons.close : Icons.edit,
                  color: Colors.white,
                ),
                onPressed: controller.toggleEdit,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildProfileForm(context),
            _buildActionButtons(context),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
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
          Obx(() => Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.info,
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
                      child: controller.profileImagePath.value.isNotEmpty
                          ? Image.file(
                              File(controller.profileImagePath.value),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                );
                              },
                            )
                          : const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  controller.isEditing.value
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: controller.changeProfilePhoto,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondary,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              )),
          const SizedBox(height: 16),
          Obx(() => controller.isEditing.value
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Edit',
                    style: AppText.small(color: Colors.white),
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            _buildProfileField(
              label: 'Nama Lengkap',
              controller: controller.nameController,
              validator: controller.validateName,
              currentValue: controller.userName,
            ),
            const SizedBox(height: 20),
            _buildProfileField(
              label: 'Instansi/sekolah',
              controller: controller.schoolController,
              validator: controller.validateSchool,
              currentValue: controller.userSchool,
            ),
            const SizedBox(height: 20),
            _buildProfileField(
              label: 'Alamat E-mail',
              controller: controller.emailController,
              validator: controller.validateEmail,
              currentValue: controller.userEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 32),
            Obx(() => controller.isEditing.value
                ? SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Simpan Perubahan',
                              style: AppText.button(color: Colors.white),
                            ),
                    ),
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required RxString currentValue,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label :',
          style: AppText.pSmallBold(color: AppColors.dark),
        ),
        const SizedBox(height: 8),
        Obx(() => this.controller.isEditing.value
            ? TextFormField(
                controller: controller,
                validator: validator,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: 'Masukkan $label',
                  hintStyle: AppText.p(color: AppColors.grey),
                  filled: true,
                  fillColor: AppColors.whiteOld,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.muted),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.muted),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: AppText.p(color: AppColors.dark),
              )
            : Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.whiteOld,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.muted),
                ),
                child: Text(
                  currentValue.value.isEmpty
                      ? '.............................'
                      : currentValue.value,
                  style: AppText.p(
                    color: currentValue.value.isEmpty
                        ? AppColors.grey
                        : AppColors.dark,
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.navigateToScoreHistory,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'DAFTAR NILAI',
                style: AppText.button(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
