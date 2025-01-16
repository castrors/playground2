import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:playground2/mixin/position_mixin.dart';
import 'package:playground2/my_game.dart';

class Corn extends PositionComponent
    with HasGameReference<MyGame>, PositionToMapPosition {
  Corn({super.position}) : super(size: Vector2(16, 16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.yellow);
  }
}
