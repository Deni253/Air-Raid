import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../viewmodels/game_viewmodel.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late VideoPlayerController _controller;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/sky.mp4');
    _controller.initialize().then((_) {
      _controller.play();
      _controller.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showGameOverDialog(BuildContext context, SecondPageViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: const Text('Game Over'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  vm.resetGameOver();
                  setState(() {
                    _dialogShown = false;
                  });
                },
                child: const Text('Restart'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Main Menu'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return SecondPageViewModel();
      },
      child: Consumer<SecondPageViewModel>(
        builder: (context, vm, _) {
          if (vm.gameOver && !_dialogShown) {
            _dialogShown = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showGameOverDialog(context, vm);
            });
          }
          return Scaffold(
            body: Stack(
              children: [
                _controller.value.isInitialized
                    ? SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    )
                    : Container(),

                TweenAnimationBuilder<Offset>(
                  tween: Tween<Offset>(
                    begin: Offset(vm.targetX, vm.targetY),
                    end: Offset(vm.targetX, vm.targetY),
                  ),
                  duration: Duration(milliseconds: 100),
                  builder: (context, value, child) {
                    return Positioned(
                      left: value.dx,
                      top: value.dy,
                      child: Container(
                        width: vm.playerWidth,
                        height: vm.playerHeight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/plane.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                for (Rect obstacle in vm.obstacles)
                  Positioned(
                    left: obstacle.left,
                    top: obstacle.top,
                    child: Container(
                      width: obstacle.width,
                      height: obstacle.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/gray_plane.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      vm.playerScore.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                if (vm.gameOver)
                  Center(
                    child: Text(
                      "GAME OVER",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
