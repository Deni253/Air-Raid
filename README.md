# ✈️ Air-Raid: Survival Flight Game

**Air-Raid** is an Android mobile game developed using Flutter, where the player controls a plane using the gyroscope and must survive by avoiding gray enemy planes. The goal is to score as many points as possible, which are saved in Firebase and displayed on a global leaderboard.

---

## 📱 Platform

- Android (API 21+)
- Required sensor: gyroscope

---

## 🚀 Features

- **Gyroscope-based** plane control
- Randomly generated enemy planes with gradually increasing speed
- **Firebase integration** for storing user scores
- **Leaderboard** with ascending/descending sorting
- **Smooth animations** for player and enemy planes
- **Daily notification at 21:00** (via Awesome Notifications)
- **Looping video background** during gameplay
- Game over **modal** with two options:
  - Restart game
  - Return to main screen

---

## 🧠 Technologies

| Technology              | Purpose                                |
|-------------------------|----------------------------------------|
| **Flutter**             | Main framework                         |
| **Dart**                | Programming language                   |
| **Provider**            | MVVM pattern and state management      |
| **Firebase Auth**       | User authentication                    |
| **Firebase Realtime DB**| Score storage                          |
| **Awesome Notifications**| Daily and local notifications         |
| **Sensors Plus**        | Handling gyroscope input               |
| **Video Player**        | Playing video background               |

---

## 📂 Project Structure

lib/
├── views/ # UI layer
│ ├── login_screen.dart
│ ├── first_page.dart
│ ├── second_page.dart
│ └── leaderboard.dart
├── viewmodels/ # ViewModel logic
│ ├── login_viewmodel.dart
│ ├── first_page_viewmodel.dart
│ ├── game_viewmodel.dart
│ └── leaderboard_viewmodel.dart
├── models/ # Data models
│ ├── user_model.dart
│ └── player_model.dart
├── services/ # Notification logic
│ └── notification_service.dart
└── main.dart # Application entry point

yaml
Kopiraj

---

## 🔐 Login & Registration

Users authenticate through **Firebase Authentication**, allowing scores to be saved and filtered per user.

---

## 🏆 Leaderboard

- Fetches all users from Firebase
- Displays usernames and their scores
- Supports score sorting via a button in the top-right corner

---

## 🔔 Notifications

A daily notification is scheduled at 21:00 using **Awesome Notifications**:
> "Hello! Welcome back to Airplane Game 🚀"

---

## 🎮 Gameplay

- The player tilts the phone to steer the plane
- Collision with a gray plane = **GAME OVER**
- Enemy speed increases every 1000 points
- A modal appears on game over with:
  - Restart option
  - Return to menu

---

## 💾 Firebase Structure

```json
Users: {
  UID1: {
    username: "Ivan",
    score: 1275,
    updatedAt: "2025-06-17T21:00:00Z"
  },
  UID2: {
    username: "Ana",
    score: 950,
    updatedAt: "2025-06-17T20:59:00Z"
  }
}
```
---
## 📸 Screenshots

Login Screen
![Login](https://github.com/user-attachments/assets/782141fb-d8a5-4bcf-843e-deffaf4010b4)

Start Screen
![Start Screen](https://github.com/user-attachments/assets/c7b9e67e-925f-4312-8c62-154bb84224ed)


In-Game
![Gameplay](https://github.com/user-attachments/assets/5f31d307-ca7b-4482-bc23-535b945e729f)


Game Over Modal
![Gameover modal](https://github.com/user-attachments/assets/08865e0c-f15e-40ca-9d84-6c3c1661c79c)


Leaderboard
![LeaderBoard](https://github.com/user-attachments/assets/32a317a4-bac3-4f0b-9e75-7781fb16a209)

---

🔮 Future Improvements
Add background music and sound effects

Difficulty levels (easy/medium/hard)

Local score tracking and offline mode
