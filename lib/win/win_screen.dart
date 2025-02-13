import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_crossing_puzzle/style/responsive_screen.dart';
import 'package:the_crossing_puzzle/style/wobbly_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You won!',
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Thank you for playing the game (my first game in Flame).',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'I hope you enjoyed it! ',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please give me feedback on how I can improve it.',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              WobblyButton(
                onPressed: () =>
                    _launchUrl('mailto:rodrigodesouzacastro@gmail.com'),
                child: Text(
                  'Mail me',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              WobblyButton(
                onPressed: () =>
                    _launchUrl('https://linktr.ee/rodrigocastro_o'),
                child: Text(
                  'Connect with me',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: Text(
                'Play Again?',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.teal,
                ),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: Text(
                'Go to Main Menu',
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
