import 'package:flutter/material.dart';
import 'package:playground2/bootstrap.dart';
import 'package:playground2/router.dart';

void main() {
  bootstrap(
    () => MaterialApp.router(
      title: 'Corn-Goose-Fox',
      routerConfig: router,
    ),
  );
}
