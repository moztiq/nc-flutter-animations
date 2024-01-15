import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenmState();
}

class _MusicPlayerScreenmState extends State<MusicPlayerScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/covers/${index + 1}.jpeg'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    'Ready Player One',
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Alan Silvestri',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
