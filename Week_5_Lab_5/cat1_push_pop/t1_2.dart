import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ScreenA()));

/// Generic screen: if [nextBuilder] is given it shows "Next", otherwise "Back".
class LetterScreen extends StatelessWidget {
  final String letter;
  final Color color;
  final Widget Function()? nextBuilder;

  const LetterScreen({
    super.key,
    required this.letter,
    required this.color,
    this.nextBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final next = nextBuilder;
    return Scaffold(
      appBar: AppBar(title: Text('Screen $letter'), backgroundColor: color),
      body: Center(
        child: ElevatedButton(
          onPressed: next == null
              ? () => Navigator.pop(context)
              : () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => next()),
                  ),
          child: Text(next == null ? 'Back' : 'Next'),
        ),
      ),
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});
  @override
  Widget build(BuildContext context) => LetterScreen(
        letter: 'A',
        color: Colors.red.shade300,
        nextBuilder: () => const ScreenB(),
      );
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});
  @override
  Widget build(BuildContext context) => LetterScreen(
        letter: 'B',
        color: Colors.green.shade300,
        nextBuilder: () => const ScreenC(),
      );
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});
  @override
  Widget build(BuildContext context) =>
      LetterScreen(letter: 'C', color: Colors.blue.shade300);
}
// System back button behaves exactly like Navigator.pop on every screen
// (on A it closes the app).
