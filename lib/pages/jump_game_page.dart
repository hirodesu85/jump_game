import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/games/jump_game.dart';

class JumpGamePage extends StatelessWidget {
  JumpGamePage({super.key});

  // 今回作成したゲームを持つ
  final game = JumpGame();

  @override
  Widget build(BuildContext context) {
    // FlutterへFlameのGameWidgetを追加
    return GameWidget(game: game);
  }
}
