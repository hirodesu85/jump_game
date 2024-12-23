import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/pages/jump_game_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // web以外の場合は横向きの画面にする
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jump Games",
      home: JumpGamePage(),
    );
  }
}
