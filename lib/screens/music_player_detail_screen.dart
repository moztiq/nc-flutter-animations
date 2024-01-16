import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int page;

  const MusicPlayerDetailScreen({super.key, required this.page});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: const Duration(minutes: 1),
  )..repeat(
      reverse: true,
    );

  late final AnimationController _marqueeController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 20),
  )..repeat(reverse: true);

  late final Animation<Offset> _marqueeTween = Tween(
    begin: Offset(0.1, 0),
    end: Offset(-0.6, 0),
  ).animate(_marqueeController);

  late final AnimationController _playController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 300,
    ),
  );

  @override
  void dispose() {
    _playController.dispose();
    _marqueeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  String toTimeString(double value) {
    final duration = Duration(milliseconds: (value * 60000).toInt());
    final timeString =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return timeString;
  }

  void _onPlayPauseTap() {
    if (_playController.isCompleted) {
      _playController.reverse();
    } else {
      _playController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ready Player One'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: '${widget.page}',
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/covers/${widget.page}.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedBuilder(
            animation: _progressController,
            builder: (BuildContext context, Widget? child) {
              return Column(
                children: [
                  CustomPaint(
                    size: Size(size.width - 80, 5),
                    painter:
                        ProgressBar(progressValue: _progressController.value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Text(
                          toTimeString(_progressController.value),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          toTimeString(1 - _progressController.value),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ready Player One",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SlideTransition(
            position: _marqueeTween,
            child: const Text(
              "Ready Player One - Steven Spielberg, SONG FROM THE MOTION PICTURE",
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedIcon(
                  icon: AnimatedIcons.pause_play,
                  progress: _playController,
                  size: 50,
                ),
                // LottieBuilder.asset(
                //   "assets/animations/play-lottie.json",
                //   controller: _playController,
                //   onLoaded: (composition) {
                //     _playController.duration = composition.duration;
                //   },
                //   width: 200,
                //   height: 200,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({super.repaint, required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;

    // track
    final trackPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.fill;
    final trackRRect = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(10));
    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.fill;
    final progressRRect =
        RRect.fromLTRBR(0, 0, progress, size.height, const Radius.circular(5));
    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    canvas.drawCircle(Offset(progress, size.height / 2), 7, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
