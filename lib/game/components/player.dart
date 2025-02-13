// ignore_for_file: strict_raw_type, avoid_redundant_argument_values

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:playground2/game/components/components.dart';
import 'package:playground2/mixin/position_mixin.dart';
import 'package:playground2/my_game.dart';

enum Direction {
  left,
  right,
  up,
  down,
}

enum PlayerState {
  idleSide,
  idleDown,
  idleUp,
  walkingSide,
  walkingDown,
  walkingUp,
}

class Player extends SpriteAnimationGroupComponent
    with
        HasGameReference<MyGame>,
        KeyboardHandler,
        CollisionCallbacks,
        PositionToMapPosition {
  Player({super.position})
      : super(size: Vector2(32, 32), anchor: Anchor.center);

  final double stepTime = 0.15;

  int horizontalDirectionFromKeyboard = 0;
  int verticalDirectionFromKeyboard = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  bool hasSpacePressed = false;
  PositionComponent? holdableComponent;
  List<CollisionBlock> collisionBlocks = [];
  bool isDialogVisible = false;
  Direction currentDirection = Direction.down;
  bool isMovingWithJoystick = true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadAllAnimations();
    add(RectangleHitbox());
  }

  void updateDirection() {
    if (velocity.x > 0) {
      currentDirection = Direction.right;
      if (isFlippedHorizontally) {
        flipHorizontally();
      }
    } else if (velocity.x < 0) {
      currentDirection = Direction.left;
      if (!isFlippedHorizontally) {
        flipHorizontally();
      }
    } else if (velocity.y > 0) {
      currentDirection = Direction.down;
    } else if (velocity.y < 0) {
      currentDirection = Direction.up;
    }
  }

  @override
  void update(double dt) {
    var horizontalDirection = 0;
    var verticalDirection = 0;

    if (!game.joystick.delta.isZero()) {
      if (game.joystick.isDragged) {
        horizontalDirection = game.joystick.relativeDelta.x.round();
        verticalDirection = game.joystick.relativeDelta.y.round();
      } else {
        horizontalDirection = 0;
        verticalDirection = 0;
      }
      if (!isMovingWithJoystick) {
        isMovingWithJoystick = true;
        changeJoystickOpacity(0.8, 0.5);
      }
    } else {
      horizontalDirection = horizontalDirectionFromKeyboard;
      verticalDirection = verticalDirectionFromKeyboard;
    }

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

    updateDirection();

    current = directionToAnimation(velocity: velocity);

    try {
      if (isGooseAloneWithCorn()) {
        game.paused = true;
        if (game.playSounds) {
          FlameAudio.play('lose.wav', volume: game.soundVolume);
        }
        if (game.buildContext != null) {
          final context = game.buildContext!;
          showLoseDialog(context, message: 'Goose is alone with Corn');
        }
      }
      if (isFoxAloneWithGoose()) {
        game.paused = true;
        if (game.playSounds) {
          FlameAudio.play('lose.wav', volume: game.soundVolume);
        }
        if (game.buildContext != null) {
          final context = game.buildContext!;
          showLoseDialog(context, message: 'Fox is alone with Goose');
        }
      }

      if (isCornGooseFoxOnTop()) {
        game.paused = true;
        if (game.playSounds) {
          FlameAudio.play('win.wav', volume: game.soundVolume);
        }
        if (game.buildContext != null) {
          final context = game.buildContext!;
          GoRouter.of(context).go('/win');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    super.update(dt);
  }

  void _loadAllAnimations() {
    final idleSpriteSheet = SpriteSheet(
      image: game.images.fromCache('main_character/idle.png'),
      srcSize: Vector2(13, 14),
    );

    final walkSpriteSheet = SpriteSheet(
      image: game.images.fromCache('main_character/walk.png'),
      srcSize: Vector2(13, 14),
    );

    final idleAnimationSide = idleSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 0,
      to: 4,
    );

    final idleAnimationDown = idleSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 4,
      to: 8,
    );

    final idleAnimationUp = idleSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 8,
      to: 12,
    );

    final walkAnimationSide = walkSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 0,
      to: 8,
    );

    final walkAnimationDown = walkSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 8,
      to: 16,
    );

    final walkAnimationUp = walkSpriteSheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      from: 16,
      to: 24,
    );

    animations = {
      PlayerState.idleSide: idleAnimationSide,
      PlayerState.idleDown: idleAnimationDown,
      PlayerState.idleUp: idleAnimationUp,
      PlayerState.walkingSide: walkAnimationSide,
      PlayerState.walkingDown: walkAnimationDown,
      PlayerState.walkingUp: walkAnimationUp,
    };
  }

  PlayerState directionToAnimation({required Vector2 velocity}) {
    if (velocity.x == 0 && velocity.y == 0) {
      switch (currentDirection) {
        case Direction.left:
          return PlayerState.idleSide;
        case Direction.right:
          return PlayerState.idleSide;
        case Direction.up:
          return PlayerState.idleUp;
        case Direction.down:
          return PlayerState.idleDown;
      }
    } else {
      switch (currentDirection) {
        case Direction.left:
          return PlayerState.walkingSide;
        case Direction.right:
          return PlayerState.walkingSide;
        case Direction.up:
          return PlayerState.walkingUp;
        case Direction.down:
          return PlayerState.walkingDown;
      }
    }
  }

  void showLoseDialog(BuildContext context, {required String message}) {
    if (isDialogVisible) return;
    isDialogVisible = true;
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('You Lose'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                GoRouter.of(context).push('/play');
              },
              child: const Text('Try again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                GoRouter.of(context).go('/');
              },
              child: const Text('Quit'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (isMovingWithJoystick) {
      isMovingWithJoystick = false;
      changeJoystickOpacity(0.3, 0.2);
    }
    horizontalDirectionFromKeyboard = 0;
    horizontalDirectionFromKeyboard +=
        (keysPressed.contains(LogicalKeyboardKey.keyA) ||
                keysPressed.contains(LogicalKeyboardKey.arrowLeft))
            ? -1
            : 0;
    horizontalDirectionFromKeyboard +=
        (keysPressed.contains(LogicalKeyboardKey.keyD) ||
                keysPressed.contains(LogicalKeyboardKey.arrowRight))
            ? 1
            : 0;

    verticalDirectionFromKeyboard = 0;
    verticalDirectionFromKeyboard +=
        (keysPressed.contains(LogicalKeyboardKey.keyW) ||
                keysPressed.contains(LogicalKeyboardKey.arrowUp))
            ? -1
            : 0;
    verticalDirectionFromKeyboard +=
        (keysPressed.contains(LogicalKeyboardKey.keyS) ||
                keysPressed.contains(LogicalKeyboardKey.arrowDown))
            ? 1
            : 0;

    hasSpacePressed = keysPressed.contains(LogicalKeyboardKey.space);

    if (hasSpacePressed) {
      if (holdableComponent != null) {
        dropObject(
          horizontalDirectionFromKeyboard,
          verticalDirectionFromKeyboard,
        );
      }
    }

    return false;
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
    game.add(game.actionButton);

    this.holdableComponent = holdableComponent;
    if (game.playSounds) {
      FlameAudio.play('collect.wav', volume: game.soundVolume);
    }
    holdableComponent.position = Vector2(
      size.x / 2,
      size.y / 2,
    );
    add(holdableComponent);
  }

  void dropObject(int horizontalDirection, int verticalDirection) {
    if (holdableComponent != null) {
      game.remove(game.actionButton);

      if (game.playSounds) {
        FlameAudio.play('drop.wav', volume: game.soundVolume);
      }
      if (horizontalDirection == 0 && verticalDirection == 0) {
        holdableComponent!.position = position + Vector2(0, 32);
      } else {
        holdableComponent!.position = position +
            Vector2(horizontalDirection * -32, verticalDirection * -32);
      }

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

  bool isCornGooseFoxOnTop() {
    return game.goose.isOnTop && game.fox.isOnTop && game.corn.isOnTop;
  }

  void changeJoystickOpacity(double knobOpacity, double backgroundOpacity) {
    final knob = game.joystick.knob as CircleComponent?;
    final background = game.joystick.background as CircleComponent?;

    if (knob != null && background != null) {
      knob.paint.color = knob.paint.color.withOpacity(knobOpacity);
      background.paint.color =
          background.paint.color.withOpacity(backgroundOpacity);
    }
  }
}
