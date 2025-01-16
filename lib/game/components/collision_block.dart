import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({super.position, super.size});
  @override
  bool get debugMode => true;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }
}
