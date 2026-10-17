import 'package:flutter/material.dart';

/// Part 1: reusable route -> Navigator.push(context, FadeRoute(const Details()))
class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRoute(this.page)
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
        );
}

void main() {
  runApp(MaterialApp(
    // Part 2: change the transition for the WHOLE app, no custom routes.
    // On Android, MaterialPageRoute will now use the iOS-style slide.
    theme: ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    ),
    home: const HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('FadeRoute (custom)'),
              onPressed: () =>
                  Navigator.push(context, FadeRoute(const DetailsScreen('Fade'))),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              child: const Text('MaterialPageRoute (theme: Cupertino)'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const DetailsScreen('Cupertino via theme')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final String text;
  const DetailsScreen(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(child: Text(text, style: const TextStyle(fontSize: 24))),
    );
  }
}
// Comparison: the theme route slides from the right with a parallax effect on
// the old page and supports the iOS swipe-back gesture; FadeRoute only fades.
