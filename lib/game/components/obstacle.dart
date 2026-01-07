import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// A component representing an obstacle in a platformer game.
/// It includes a visual representation, collision detection,
/// and can deal damage to the player on contact.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 _size;
  final String _spritePath;
  late SpriteComponent _spriteComponent;

  /// Creates an instance of an obstacle.
  /// [size] specifies the size of the obstacle.
  /// [spritePath] specifies the path to the sprite image.
  Obstacle(this._size, this._spritePath) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = _size;
    _spriteComponent = SpriteComponent.fromImage(
      await gameRef.images.load(_spritePath),
      size: size,
    );
    add(_spriteComponent);
  }

  /// Handles the logic when a collision is detected.
  /// In this context, it could deal damage or trigger a fail state.
  void onCollision() {
    // Implement damage dealing or game over logic here
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Implement any movement or spawning behavior here
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    onCollision();
  }
}