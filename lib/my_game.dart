import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flutter/material.dart';
import 'package:playground2/game/components/components.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  MyGame({
    required this.playMusic,
    required this.playSounds,
    required this.joystickEnabled,
  });

  final bool playMusic;
  final bool playSounds;
  final bool joystickEnabled;

  Player player = Player();
  late Fox fox;
  late Goose goose;
  late Corn corn;
  late Level level;
  static double gameWidth = 360;
  static double gameHeight = 640;
  bool isGameOver = false;
  bool componentsLoaded = false;

  double soundVolume = 1;

  late final CameraComponent cam;
  late final JoystickComponent joystick;
  late final HudButtonComponent actionButton;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.loadAllImages();
    level = Level(player: player);
    add(level);

    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: Paint()..color = Colors.blue),
      background: CircleComponent(
        radius: 40,
        paint: Paint()..color = Colors.blue.withOpacity(0.5),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);

    final textPaint = TextPaint(
      style: const TextStyle(
        color: Colors.black, // Change this to your desired color
        fontSize: 20,
      ),
    );

    cam = CameraComponent.withFixedResolution(
      world: level,
      width: gameWidth,
      height: gameHeight,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    add(cam..priority = -1);

    actionButton = HudButtonComponent(
      button: CircleComponent(
        radius: 35,
        children: [
          TextComponent(
            text: 'Drop',
            textRenderer: textPaint,
            anchor: Anchor.center,
            position: Vector2(35, 35),
          ),
        ],
      ),
      buttonDown: CircleComponent(
        radius: 35,
        paint: Paint()..color = Colors.blueGrey,
      ),
      margin: const EdgeInsets.only(
        right: 45,
        bottom: 45,
      ),
      onPressed: () {
        player.dropObject(0, -1);
      },
    );
    // add(actionButton);
  }
}
