import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fps_jank_flash_widget/fps_jank_flash_widget.dart';

void main() {
  const frameBudget = Duration(milliseconds: 17); // 60 fps
  FPSJankFlash.frameBudget = frameBudget;

  runApp(FPSJankFlash.overlay(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FPS Jank Flash Widget Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final r = Random();

void sleep(int ms) {
  final start = DateTime.now();

  while (true) {
    final elapsed = DateTime.now().difference(start);
    if (elapsed.inMilliseconds >= ms) {
      break;
    }
  }
}

class _HomeState extends State<Home> {
  final controller = ScrollController()
    ..addListener(() {
      if (r.nextInt(100) < 10) {
        sleep(60);
      }
    });

  final list = List.generate(1000, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return ListTile(title: Text(item));
        },
      ),
    );
  }
}
