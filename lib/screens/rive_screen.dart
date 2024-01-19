import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController =
        StateMachineController.fromArtboard(artboard, "state", onStateChange: (
      String stateMachineName,
      String stateName,
    ) {
      print(stateMachineName);
      print(stateName);
    })!;
    artboard.addController(_stateMachineController);
  }

  void _togglePanel() {
    final input = _stateMachineController.findInput<bool>("panelActive")!;
    input.change(!input.value);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rive'),
      ),
      body: Center(
        child: Container(
          color: Color(0xFFFF2ECC),
          width: double.infinity,
          child: RiveAnimation.asset(
            'assets/animations/stars-animation.riv',
            artboard: "artboard",
            stateMachines: ["state"],
            onInit: _onInit,
          ),
        ),
      ),
    );
  }
}
