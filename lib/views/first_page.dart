import 'package:airplane/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/first_page_viewmodel.dart';
import 'package:airplane/views/leaderboard.dart' as board;
import 'package:airplane/views/second_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = FirstPageViewModel();
        vm.startAnimation();
        vm.scheduleDailyNotificationAt21h();
        return vm;
      },
      child: const FirstPageContent(),
    );
  }
}

class FirstPageContent extends StatelessWidget {
  const FirstPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FirstPageViewModel>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 84, 158, 248)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sky.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              tween: Tween(begin: 0, end: vm.ninety),
              curve: Curves.bounceOut,
              builder: (context, value, child) {
                return Positioned(
                  top: value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: value,
                    width: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Airraid.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: -500, end: vm.seventy),
              curve: Curves.decelerate,
              builder: (context, value, child) {
                return Positioned(
                  left: 125,
                  right: 120,
                  bottom: value + 45,
                  child: SizedBox(
                    width: 20,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'START',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 10,
              right: 8,
              child: SizedBox(
                width: 60,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const board.Leaderboard(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Icon(Icons.leaderboard, size: 25, weight: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
