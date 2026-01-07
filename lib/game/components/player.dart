import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  Vector2 velocity = Vector2(0, 0);
  final double gravity = 500;
  final double jumpSpeed = -300;
  bool onGround = false;
  int health = 3;
  bool isInvulnerable = false;
  final double invulnerabilityTime = 2.0; // Seconds
  double invulnerabilityTimer = 0;

  Player()
      : super(size: Vector2(50, 50), anchor: Anchor.center) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = await gameRef.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(50, 50),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.y += gravity * dt;
    position += velocity * dt;

    if (isInvulnerable) {
      invulnerabilityTimer -= dt;
      if (invulnerabilityTimer <= 0) {
        isInvulnerable = false;
      }
    }

    // Keep the player within the game bounds
    position.clamp(Vector2.zero() + size / 2, gameRef.size - size / 2);

    // Reset jump if on ground
    if (position.y >= gameRef.size.y - size.y / 2) {
      onGround = true;
      velocity.y = 0;
    } else {
      onGround = false;
    }
  }

  void jump() {
    if (onGround) {
      velocity.y = jumpSpeed;
      onGround = false;
    }
  }

  void takeDamage() {
    if (!isInvulnerable) {
      health -= 1;
      isInvulnerable = true;
      invulnerabilityTimer = invulnerabilityTime;
      if (health <= 0) {
        // Handle player death
        removeFromParent();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle) {
      takeDamage();
    } else if (other is Collectible) {
      // Handle collectible
      other.removeFromParent();
    }
  }
}

class Obstacle extends SpriteComponent with Hitbox, Collidable {
  Obstacle() : super(size: Vector2(50, 50)) {
    addHitbox(HitboxRectangle());
  }
}

class Collectible extends SpriteComponent with Hitbox, Collidable {
  Collectible() : super(size: Vector2(30, 30)) {
    addHitbox(HitboxRectangle());
  }
}