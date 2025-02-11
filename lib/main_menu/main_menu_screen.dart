import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playground2/style/responsive_screen.dart';
import 'package:playground2/style/wobbly_button.dart';

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
                GoRouter.of(context).go('/play');
              },
              child: Text(
                'Play',
                style:
                    GoogleFonts.pressStart2p(fontSize: 16, color: Colors.teal),
              ),
            ),
            _gap,
            // WobblyButton(
            //   onPressed: () => GoRouter.of(context).push('/settings'),
            //   child: const Text('Settings'),
            // ),
            // _gap,
            const Text('Built with ❤️ by the Orcs Team'),
          ],
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}
