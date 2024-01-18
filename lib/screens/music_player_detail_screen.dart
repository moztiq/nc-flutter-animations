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

  late final AnimationController _playController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 300,
    ),
  );

  late final AnimationController _menuController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  );

  late final Animation<Offset> _marqueeTween = Tween(
    begin: Offset(0.1, 0),
    end: Offset(-0.6, 0),
  ).animate(_marqueeController);

  @override
  void dispose() {
    _menuController.dispose();
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

  bool _dragging = false;

  void _toggleDragging() {
    setState(() {
      _dragging = !_dragging;
    });
  }

  late final size = MediaQuery.of(context).size;

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;
    _volume.value = _volume.value.clamp(0.0, size.width - 80);
  }

  ValueNotifier<double> _volume = ValueNotifier(0);

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  List<Map<String, dynamic>> _menus = [
    {"icon": Icons.person, "text": "Profile"},
    {"icon": Icons.notifications, "text": "Notifications"},
    {"icon": Icons.settings, "text": "Settings"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: _closeMenu,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                for (var menu in _menus) ...[
                  Row(
                    children: [
                      Icon(
                        menu['icon'],
                        color: Colors.grey.shade200,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        menu['text'],
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20)
                ],
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Ready Player One'),
            actions: [IconButton(onPressed: _openMenu, icon: Icon(Icons.menu))],
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
                        painter: ProgressBar(
                            progressValue: _progressController.value),
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
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onHorizontalDragUpdate: _onVolumeDragUpdate,
                onHorizontalDragStart: (_) => _toggleDragging(),
                onHorizontalDragEnd: (_) => _toggleDragging(),
                child: AnimatedScale(
                  duration: Duration(milliseconds: 300),
                  scale: _dragging ? 1.1 : 1,
                  curve: Curves.bounceOut,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _volume,
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return CustomPaint(
                          size: Size(size.width - 80, 50),
                          painter: VolumePaint(volume: value),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

class VolumePaint extends CustomPainter {
  final double volume;

  VolumePaint({super.repaint, required this.volume});

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade300;
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;
    final volumeRect = Rect.fromLTWH(0, 0, volume, size.height);
    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePaint oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
