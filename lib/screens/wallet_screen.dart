import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // children: AnimateList(
          //   interval: 500.milliseconds,
          //   effects: [
          //     SlideEffect(
          //       duration: 1000.milliseconds,
          //       begin: const Offset(-1, 0),
          //       end: Offset.zero,
          //       curve: Curves.easeInOutCubic,
          //     ),
          //     const FadeEffect(
          //       begin: 0,
          //       end: 1,
          //     )
          //   ],
          //   children: [
          //     const CreditCard(bgColor: Colors.purple),
          //     const CreditCard(bgColor: Colors.black),
          //     const CreditCard(bgColor: Colors.blue),
          //   ],
          // ),
          children: [
            const CreditCard(bgColor: Colors.purple),
            const CreditCard(bgColor: Colors.black),
            const CreditCard(bgColor: Colors.blue),
          ]
              .animate(interval: 500.milliseconds)
              .slideX(
                duration: 500.milliseconds,
                begin: -1,
                end: 0,
                curve: Curves.easeInOutCubic,
              )
              .fadeIn(
                begin: 0,
              ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color bgColor;

  const CreditCard({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEONGKI KIM',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '**** **** **75',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
