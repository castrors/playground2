import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:playground2/game/components/instructions_dialog.dart';
import 'package:playground2/my_game.dart';

class MyGameWidget extends StatelessWidget {
  const MyGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: MyGame()),
        Positioned(
          right: 16,
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.info),
            iconSize: 36,
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const IntrinsicHeight(child: InstructionsDialog()),
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
        ),
      ],
    );
  }
}
