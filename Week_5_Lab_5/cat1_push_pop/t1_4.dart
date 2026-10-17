import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StepScreen(step: 1)));

class StepScreen extends StatelessWidget {
  final int step;
  const StepScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final isLast = step == 4;
    return Scaffold(
      appBar: AppBar(title: Text('Step $step')),
      body: Center(
        child: isLast
            ? ElevatedButton(
                child: const Text('Finish'),
                // Pops Steps 4, 3, 2 at once; stops at the first route.
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              )
            : ElevatedButton(
                child: const Text('Next'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StepScreen(step: step + 1),
                  ),
                ),
              ),
      ),
    );
  }
}
