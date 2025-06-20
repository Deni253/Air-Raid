import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SecondPageViewModel extends ChangeNotifier {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("Users");

  double targetX = 175;
  double targetY = 745.5;
  final double playerWidth = 30;
  final double playerHeight = 30;

  int playerScore = 0;
  bool gameOver = false;
  final List<Rect> obstacles = [];
  final Random random = Random();

  SecondPageViewModel() {
    _startGyroscope();
    _startScoreCounter();
    _startObstacleMovement();
  }

  void _startGyroscope() {
    double velocityX = 0;
    double velocityY = 0;

    gyroscopeEvents.listen((event) {
      if (gameOver) return;

      double sensitivity = 3;

      if (event.y > 0.2) {
        velocityX += event.y * sensitivity;
      }
      if (event.x > 0.2) {
        velocityY += event.x * sensitivity;
      }
      if (event.y < -0.2) {
        velocityX += event.y * sensitivity;
      }
      if (event.x < -0.2) {
        velocityY += event.x * sensitivity;
      }

      targetX += velocityX;
      targetY += velocityY;

      targetX = targetX.clamp(0.0, 370.0);
      targetY = targetY.clamp(0.0, 770.0);

      notifyListeners();
    });
  }

  void _startScoreCounter() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!gameOver) {
        playerScore += 25;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void _startObstacleMovement() {
    for (int i = 0; i < 15; i++) {
      Future.delayed(Duration(milliseconds: random.nextInt(3000)), () {
        obstacles.add(
          Rect.fromLTWH(
            random.nextDouble() * 370,
            -random.nextDouble() * 500,
            30,
            30,
          ),
        );
        notifyListeners();
      });
    }

    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (gameOver) {
        timer.cancel();
        return;
      }

      double speed = 3;
      for (int i = 0; i < obstacles.length; i++) {
        speed = 3.0 + (playerScore ~/ 1000) * 3.0;
        obstacles[i] = obstacles[i].translate(0, speed);

        final playerRect = Rect.fromLTWH(
          targetX + 3,
          targetY + 3,
          playerWidth - 6,
          playerHeight - 6,
        );

        if (obstacles[i].overlaps(playerRect)) {
          gameOver = true;
          sendScoreToDB(playerScore);
          break;
        }

        if (obstacles[i].top > 820) {
          obstacles[i] = Rect.fromLTWH(random.nextDouble() * 370, -30, 30, 30);
        }
      }

      notifyListeners();
    });
  }

  Future<void> sendScoreToDB(int score) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final ref = FirebaseDatabase.instance.ref("Users/${user.uid}");

      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final username = data['username'] ?? 'Unknown';
        final existingScore = data['score'] ?? 0;

        if (score > existingScore) {
          await ref.update({
            'score': score,
            'username': username,
            'updatedAt': DateTime.now().toIso8601String(),
          });
        }
      }
    }
  }

  void endGame() {
    gameOver = true;
    notifyListeners();
  }

  void resetGameOver() {
    targetX = 175;
    targetY = 745.5;
    playerScore = 0;
    gameOver = false;
    obstacles.clear();
    _startObstacleMovement();
    _startScoreCounter();
    notifyListeners();
  }
}
