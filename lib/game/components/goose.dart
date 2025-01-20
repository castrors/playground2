import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:playground2/mixin/position_mixin.dart';
import 'package:playground2/my_game.dart';

class Goose extends SpriteComponent
    with HasGameReference<MyGame>, PositionToMapPosition {
  Goose({super.position}) : super(size: Vector2(16, 16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final gooseImage = game.images.fromCache('goose.png');
    sprite = Sprite(gooseImage);
    add(RectangleHitbox());
    await super.onLoad();
  }
}
