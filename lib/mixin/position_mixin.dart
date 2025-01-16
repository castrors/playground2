import 'package:flame/components.dart';

enum MapPosition { top, center, bottom }

mixin PositionToMapPosition on PositionComponent {
  bool get isOnTop => positionToMapPosition == MapPosition.top;

  bool get isOnCenter => positionToMapPosition == MapPosition.center;

  bool get isOnBottom => positionToMapPosition == MapPosition.bottom;

  MapPosition get positionToMapPosition {
    if (absolutePosition.y < 256) {
      return MapPosition.top;
    } else if (absolutePosition.y > 256 && absolutePosition.y <= 384) {
      return MapPosition.center;
    } else {
      return MapPosition.bottom;
    }
  }
}
