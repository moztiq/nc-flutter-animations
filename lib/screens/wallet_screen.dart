import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isExpanded = false;

  void _onExpanded() {
    setState(() {
      _isExpanded = true;
    });
  }

  void _onShrink(_) {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onVerticalDragEnd: _onShrink,
          onTap: _onExpanded,
          child: Column(
            children: [
              CreditCard(
                bgColor: Colors.purple,
                isExpanded: _isExpanded,
              )
                  .animate(delay: 1.5.seconds, target: _isExpanded ? 0 : 1)
                  .flipV(end: 0.1),
              CreditCard(
                bgColor: Colors.black,
                isExpanded: _isExpanded,
              )
                  .animate(delay: 1.5.seconds, target: _isExpanded ? 0 : 1)
                  .flipV(end: 0.1)
                  .slideY(end: -0.8),
              CreditCard(
                bgColor: Colors.blue,
                isExpanded: _isExpanded,
              )
                  .animate(delay: 1.5.seconds, target: _isExpanded ? 0 : 1)
                  .flipV(end: 0.1)
                  .slideY(end: -0.8 * 2),
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
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final Color bgColor;
  final bool isExpanded;

  const CreditCard({
    super.key,
    required this.bgColor,
    required this.isExpanded,
  });

  void _onTap() {
    print('tapped');
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !isExpanded,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
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
        ),
      ),
    );
  }
}
