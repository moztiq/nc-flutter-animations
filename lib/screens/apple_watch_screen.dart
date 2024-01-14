import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  )..forward();
  late final _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );
  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: 1.5,
  ).animate(_curve);

  void _animateValues() {
    final newBegin = _progress.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    setState(() {
      _progress = Tween(begin: newBegin, end: newEnd).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Apple Watch'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _curve,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: AppleWatchPainter(progress: _progress.value),
              size: Size(400, 400),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const startingAngle = -0.5 * pi;

    // draw red
    final redCircle = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final redCircleRadius = size.width / 2 * 0.9;
    canvas.drawCircle(center, redCircleRadius, redCircle);

    // draw green
    final greenCircle = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final greenCircleRadius = size.width / 2 * 0.76;
    canvas.drawCircle(center, greenCircleRadius, greenCircle);

    // draw blue
    final blueCircle = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final blueCircleRadius = size.width / 2 * 0.62;
    canvas.drawCircle(center, blueCircleRadius, blueCircle);

    // draw red arc
    final redArc = Rect.fromCircle(center: center, radius: redCircleRadius);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(redArc, startingAngle, progress * pi, false, redArcPaint);

    // draw green arc
    final greenArc = Rect.fromCircle(center: center, radius: greenCircleRadius);
    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
        greenArc, startingAngle, progress * pi, false, greenArcPaint);

    // draw blue arc
    final blueArc = Rect.fromCircle(center: center, radius: blueCircleRadius);
    final blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(blueArc, startingAngle, progress * pi, false, blueArcPaint);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
