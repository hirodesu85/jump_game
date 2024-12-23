import 'package:flutter/material.dart';
import 'package:jump_game/games/jump_game.dart';

class GameOverPage extends StatelessWidget {
  final JumpGame jumpGame;
  const GameOverPage({super.key, required this.jumpGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(child: Text("結果:${jumpGame.jumpCount}")), // 避けれた玉の数を表示
            // ボタンを押すとJumpGameのgameRestart(後述)を呼び出す
            ElevatedButton(
                onPressed: () => jumpGame.gameRestart(),
                child: const Text("Re Start")),
          ]),
    );
  }
}
