import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jump_game/components/ball_component.dart';
import 'package:jump_game/components/maid_component.dart';

class JumpGame extends FlameGame
    with TapCallbacks, KeyboardEvents, HasCollisionDetection {
  late MaidComponent _maid;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(ScreenHitbox());
    final maidSprite = await Sprite.load('icon.JPG');
    _maid = MaidComponent(
      position: Vector2(100, size.y * 0.8),
      size: Vector2.all(size.x * 0.1),
      sprite: maidSprite,
      basePos: size.y * 0.8,
    );
    add(_maid);
    // 5秒ごとに球を発射するようにTimerComponentを追加
    add(TimerComponent(
        period: 3, // 間隔を指定
        repeat: true, // 繰り返し実行のフラグ
        onTick: () {
          add(BallComponent(
              position: Vector2(size.x - 30, size.y * 0.8))); // 5秒ごとに球をゲームに追加
        }));
  }

  // キーイベントを取るコールバック
  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // スペースキーを押されたらキャラクターがジャンプ
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _maid.jump();
    }
    return KeyEventResult.ignored;
  }

  // タップされたイベントを取るコールバック
  @override
  void onTapDown(TapDownEvent event) {
    // クリックでもキャラクターがジャンプ
    super.onTapDown(event);
    _maid.jump();
  }
}
