import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';

import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:the_crossing_puzzle/game/components/collision_block.dart';
import 'package:the_crossing_puzzle/game/components/corn.dart';
import 'package:the_crossing_puzzle/game/components/fox.dart';
import 'package:the_crossing_puzzle/game/components/goose.dart';
import 'package:the_crossing_puzzle/game/components/player.dart';
import 'package:the_crossing_puzzle/my_game.dart';

class Level extends World with HasGameRef<MyGame> {
  Level({required this.player});

  final Player player;
  late TiledComponent level;
  late Corn corn;
  late Goose goose;
  late Fox fox;
  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      'Level-01.tmx',
      Vector2.all(16),
      useAtlas: !kIsWeb,
      layerPaintFactory: (_) => _layerPaint(),
    );
    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoints');

    for (final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
        case 'Fox':
          final fox = Fox(position: Vector2(spawnPoint.x, spawnPoint.y));
          gameRef.fox = fox;
          add(fox);
        case 'Goose':
          final goose = Goose(position: Vector2(spawnPoint.x, spawnPoint.y));
          gameRef.goose = goose;
          add(goose);
        case 'Corn':
          final corn = Corn(position: Vector2(spawnPoint.x, spawnPoint.y));
          gameRef.corn = corn;
          add(corn);
        default:
          break;
      }
    }

    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }

    player.collisionBlocks = collisionBlocks;

    return super.onLoad();
  }

  Paint _layerPaint() {
    return Paint()
      ..isAntiAlias = false
      ..filterQuality = FilterQuality.none;
  }
}
