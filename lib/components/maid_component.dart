import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:jump_game/components/ball_component.dart';

class MaidComponent extends SpriteComponent with CollisionCallbacks {
  bool isJump = false; // ジャンプ動作のフラグ
  bool isJumpUp = false; // ジャンプ方向のフラグ
  final double maxJump = 450.0; // ジャンプの最大高さ
  final double jumpSpeed = 10.0; // ジャンプの速度
  final double basePos; // ジャンプ開始・終了の高さ
  MaidComponent(
      {super.position, super.size, super.sprite, required this.basePos})
      : super(anchor: Anchor.center, paint: BasicPalette.gray.paint());

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(RectangleHitbox()..debugMode = true);
  }

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

  //当たり判定のコールバック
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // 玉に当たったらゲームオーバに
    if (other is BallComponent) {
      print("maid hit ball");
      gameOver();
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

  // ゲームオーバー処理
  void gameOver() async {
    final endSprite = await Sprite.load('dokuro.png');
    sprite = endSprite;
  }
}
