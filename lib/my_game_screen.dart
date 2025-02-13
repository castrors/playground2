import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playground2/game/dialog/how_to_play_dialog.dart';
import 'package:playground2/game/provider/settings_model.dart';
import 'package:playground2/my_game.dart';
import 'package:provider/provider.dart';

class MyGameScreen extends StatelessWidget {
  const MyGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GameWidget(
            game: MyGame(
              playMusic: context.read<SettingsModel>().isMusicOn,
              playSounds: context.read<SettingsModel>().isSoundOn,
            ),
          ),
          Positioned(
            right: 16,
            child: Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.info),
                  iconSize: 36,
                  onPressed: () {
                    HowToPlayDialog.show(context);
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
      ),
    );
  }
}
