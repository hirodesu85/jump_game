import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:jump_game/components/maid_component.dart';

class BallComponent extends CircleComponent with CollisionCallbacks {
  // 当たり判定を取るCollisionCallbacks をmixin
  BallComponent({super.position}) : super(radius: 10);
  final double ballSpeed = 10.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(CircleHitbox()..debugMode = true);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 右から左へ移動する
    position.x -= ballSpeed;
  }

  // 玉が何かにあたった時に呼ばれるコールバック
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // 壁に当たった場合の処理
    if (other is ScreenHitbox) {
      removeFromParent(); // 自身をゲームから削除する
      print("ball hit wall");
    }

    //メイドちゃんに当たった場合
    if (other is MaidComponent) {
      removeFromParent(); // 自身をゲームから削除する
      print("ball hit maid");
    }
  }
}
