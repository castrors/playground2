import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playground2/style/responsive_screen.dart';
import 'package:playground2/style/wobbly_button.dart';

class LoseScreen extends StatelessWidget {
  const LoseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('You lose!')],
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: const Text('Play Again?'),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text('Go to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
