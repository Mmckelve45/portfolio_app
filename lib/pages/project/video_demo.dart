import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) => setState(() {
            videoLength = _controller.value.duration;
          }));
    _controller.play();
    //   _controller = VideoPlayerController.asset(
    //   'assets/videos/budgetTrackerWithMS.mp4')
    // ..addListener(() => setState(() {
    //       videoPosition = _controller.value.position;
    //     }))
    // ..initialize().then((_) => setState(() {
    //       videoLength = _controller.value.duration;
    //     }));
  }

  late Duration videoLength;
  late Duration videoPosition;
  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        // appBar: AppBar(leading: BackButton()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              children: <Widget>[
                if (_controller.value.isInitialized) ...[
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.all(10),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(_controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                      ),
                      Text(
                          '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}'),
                      SizedBox(width: 10),
                      Icon(animatedVolumeIcon(volume)),
                      Slider(
                        value: volume,
                        min: 0,
                        max: 1,
                        onChanged: (_volume) => setState(() {
                          volume = _volume;
                          _controller.setVolume(_volume);
                        }),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.loop,
                            color: _controller.value.isLooping
                                ? Colors.green
                                : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller
                                  .setLooping(!_controller.value.isLooping);
                            });
                          }),
                    ],
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}
