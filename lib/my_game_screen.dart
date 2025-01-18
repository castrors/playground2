import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playground2/game/components/instructions_dialog.dart';
import 'package:playground2/my_game.dart';

class MyGameScreen extends StatelessWidget {
  const MyGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: MyGame()),
        Positioned(
          right: 16,
          child: Row(
            children: [
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.info),
                iconSize: 36,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            const IntrinsicHeight(child: InstructionsDialog()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                iconSize: 36,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Quit Game'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                            child: const Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              GoRouter.of(context).go('/');
                            },
                            child: const Text('Quit'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
