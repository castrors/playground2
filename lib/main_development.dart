import 'package:flutter/material.dart';
import 'package:the_crossing_puzzle/bootstrap.dart';

import 'package:the_crossing_puzzle/router.dart';

void main() {
  bootstrap(
    () => MaterialApp.router(
      title: 'The Crossing Puzzle',
      routerConfig: router,
    ),
  );
}
