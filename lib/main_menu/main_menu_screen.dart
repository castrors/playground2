import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:the_crossing_puzzle/game/dialog/how_to_play_dialog.dart';
import 'package:the_crossing_puzzle/game/provider/settings_model.dart';
import 'package:the_crossing_puzzle/style/responsive_screen.dart';
import 'package:the_crossing_puzzle/style/wobbly_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/banner.png',
              //   filterQuality: FilterQuality.none,
              // ),
              Text(
                'The crossing puzzle',
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                ),
              ),
              _gap,
            ],
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WobblyButton(
              onPressed: () {
                FlameAudio.play('collect.wav');
                GoRouter.of(context).go('/play');
              },
              child: Text(
                'Play',
                style:
                    GoogleFonts.pressStart2p(fontSize: 16, color: Colors.teal),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                HowToPlayDialog.show(context);
              },
              child: Text(
                'How to play',
                style: GoogleFonts.pressStart2p(
                  fontSize: 16,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                context.read<SettingsModel>().toggleMusic();
              },
              child: Text(
                context.watch<SettingsModel>().isMusicOn
                    ? 'Music: On'
                    : 'Music: Off',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                context.read<SettingsModel>().toggleSound();
              },
              child: Text(
                context.watch<SettingsModel>().isSoundOn
                    ? 'Sfx: On'
                    : 'Sfx: Off',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            // WobblyButton(
            //   onPressed: () => GoRouter.of(context).push('/settings'),
            //   child: const Text('Settings'),
            // ),
            _gap,
            _gap,
            const Text('Built with ❤️ by the Orcs Team'),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
