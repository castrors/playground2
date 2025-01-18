import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:playground2/lose/lose_screen.dart';
import 'package:playground2/main_menu/main_menu_screen.dart';
import 'package:playground2/my_game_screen.dart';
import 'package:playground2/win/win_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const MainMenuScreen(key: Key('main_menu_screen')),
    ),
    GoRoute(
      path: '/play',
      builder: (context, state) => const MyGameScreen(
        key: Key('my_game_screen'),
      ),
    ),
    GoRoute(
      path: '/win',
      builder: (context, state) => const WinScreen(
        key: Key('win_screen'),
      ),
    ),
    GoRoute(
      path: '/lose',
      builder: (context, state) => const LoseScreen(
        key: Key('lose_screen'),
      ),
    ),
  ],
);
