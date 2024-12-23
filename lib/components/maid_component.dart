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
  bool isGameOver = false; // ゲームオーバーのフラグ
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

  // ゲームスタート、リスタート時に呼ばれる
  // 画像、フラグのリセット
  void gameStart() async {
    final maidSprite = await Sprite.load('icon.JPG');
    sprite = maidSprite;
    isGameOver = false;
  }

  // ゲームオーバー
  // 画像の差し替え、フラグの変更
  void gameOver() async {
    positionReset();
    final endSprite = await Sprite.load('dokuro.png');
    sprite = endSprite;
    isGameOver = true;
  }
}
