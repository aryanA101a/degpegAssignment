import 'package:assignment/screens/videoPlayer/custom_controls_widget.dart';
import 'package:assignment/firebaseFirestore/firebaseFunctions.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerPage extends StatefulWidget {
  final int views;
  final int watchtime;
  final String videoUrl;
  final String videoId;
  final String title;
  final String description;
  VideoPlayerPage(
      {required this.videoUrl,
      required this.videoId,
      required this.views,
      required this.watchtime,
      required this.description,
      required this.title});
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  BetterPlayerTheme _playerTheme = BetterPlayerTheme.material;
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  @override
  void initState() {
    firebaseFunctions.increaseViewCount(widget.videoId);
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.custom,

          // controlBarColor: Colors.red,
          customControlsBuilder: (controller) => CustomControlsWidget(
                widget.views,
                widget.watchtime,
                controller: controller,
              )),
      // fullScreenByDefault: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('0000000000000000000000x000000000000000000000x000000000000000000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _betterPlayerController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.share_rounded),
                ),
              ],
            ),
            Divider(
              height: 0,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )),
            Divider(
              height: 0,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Comments',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                )),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    'Empty...',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
