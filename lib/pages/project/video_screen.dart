import 'package:chewie/chewie.dart';
// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web_video_player/flutter_web_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}



//WATCH
//https://www.youtube.com/watch?v=XP-4BiWsuaQ&t=966s

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  // late ChewieController chewieController;
  // late Chewie playerWidget;
  //  = ChewieController(
  //   videoPlayerController: _controller,
  //   autoPlay: true,
  //   looping: true
  // );

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://media.oregonstate.edu/media/t/1_lv041j8i');
    _controller =
        // VideoPlayerController.asset("assets/videos/budgetTrackerWithMS.mkv");
        // need to make this a MP4 file
        VideoPlayerController.asset(
            // "C:/Users/Matthew McKelvey/Documents/flutterProjects/portfolioApp/portfolio_app/assets/videos/budgetTrackerWithMS.mkv");
            "assets/videos/budgetTrackerWithMS.mp4")..initialize().then((_){
              setState(() {});
            });
    // _initializeVideoPlayerFuture = _controller.initialize();
    // chewieController = ChewieController(
    //     videoPlayerController: _controller,
    //     autoPlay: true,
    //     looping: true,
    //     autoInitialize: true,
    //     errorBuilder: (context, errormsg) {
    //       return Center(
    //         child: Text(
    //           errormsg,
    //           style: TextStyle(color: Colors.white),
    //         ),
    //       );
    //     });
    // playerWidget = Chewie(controller: chewieController);
    _controller.setLooping(true);
    _controller.setVolume(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // chewieController.dispose();
    
  }

  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Video Demo")),
        body: SingleChildScrollView(
          child:
              // FutureBuilder(
              //     future: _initializeVideoPlayerFuture,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              // return
              Column(children: [
                // WebVideoPlayer(src: "assets/videos/budgetTrackerWithMS.mp4"),
              if(_controller.value.isInitialized) 
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                  // child: Chewie(controller: chewieController),
                  // ),
                  ),
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  padding: EdgeInsets.all(10),
                  // colors: const VideoProgressColors(
                  // backgroundColor: Colors.red,
                  // bufferedColor: Colors.grey,
                  // playedColor: Colors.blueAccent),
              ),
              
              // LinearProgressIndicator(
              //   value: _controller.value.position.inSeconds / _controller.value.duration.inSeconds,
              // )
              
              // Row(children: [
              //   IconButton(
              //       onPressed: () async {
              //         Duration currentPos = _controller.value.position;
              //         Duration targetPos =
              //             currentPos - const Duration(seconds: 5);
              //         await _controller.seekTo(targetPos);
              //         setState(() {});
              //       },
              //       icon: Icon(Icons.fast_rewind)),
              //   IconButton(
              //       onPressed: () async {
              //         var currPosition = await _controller.position;
              //         var newPosition =
              //             await currPosition! + Duration(seconds: 10);
              //         // Duration currentPos = _controller.value.position;
              //         // Duration targetPos =
              //         //     currentPos + const Duration(seconds: 5);
              //         await _controller.seekTo(newPosition);
              //         setState(() async {
              //           await _controller.seekTo(newPosition);
              //         });
              //       },
              //       icon: Icon(Icons.fast_forward)),
              // ])
            ],
            //     );
            //   } else {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   }
            // }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
        )
        );
  }
}
