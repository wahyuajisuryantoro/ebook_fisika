import 'package:ebook_fisika/app/components/custom_navbar_bottom_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/video_pembelajaran_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_responsive.dart';

class VideoPembelajaranView extends GetView<VideoPembelajaranController> {
  const VideoPembelajaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isFullScreen.value) {
        return _buildFullScreenView(context);
      }
      
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Video Pembelajaran',
            style: AppText.h5(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          children: [
            
            _buildVideoPlayerSection(context),
            
            
            _buildVideoInfoSection(context),
            
            
            Expanded(
              child: _buildPlaylistSection(context),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      );
    });
  }

  Widget _buildFullScreenView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            
            Center(
              child: _buildVideoPlayer(context, isFullScreen: true),
            ),
            
            
            Positioned(
              top: 40,
              right: 20,
              child: SafeArea(
                child: IconButton(
                  onPressed: controller.toggleFullScreen,
                  icon: const Icon(
                    Icons.fullscreen_exit,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            
            
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: _buildVideoControls(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerSection(BuildContext context) {
    return Container(
      height: AppResponsive.height(context, 30),
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          _buildVideoPlayer(context),
          
          
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: controller.toggleFullScreen,
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context, {bool isFullScreen = false}) {
    return Obx(() {
      if (!controller.isControllerReady.value || 
          controller.youtubePlayerController == null) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }
      
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller.youtubePlayerController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.primary,
          progressColors: const ProgressBarColors(
            playedColor: AppColors.primary,
            handleColor: AppColors.secondary,
          ),
          onReady: () {
            print('YouTube player ready for video: ${controller.getCurrentVideoTitle()}');
          },
          onEnded: (metaData) {
            print('Video ended, playing next');
            controller.playNext();
          },
        ),
        builder: (context, player) {
          return isFullScreen 
              ? player 
              : Column(
                  children: [
                    Expanded(child: player),
                    if (!isFullScreen) _buildVideoControls(context),
                  ],
                );
        },
      );
    });
  }

  Widget _buildVideoControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.dark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: controller.playPrevious,
            icon: const Icon(Icons.skip_previous, color: Colors.white),
          ),
          Obx(() => IconButton(
            onPressed: controller.togglePlayPause,
            icon: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          )),
          IconButton(
            onPressed: controller.playNext,
            icon: const Icon(Icons.skip_next, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfoSection(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            controller.getCurrentVideoTitle(),
            style: AppText.h5(color: AppColors.dark),
          )),
          const SizedBox(height: 8),
          Obx(() => Text(
            'Video ${controller.selectedVideoIndex.value + 1} dari ${controller.videoPlaylist.length}',
            style: AppText.pSmall(color: AppColors.grey),
          )),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.play_circle_outline, 
                   color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() => Text(
                  controller.getCurrentVideoUrl(),
                  style: AppText.small(color: AppColors.info),
                  overflow: TextOverflow.ellipsis,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection(BuildContext context) {
    return Container(
      color: AppColors.whiteOld,
      child: Column(
        children: [
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: AppColors.muted, width: 1),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.playlist_play, 
                           color: AppColors.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Playlist Video',
                  style: AppText.h6(color: AppColors.dark),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${controller.videoPlaylist.length} Video',
                    style: AppText.small(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.videoPlaylist.length,
              itemBuilder: (context, index) {
                final video = controller.videoPlaylist[index];
                return _buildPlaylistItem(
                  context,
                  index,
                  video['title']!,
                  video['youtubeUrl']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistItem(BuildContext context, int index, String title, 
                           String url) {
    return Obx(() {
      final isSelected = controller.selectedVideoIndex.value == index;
      
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.muted,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.muted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: isSelected
                  ? const Icon(Icons.play_arrow, color: Colors.white, size: 24)
                  : Text(
                      '${index + 1}',
                      style: AppText.h6(color: AppColors.dark),
                    ),
            ),
          ),
          title: Text(
            title,
            style: AppText.pSmallBold(
              color: isSelected ? AppColors.primary : AppColors.dark,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Video ${index + 1}',
              style: AppText.small(color: AppColors.grey),
            ),
          ),
          trailing: isSelected
              ? const Icon(Icons.volume_up, color: AppColors.primary)
              : const Icon(Icons.play_circle_outline, color: AppColors.grey),
          onTap: () => controller.selectVideo(index),
        ),
      );
    });
  }
}