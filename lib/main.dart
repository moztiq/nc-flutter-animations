import 'package:flutter/material.dart';
import 'package:nc_flutter_animations/screens/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Masterclass',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}
