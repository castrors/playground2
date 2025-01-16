import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playground2/game/components/components.dart';
import 'package:playground2/mixin/position_mixin.dart';
import 'package:playground2/my_game.dart';

class Player extends PositionComponent
    with
        HasGameReference<MyGame>,
        KeyboardHandler,
        CollisionCallbacks,
        PositionToMapPosition {
  Player({super.position})
      : super(size: Vector2(32, 32), anchor: Anchor.center);

  int horizontalDirection = 0;
  int verticalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  bool hasSpacePressed = false;
  PositionComponent? holdableComponent;
  List<CollisionBlock> collisionBlocks = [];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = true;
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.brown);
  }

  @override
  void update(double dt) {
    print(positionToMapPosition);

    velocity
      ..x = horizontalDirection * moveSpeed
      ..y = verticalDirection * moveSpeed;

    if (position.x - 16 <= 0) {
      velocity.x = 1 * moveSpeed;
    }
    if (position.x + 16 >= 360) {
      velocity.x = -1 * moveSpeed;
    }
    if (position.y - 16 <= 0) {
      velocity.y = 1 * moveSpeed;
    }
    if (position.y + 16 >= 640) {
      velocity.y = -1 * moveSpeed;
    }

    position += velocity * dt;

    try {
      if (isGooseAloneWithCorn()) {
        print('Game Over - Goose is alone with Corn');
      }
      if (isFoxAloneWithGoose()) {
        print('Game Over - Fox is alone with Goose');
      }
    } catch (e) {
      print('not assigned yet');
    }

    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    verticalDirection = 0;
    verticalDirection += (keysPressed.contains(LogicalKeyboardKey.keyW) ||
            keysPressed.contains(LogicalKeyboardKey.arrowUp))
        ? -1
        : 0;
    verticalDirection += (keysPressed.contains(LogicalKeyboardKey.keyS) ||
            keysPressed.contains(LogicalKeyboardKey.arrowDown))
        ? 1
        : 0;

    hasSpacePressed = keysPressed.contains(LogicalKeyboardKey.space);

    if (hasSpacePressed) {
      if (holdableComponent != null) {
        dropObject();
      }
    }

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {
      // Calculate the collision normal and separation distance.
      final mid =
          (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) /
              2;

      final collisionNormal = absoluteCenter - mid;
      final separationDistance = (size.x / 2) - collisionNormal.length;
      collisionNormal.normalize();

      // Resolve collision by moving ember along
      // collision normal by separation distance.
      position += collisionNormal.scaled(separationDistance);
    }
    if (holdableComponent == null &&
        (other is Fox || other is Goose || other is Corn)) {
      pickUpObject(other);
    }

    super.onCollision(intersectionPoints, other);
  }

  void pickUpObject(PositionComponent holdableComponent) {
    this.holdableComponent = holdableComponent;
    holdableComponent.position = Vector2(
      size.x / 2,
      size.y / 2,
    );
    add(holdableComponent);
  }

  void dropObject() {
    if (holdableComponent != null) {
      // holdableComponent!.removeFromParent();
      holdableComponent!.position = position + Vector2(0, 32);
      game.level.add(holdableComponent!);

      holdableComponent = null;
    }
  }

  bool isGooseAloneWithCorn() {
    return (game.goose.isOnTop &&
            game.corn.isOnTop &&
            game.fox.isOnBottom &&
            isOnBottom) ||
        (game.goose.isOnBottom &&
            game.corn.isOnBottom &&
            game.fox.isOnTop &&
            isOnTop);
  }

  bool isFoxAloneWithGoose() {
    return (game.goose.isOnTop &&
            game.fox.isOnTop &&
            game.corn.isOnBottom &&
            isOnBottom) ||
        (game.goose.isOnBottom &&
            game.fox.isOnBottom &&
            game.corn.isOnTop &&
            isOnTop);
  }
}
