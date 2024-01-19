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
      body: Center(
        child: const Text(
          'Hello!',
          style: TextStyle(
            fontSize: 66,
          ),
        )
            .animate()
            .fadeIn(
              begin: 0,
              duration: 5.seconds,
              curve: Curves.easeInOutCubic,
            )
            .scale(
              duration: 5.seconds,
              begin: Offset.zero,
              end: const Offset(1, 1),
              curve: Curves.easeInOutCubic,
            )
            .then(delay: 2.seconds)
            .slideX(
              begin: 0,
              end: -10,
              duration: 2.seconds,
            ),
      ),
    );
  }
}
