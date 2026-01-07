import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class GameScene extends Component with HasGameRef, TapDetector {
  late Player player;
  late ScoreDisplay scoreDisplay;
  int currentLevel = 1;
  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadLevel(currentLevel);
    _spawnPlayer();
    _setupScoreDisplay();
  }

  void _loadLevel(int levelNumber) {
    // Load level layout, obstacles, and collectibles based on levelNumber
    // This is a placeholder for level loading logic
    print('Loading level $levelNumber');
  }

  void _spawnPlayer() {
    player = Player();
    add(player);
  }

  void _setupScoreDisplay() {
    scoreDisplay = ScoreDisplay(score: score);
    add(scoreDisplay);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game loop logic here
    // Check win/lose conditions, update score, etc.
  }

  @override
  void onTap() {
    // Handle tap input for player jump or other interactions
    player.jump();
  }

  void pauseGame() {
    gameRef.pauseEngine();
  }

  void resumeGame() {
    gameRef.resumeEngine();
  }

  void restartLevel() {
    // Restart current level logic
    removeAll(children);
    _loadLevel(currentLevel);
    _spawnPlayer();
    _setupScoreDisplay();
  }

  void nextLevel() {
    // Load next level logic
    currentLevel++;
    restartLevel();
  }
}

class Player extends SpriteComponent {
  void jump() {
    // Player jump logic here
    print('Player jumps');
  }
}

class ScoreDisplay extends TextComponent {
  int score;

  ScoreDisplay({required this.score}) : super(text: 'Score: $score');

  void updateScore(int newScore) {
    score = newScore;
    text = 'Score: $score';
  }
}