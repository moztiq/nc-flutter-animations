import 'dart:async';

import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
  );

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(milliseconds: 500),
      (timer) {
        print(_animationController.value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_animationController.value}',
              style: TextStyle(fontSize: 58),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _play,
                  child: Text('Play'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pause,
                  child: Text('Pause'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _rewind,
                  child: Text('Rewind'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
