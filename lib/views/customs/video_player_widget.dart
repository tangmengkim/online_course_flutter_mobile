import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/customs/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_application_1/model/lesson_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

class VideoPlayerWidget extends StatelessWidget {
  final LessonModel lesson;
  final VideoController controller = Get.put(VideoController());

  VideoPlayerWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    controller.initializeVideo(lesson);
    return Obx(() =>
        controller.chewieControllers.containsKey(lesson.id.toString())
            ? Chewie(
                controller: controller.chewieControllers[lesson.id.toString()]!)
            : Center(child: CircularProgressIndicator()));
  }
}

class VideoController extends GetxController {
  final RxMap videoControllers = {}.obs;
  final RxMap chewieControllers = {}.obs;
  final Rx<LessonModel?> currentlyPlayingLesson = Rx<LessonModel?>(null);
  final Rx<LessonModel?> currentlyStartPlayLesson = Rx<LessonModel?>(null);
  final RxBool isloading = false.obs;
  final Rx<DurationRange> durationRange =
      DurationRange(Duration(seconds: 0), Duration(seconds: 0)).obs;
  final RxBool isPlaying = false.obs;

  void initializeVideo(LessonModel lesson) async {
    currentlyStartPlayLesson.value = lesson;
    print("Video loading...");
    isloading(true);
    disposeVideo(lesson.id.toString());
    var videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(lesson.videoUrl));

    try {
      await videoPlayerController.initialize();
      videoControllers[lesson.id.toString()] = videoPlayerController;
      chewieControllers[lesson.id.toString()] = ChewieController(
        videoPlayerController: videoPlayerController,
        showControls: true,
        hideControlsTimer: Duration(seconds: 3),
        looping: false,
        autoPlay: true,
        allowFullScreen: true,
        customControls:
            CustomVideoControls(videoPlayerController: videoPlayerController),
      );
      currentlyPlayingLesson.value = lesson;
      update();
    } catch (err) {
      currentlyStartPlayLesson.value = null;
      currentlyPlayingLesson.value = null;
      print("Failed to play video: $err");
      disposeVideo(lesson.id.toString());
      CustomSnackbar.showError(
          title: "Something wrong!",
          description: "Please check you internet connection!");
    } finally {
      isloading(false);
    }
  }

  bool get isPlay => currentlyPlayingLesson.value == null;
  bool isPlayingLesson(LessonModel lesson) =>
      currentlyPlayingLesson.value == lesson;

  double getPlayedDuration() {
    return durationRange.value.startFraction(durationRange.value.end);
  }

  void togglePlayPause(LessonModel lesson) {
    if (currentlyStartPlayLesson.value?.id == lesson.id) {
      disposeVideo(lesson.id.toString());
      currentlyPlayingLesson.value = null;
      currentlyStartPlayLesson.value = null;
    } else {
      disposeVideo(lesson.id.toString());
      currentlyPlayingLesson.value = null;
      currentlyStartPlayLesson.value = null;
      initializeVideo(lesson);
    }
    update();
  }

  void toggleFullScreen() {
    final chewieController =
        chewieControllers[currentlyPlayingLesson.value?.id.toString()]
            as ChewieController;
    chewieController.enterFullScreen();
  }

  void disposeVideo(String lessonId) {
    videoControllers.remove(lessonId)?.dispose();
    chewieControllers.remove(lessonId)?.dispose();
    update();
  }

  @override
  void onClose() {
    videoControllers.values.forEach((controller) => controller.dispose());
    chewieControllers.values.forEach((controller) => controller.dispose());
    super.onClose();
  }
}

class CustomVideoControls extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final VideoController videoController = Get.find<VideoController>();
  CustomVideoControls({super.key, required this.videoPlayerController});

  @override
  _CustomVideoControlsState createState() => _CustomVideoControlsState();
}

class _CustomVideoControlsState extends State<CustomVideoControls> {
  final RxBool _isShowController = true.obs;
  final RxBool _isPlaying = false.obs;
  final Rx<DurationRange> durationRange =
      DurationRange(Duration.zero, Duration.zero).obs;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();

    widget.videoPlayerController.addListener(() {
      _isPlaying.value = widget.videoPlayerController.value.isPlaying;
      widget.videoController.isPlaying(_isPlaying.value);
      durationRange(
        DurationRange(widget.videoPlayerController.value.position,
            widget.videoPlayerController.value.duration),
      );
      widget.videoController.durationRange.value = durationRange.value;
    });
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(seconds: 3), () {
      if (widget.videoPlayerController.value.isPlaying) {
        _isShowController.value = false;
      }
    });
  }

  void _toggleControls() {
    _isShowController.toggle();
    _isShowController.value ? _startHideTimer() : _hideTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            Container(
              color: _isShowController.value
                  ? ColorConstant.transparentGray
                  : Colors.transparent,
              child: _isShowController.value
                  ? AnimatedOpacity(
                      opacity: _isShowController.value ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: _isShowController.value &&
                                    !widget
                                        .videoPlayerController.value.isBuffering
                                ? IconButton(
                                    icon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        _isPlaying.value
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    onPressed: () {
                                      widget.videoPlayerController.value
                                              .isPlaying
                                          ? widget.videoPlayerController.pause()
                                          : widget.videoPlayerController.play();
                                      _isPlaying.value = widget
                                          .videoPlayerController
                                          .value
                                          .isPlaying;
                                    },
                                  )
                                : SizedBox(),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 50),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.fullscreen,
                                            color: Colors.white),
                                        onPressed: () {
                                          widget.videoController
                                              .toggleFullScreen();
                                        },
                                      ),
                                      VideoProgressIndicator(
                                        widget.videoPlayerController,
                                        allowScrubbing: true,
                                        colors: VideoProgressColors(
                                          playedColor: Colors.red,
                                          bufferedColor: Colors.grey,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${_formatDuration(durationRange.value.start)}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "${_formatDuration(durationRange.value.end)}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ))
                  : AnimatedOpacity(
                      opacity: _isShowController.value ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 600),
                      child: Stack(),
                    ),
            ),
            Center(
                child: widget.videoPlayerController.value.isBuffering
                    ? CircularProgressIndicator()
                    : null),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration? duration) {
    if (duration == null) return "--:--";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/color_constant.dart';
// import 'package:flutter_application_1/views/customs/custom_video_controls.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:get/get.dart';
// import 'package:flutter_application_1/model/lesson_model.dart';

// class VideoController extends GetxController {
//   final RxMap<String, VideoPlayerController> videoControllers =
//       <String, VideoPlayerController>{}.obs;
//   final RxMap<String, ChewieController> chewieControllers =
//       <String, ChewieController>{}.obs;
//   final Rx<LessonModel?> currentlyPlayingLesson = Rx<LessonModel?>(null);

//   void initializeVideo(LessonModel lesson) async {
//     print("video start");
//     disposeVideo(
//         lesson.id.toString()); // Dispose existing controllers for the lesson

//     var videoPlayerController =
//         // VideoPlayerController.networkUrl(Uri.parse(lesson.videoUrl));
//         VideoPlayerController.networkUrl(Uri.parse(
//             "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"));

//     try {
//       await videoPlayerController.initialize();
//       videoControllers[lesson.id.toString()] = videoPlayerController;
//       chewieControllers[lesson.id.toString()] = ChewieController(
//         videoPlayerController: videoPlayerController,
//         looping: false,
//         autoPlay: true,
//         customControls: CustomVideoControls(),
//       );

//       currentlyPlayingLesson.value = lesson;
//       update();
//     } catch (err) {
//       print("Fail to play video $err");
//     }
//   }

//   void togglePlayPause(LessonModel lesson) {
//     if (currentlyPlayingLesson.value?.id == lesson.id) {
//       disposeVideo(lesson.id.toString());
//       currentlyPlayingLesson.value = null;
//     } else {
//       initializeVideo(lesson);
//     }
//     update();
//   }

//   void disposeVideo(String lessonId) {
//     videoControllers[lessonId]?.dispose();
//     chewieControllers[lessonId]?.dispose();
//     videoControllers.remove(lessonId);
//     chewieControllers.remove(lessonId);
//     update();
//   }

//   @override
//   void onClose() {
//     videoControllers.forEach((key, controller) => controller.dispose());
//     chewieControllers.forEach((key, controller) => controller.dispose());
//     super.onClose();
//   }
// }

// class CustomVideoControls extends StatefulWidget {
//   @override
//   _CustomVideoControlsState createState() => _CustomVideoControlsState();
// }

// class _CustomVideoControlsState extends State<CustomVideoControls> {
//   late ChewieController _chewieController;
//   late VideoPlayerController _videoPlayerController;

//   final RxBool _isShowController = true.obs;
//   final RxBool _isPlaying = false.obs; // Reactive variable for play/pause state
//   final Rx<DurationRange> _durationRange =
//       DurationRange(Duration.zero, Duration.zero).obs;
//   Timer? _hideTimer;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _chewieController = ChewieController.of(context);
//     _videoPlayerController = _chewieController.videoPlayerController;

//     /// Listen to video player state and update `_isPlaying`
//     _videoPlayerController.addListener(() {
//       _isPlaying.value = _videoPlayerController.value.isPlaying;
//       _durationRange(DurationRange(_videoPlayerController.value.position,
//           _videoPlayerController.value.duration));
//       _startHideTimer();
//     });
//   }

//   /// Start a timer to auto-hide controls after 3 seconds
//   void _startHideTimer() {
//     _hideTimer?.cancel(); // Cancel existing timer
//     _hideTimer = Timer(Duration(seconds: 3), () {
//       if (_videoPlayerController.value.isPlaying) {
//         _isShowController.value = false;
//       }
//     });
//   }

//   /// Toggle controls manually when tapped
//   void _toggleControls() {
//     _isShowController.toggle();
//     if (_isShowController.value) {
//       _startHideTimer(); // Restart auto-hide timer when controls are shown
//     } else {
//       _hideTimer?.cancel(); // Stop auto-hide if manually hidden
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => GestureDetector(
//           onTap: () => _toggleControls(),
//           child: Container(
//             color: _isShowController.value
//                 ? ColorConstant.transparentGray
//                 : Colors.transparent,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Center(
//                   child: _isShowController.value
//                       ? Obx(() => IconButton(
//                             icon: Icon(
//                               _isPlaying.value ? Icons.pause : Icons.play_arrow,
//                               color: Colors.white,
//                             ),
//                             onPressed: () {
//                               if (_videoPlayerController.value.isPlaying) {
//                                 _videoPlayerController.pause();
//                               } else {
//                                 _videoPlayerController.play();
//                               }
//                               _isPlaying.value = _videoPlayerController
//                                   .value.isPlaying; // Ensure UI updates
//                             },
//                           ))
//                       : SizedBox(),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
//                   child: AnimatedOpacity(
//                     opacity: _isShowController.value ? 1.0 : 0.0,
//                     duration: Duration(milliseconds: 300),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.fullscreen, color: Colors.white),
//                           onPressed: () {
//                             _chewieController.enterFullScreen();
//                           },
//                         ),
//                         VideoProgressIndicator(
//                           _videoPlayerController,
//                           allowScrubbing: true,
//                           colors: VideoProgressColors(
//                             playedColor: Colors.red,
//                             bufferedColor: Colors.grey,
//                             backgroundColor: Colors.white,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "${_formatDuration(_durationRange.value.start)}",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             Text(
//                               "${_formatDuration(_durationRange.value.start)}",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   String _formatDuration(Duration? duration) {
//     if (duration == null) return "--:--";
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }
// }
