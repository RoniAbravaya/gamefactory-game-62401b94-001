import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component representing a collectible item in the game.
/// It includes collision detection, a score value, and an optional animation.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  /// The score value this collectible adds when collected.
  final int scoreValue;

  /// The path to the sound effect to play when this collectible is collected.
  final String collectionSoundPath;

  /// Indicates whether this collectible has been collected.
  bool _collected = false;

  /// Creates a new instance of a collectible item.
  ///
  /// [scoreValue] specifies the score value of the collectible.
  /// [collectionSoundPath] specifies the path to the sound effect to play upon collection.
  /// [sprite] is an optional parameter to set the sprite for this component.
  /// [size] is an optional parameter to set the size of this component.
  /// [position] is an optional parameter to set the position of this component.
  Collectible({
    required this.scoreValue,
    required this.collectionSoundPath,
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
  }) : super(sprite: sprite, size: size, position: position) {
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    try {
      await super.onLoad();
      // Optionally, load and set an animation for the collectible here.
    } catch (e) {
      // Handle loading error
      print('Error loading Collectible: $e');
    }
  }

  /// Handles the logic when this collectible is collected by the player.
  void collect() {
    if (!_collected) {
      _collected = true;
      FlameAudio.play(collectionSoundPath);
      removeFromParent();
      // Additional logic for updating the game state can be added here.
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Check if the colliding entity is the player and collect the item.
    // This requires a way to identify the player, e.g., checking the type of `other`.
    if (!_collected && other is Player) { // Assuming there's a Player class
      collect();
    }
  }
}