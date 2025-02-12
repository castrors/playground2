import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:playground2/game/components/components.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  MyGame({required this.playMusic, required this.playSounds});

  final bool playMusic;
  final bool playSounds;

  final player = Player();
  late Fox fox;
  late Goose goose;
  late Corn corn;
  late Level level;
  static double gameWidth = 360;
  static double gameHeight = 640;
  bool isGameOver = false;
  bool componentsLoaded = false;

  bool playingMusic = false;
  double soundVolume = 1;

  late final CameraComponent cam;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.loadAllImages();

    level = Level(player: player);
    add(level);

    cam = CameraComponent.withFixedResolution(
      world: level,
      width: gameWidth,
      height: gameHeight,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    add(cam..priority = -1);

    // if (!playingMusic && playMusic) {
    //   await FlameAudio.bgm.play('music.mp3', volume: soundVolume);
    //   playingMusic = true;
    // }
  }
}
