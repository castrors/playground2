import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:the_crossing_puzzle/mixin/position_mixin.dart';
import 'package:the_crossing_puzzle/my_game.dart';

class Fox extends SpriteComponent
    with HasGameReference<MyGame>, PositionToMapPosition {
  Fox({super.position}) : super(size: Vector2(16, 16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final foxImage = game.images.fromCache('fox.png');
    sprite = Sprite(foxImage);
    add(RectangleHitbox());
    await super.onLoad();
  }
}
