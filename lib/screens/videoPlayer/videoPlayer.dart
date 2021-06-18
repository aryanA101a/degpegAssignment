import 'package:assignment/screens/videoPlayer/custom_controls_widget.dart';
import 'package:assignment/firebaseFirestore/firebaseFunctions.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

class HlsAudioPage extends StatefulWidget {
  final int views;
  final int watchtime;
  final String videoUrl;
  final String videoId;
  HlsAudioPage(this.videoUrl, this.videoId, this.views, this.watchtime);
  @override
  _HlsAudioPageState createState() => _HlsAudioPageState();
}

class _HlsAudioPageState extends State<HlsAudioPage> {
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
      fullScreenByDefault: true,
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
      appBar: AppBar(
        title: Text("HLS Player"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: _betterPlayerController),
            ),
            //   SizedBox(
            //   height: 50,
            //   width: 70,
            //   child: Container(
            //     color: Colors.red,
            //     child: Padding(
            //       padding: const EdgeInsets.all(0),
            //       child: Text(
            //         'Live',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
