import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class MaidComponent extends SpriteComponent {
  bool isJump = false; // ジャンプ動作のフラグ
  bool isJumpUp = false; // ジャンプ方向のフラグ
  final double maxJump = 450.0; // ジャンプの最大高さ
  final double jumpSpeed = 5.0; // ジャンプの速度
  final double basePos; // ジャンプ開始・終了の高さ
  MaidComponent(
      {super.position, super.size, super.sprite, required this.basePos})
      : super(anchor: Anchor.center, paint: BasicPalette.gray.paint());

  // フレームごとに呼ばれるメソッド
  @override
  void update(double dt) {
    super.update(dt);
    // ジャンプの動作を実装
    // 最高到達点へ行ったら下に落ちる
    if (isJump) {
      if (isJumpUp) {
        position.y -= jumpSpeed;
        if (position.y <= maxJump) {
          isJumpUp = false;
        }
      } else {
        position.y += jumpSpeed;
        if (position.y >= basePos) {
          positionReset();
          isJump = false;
        }
      }
    }
  }

  // ジャンプした際に呼ばれる
  void jump() {
    isJump = true;
    isJumpUp = true;
  }

  // キャラクター位置をリセット
  void positionReset() {
    position.y = basePos;
  }
}
