import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MenuScene extends Component with HasGameRef, TapDetector {
  late TextComponent title;
  late TextComponent playButton;
  late TextComponent levelSelectButton;
  late TextComponent settingsButton;
  late RectComponent background;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBackground();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  void _loadBackground() {
    background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.lightBlueAccent,
    );
    add(background);
  }

  void _loadTitle() {
    title = TextComponent(
      text: 'Final Test-platformer-01',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 5),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(title);
  }

  void _loadPlayButton() {
    playButton = TextComponent(
      text: 'Play',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2.5),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
    playButton.add(RectangleHitbox()..onTap = () => print('Play tapped'));
    add(playButton);
  }

  void _loadLevelSelectButton() {
    levelSelectButton = TextComponent(
      text: 'Select Level',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
    levelSelectButton.add(RectangleHitbox()..onTap = () => print('Select Level tapped'));
    add(levelSelectButton);
  }

  void _loadSettingsButton() {
    settingsButton = TextComponent(
      text: 'Settings',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 1.75),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
    settingsButton.add(RectangleHitbox()..onTap = () => print('Settings tapped'));
    add(settingsButton);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final tapPosition = info.eventPosition.game;
    if (playButton.toRect().contains(tapPosition.toOffset())) {
      // Handle play button tap
      print('Play Game');
    } else if (levelSelectButton.toRect().contains(tapPosition.toOffset())) {
      // Handle level select button tap
      print('Select Level');
    } else if (settingsButton.toRect().contains(tapPosition.toOffset())) {
      // Handle settings button tap
      print('Open Settings');
    }
  }
}