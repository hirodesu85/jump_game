import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/games/jump_game.dart';
import 'package:jump_game/pages/game_over_page.dart';
import 'package:jump_game/pages/start_page.dart';

class JumpGamePage extends StatelessWidget {
  JumpGamePage({super.key});

  // 今回作成したゲームを持つ
  final game = JumpGame();

  @override
  Widget build(BuildContext context) {
    // FlutterへFlameのGameWidgetを追加
    return GameWidget(
      // FlutterのUI(Widget)を追加する
      overlayBuilderMap: {
        // スタート画面のWidget
        "start": (context, JumpGame jumpGame) => StartPage(
              jumpGame: jumpGame,
            ),
        // ゲームオーバー画面のWidget
        "gameOver": (context, JumpGame jumpGame) =>
            GameOverPage(jumpGame: jumpGame)
      },
      // ゲーム自体はJumpGameを設定
      game: game,
      initialActiveOverlays: const ['start'], // 起動時はスタート画面を設定
    );
  }
}
