import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class VideoPembelajaranController extends GetxController {
  final selectedVideoIndex = 0.obs;
  final isPlaying = false.obs;
  final isLoading = true.obs;
  final playFromYoutube = true.obs;
  final isControllerReady = false.obs;
  final isFullScreen = false.obs;
  
  YoutubePlayerController? youtubePlayerController;
  
  final List<Map<String, String>> videoPlaylist = [
    {
      'id': '1',
      'title': 'Fluida Ideal',
      'youtubeUrl': 'https://youtu.be/USbszEO-InM?si=rrV0sxzW06ZGBaTU',
      'localPath': 'assets/video/video_1.mp4',
    },
    {
      'id': '2',
      'title': 'Persamaan Kontinuitas',
      'youtubeUrl': 'https://youtu.be/QZiQsLvpt0g?si=DVxNGccvjcqkM8pR',
      'localPath': 'assets/video/video_2.mp4',
    },
    {
      'id': '3',
      'title': 'Asas Bernoulli',
      'youtubeUrl': 'https://youtu.be/ETH8FWXKI0E?si=NxLlsnsTVjuwugXg',
      'localPath': 'assets/video/video_3.mp4',
    },
    {
      'id': '4',
      'title': 'Kebocoran Dinding Tangki',
      'youtubeUrl': 'https://youtu.be/o6_7J4VFoIQ?si=BwnbcIdjAEFYcxmL',
      'localPath': 'assets/video/video_4.mp4',
    },
    {
      'id': '5',
      'title': 'Gaya Angkat Sayap Pesawat',
      'youtubeUrl': 'https://youtu.be/vqSTIcZ7bNs?si=IER1cwFwyOBRiHSG',
      'localPath': 'assets/video/video_5.mp4',
    },
    {
      'id': '6',
      'title': 'Pipa Venturi',
      'youtubeUrl': 'https://youtu.be/u9nsalbEUe8?si=OxIPe6FXUiwYgp1h',
      'localPath': 'assets/video/video_6.mp4',
    },
    {
      'id': '7',
      'title': 'Tabung Pitot',
      'youtubeUrl': 'https://youtu.be/taPlUNVNP1o?si=TDpDVLZ4F8J4gVoq',
      'localPath': 'assets/video/video_7.mp4',
    },
    {
      'id': '8',
      'title': 'Alat Penyemprot',
      'youtubeUrl': 'https://youtu.be/dubvJyYVRRU?si=tAXvC3JbIBOgfIZR',
      'localPath': 'assets/video/video_8.mp4',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    initializePlayer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    
    _disposeController();
    super.onClose();
  }

  void _disposeController() {
    if (youtubePlayerController != null) {
      try {
        youtubePlayerController!.dispose();
      } catch (e) {
        print('Error disposing controller: $e');
      }
      youtubePlayerController = null;
      isControllerReady.value = false;
    }
  }

  void initializePlayer() {
    if (videoPlaylist.isNotEmpty) {
      _createController(0);
    }
  }

  void _createController(int index) {

    _disposeController();
    
    isLoading.value = true;
    isControllerReady.value = false;
    
    final videoId = YoutubePlayer.convertUrlToId(videoPlaylist[index]['youtubeUrl']!);
    if (videoId != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
          loop: false,
          forceHD: false,
          hideControls: false,
          controlsVisibleAtStart: true,
          disableDragSeek: false,
          useHybridComposition: true,
        ),
      );
      
      youtubePlayerController!.addListener(_playerStateListener);
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (youtubePlayerController != null) {
          isControllerReady.value = true;
          isLoading.value = false;
          isPlaying.value = true;
        }
      });
    }
  }

  void _playerStateListener() {
    if (youtubePlayerController != null && isControllerReady.value) {
      try {
        final isPlayerPlaying = youtubePlayerController!.value.isPlaying;
        if (isPlaying.value != isPlayerPlaying) {
          isPlaying.value = isPlayerPlaying;
        }
      } catch (e) {
        print('Error in player state listener: $e');
      }
    }
  }

  void selectVideo(int index) {
    if (index >= 0 && index < videoPlaylist.length) {
      print('Selecting video $index: ${videoPlaylist[index]['title']}');
      selectedVideoIndex.value = index;
      _createController(index);
    }
  }

  void togglePlayPause() {
    if (youtubePlayerController != null && isControllerReady.value) {
      try {
        if (isPlaying.value) {
          youtubePlayerController!.pause();
          isPlaying.value = false;
        } else {
          youtubePlayerController!.play();
          isPlaying.value = true;
        }
      } catch (e) {
        print('Error toggling play/pause: $e');
      }
    }
  }

  void playNext() {
    if (selectedVideoIndex.value < videoPlaylist.length - 1) {
      selectVideo(selectedVideoIndex.value + 1);
    }
  }

  void playPrevious() {
    if (selectedVideoIndex.value > 0) {
      selectVideo(selectedVideoIndex.value - 1);
    }
  }

  void toggleFullScreen() {
    isFullScreen.toggle();
    if (isFullScreen.value) {

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void exitFullScreen() {
    if (isFullScreen.value) {
      isFullScreen.value = false;
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  String getCurrentVideoTitle() {
    return videoPlaylist[selectedVideoIndex.value]['title'] ?? '';
  }

  String getCurrentVideoUrl() {
    return videoPlaylist[selectedVideoIndex.value]['youtubeUrl'] ?? '';
  }

  void toggleVideoSource() {
    playFromYoutube.toggle();
  }
}