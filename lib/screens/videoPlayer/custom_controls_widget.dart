import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class CustomControlsWidget extends StatefulWidget {
  final int views;
  final int watchtime;
  final BetterPlayerController? controller;

  const CustomControlsWidget(this.views, this.watchtime,
      {Key? key, this.controller})
      : super(key: key);

  @override
  _CustomControlsWidgetState createState() => _CustomControlsWidgetState();
}

class _CustomControlsWidgetState extends State<CustomControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        widget.controller!.isFullScreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  onTap: () => setState(() {
                    if (widget.controller!.isFullScreen)
                      widget.controller!.exitFullScreen();
                    else
                      widget.controller!.enterFullScreen();
                  }),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${widget.views} views',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.black.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: Text(
              //       'watchtime: ${widget.watchtime}',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //           fontSize: 18),
              //     ),
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          Duration? videoDuration = await widget
                              .controller!.videoPlayerController!.position;
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              Duration rewindDuration = Duration(
                                  seconds: (videoDuration!.inSeconds - 2));
                              if (rewindDuration <
                                  widget.controller!.videoPlayerController!
                                      .value.duration!) {
                                widget.controller!.seekTo(Duration(seconds: 0));
                              } else {
                                widget.controller!.seekTo(rewindDuration);
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.controller!.isPlaying()!)
                              widget.controller!.pause();
                            else
                              widget.controller!.play();
                          });
                        },
                        child: Icon(
                          widget.controller!.isPlaying()!
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Duration? videoDuration = await widget
                              .controller!.videoPlayerController!.position;
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              Duration forwardDuration = Duration(
                                  seconds: (videoDuration!.inSeconds + 2));
                              if (forwardDuration >
                                  widget.controller!.videoPlayerController!
                                      .value.duration!) {
                                widget.controller!.seekTo(Duration(seconds: 0));
                                widget.controller!.pause();
                              } else {
                                widget.controller!.seekTo(forwardDuration);
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                        ),
                      ),
                      Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'LIVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
