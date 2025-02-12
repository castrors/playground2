import 'package:flutter/material.dart';
import 'package:playground2/game/components/instructions_dialog.dart';

class HowToPlayDialog {
  static void show(BuildContext context) {
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
  }
}
