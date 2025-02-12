// ignore_for_file: lines_longer_than_80_chars

import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class InstructionsDialog extends StatefulWidget {
  const InstructionsDialog({super.key});

  @override
  State<InstructionsDialog> createState() => _InstructionsDialogState();
}

class _InstructionsDialogState extends State<InstructionsDialog> {
  final _pageController = PageController();
  late int _currentPage = _pageController.initialPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Instructions',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            SizedBox(
              width: 30,
              child: _currentPage != 0
                  ? IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  : null,
            ),
            SizedBox(
              width: 350,
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int newPage) {
                  setState(() {
                    _currentPage = newPage;
                  });
                },
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 100,
                          height: 200,
                          child: SpriteAnimationWidget.asset(
                            path: 'main_character/walk.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 8,
                              stepTime: 0.15,
                              textureSize: Vector2(13, 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Flexible(
                        flex: 7,
                        child: Text(
                          '''
You have to cross all the objects from the south to the north using this bridge. You can only cross one object at a time. Press SPACE or click in the DROP button if you want to release the object.
''',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child:
                              // SpriteWidget.asset(path: 'enemies/obstacles.png'),
                              SpriteAnimationWidget.asset(
                            path: 'main_character/walk.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 8,
                              stepTime: 0.15,
                              textureSize: Vector2(13, 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Flexible(
                        flex: 6,
                        child: Text(
                          '''
  Move around the map using the arrow keys or WASD or the joystick.
''',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        flex: 7,
                        child: Text(
                          '''
Remember:
1) the fox cannot be alone with the goose, otherwise it will eat it;
2) and the goose cannot be alone with the corn, otherwise it will eat it.
''',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: SpriteAnimationWidget.asset(
                            path: 'main_character/idle.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.15,
                              textureSize: Vector2(13, 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child:
                              // SpriteWidget.asset(path: 'enemies/obstacles.png'),
                              SpriteAnimationWidget.asset(
                            path: 'main_character/idle.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.15,
                              textureSize: Vector2(13, 14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Flexible(
                        flex: 6,
                        child: Text(
                          'Enjoy the game and have fun!',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
              child: _currentPage != 3
                  ? IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  : null,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
