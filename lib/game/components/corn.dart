import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:the_crossing_puzzle/mixin/position_mixin.dart';
import 'package:the_crossing_puzzle/my_game.dart';

class Corn extends SpriteComponent
    with HasGameReference<MyGame>, PositionToMapPosition {
  Corn({super.position}) : super(size: Vector2(16, 16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final cornImage = game.images.fromCache('corn.png');
    sprite = Sprite(cornImage);
    add(RectangleHitbox());
    await super.onLoad();
  }
}
