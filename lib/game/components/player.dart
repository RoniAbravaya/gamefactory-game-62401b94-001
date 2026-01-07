import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable {
  Vector2 velocity = Vector2.zero();
  final double gravity = 500;
  final double jumpSpeed = -300;
  bool onGround = false;
  int lives = 3;
  int score = 0;

  Player() : super(size: Vector2(48, 48), anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    final idleAnimation = await gameRef.loadSpriteAnimation(
      'player_idle.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(48, 48),
      ),
    );
    final movingAnimation = await gameRef.loadSpriteAnimation(
      'player_moving.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2(48, 48),
      ),
    );
    animation = idleAnimation; // Start with the player idle

    // Adding hitbox for collision detection
    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply gravity
    velocity.y += gravity * dt;

    // Update position
    position += velocity * dt;

    // Check for ground contact
    if (position.y >= gameRef.size.y - size.y / 2) {
      position.y = gameRef.size.y - size.y / 2;
      onGround = true;
      velocity.y = 0;
    } else {
      onGround = false;
    }

    // Update animation based on movement
    if (velocity.x.abs() > 0.1 && onGround) {
      animation = movingAnimation; // Assuming movingAnimation is defined
    } else if (onGround) {
      animation = idleAnimation; // Assuming idleAnimation is defined
    }
  }

  void jump() {
    if (onGround) {
      velocity.y = jumpSpeed;
      onGround = false;
    }
  }

  void moveLeft() {
    velocity.x = -150;
  }

  void moveRight() {
    velocity.x = 150;
  }

  void stop() {
    velocity.x = 0;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with obstacles or enemies
    if (other is Enemy) {
      lives -= 1;
      if (lives <= 0) {
        // Handle player death
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    // Optional: Handle end of collision
  }

  void addScore(int points) {
    score += points;
  }
}