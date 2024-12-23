import 'package:flutter/material.dart';
import 'package:jump_game/games/jump_game.dart';

class StartPage extends StatelessWidget {
  final JumpGame jumpGame;
  const StartPage({super.key, required this.jumpGame});

  @override
  Widget build(BuildContext context) {
    // スタートボタンが押されたらJumpGameのgameStartメソッド(後述)を呼び出す
    return Center(
      child: ElevatedButton(
          onPressed: () => jumpGame.gameStart(), child: const Text("Start")),
    );
  }
}
