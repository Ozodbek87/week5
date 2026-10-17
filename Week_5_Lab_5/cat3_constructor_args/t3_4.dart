import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _color = Colors.grey;

  Future<void> _choose() async {
    final c = await Navigator.push<Color>(
      context,
      MaterialPageRoute(builder: (_) => const ColorPickerScreen()),
    );
    if (!mounted) return;
    if (c != null) setState(() => _color = c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 120, height: 120, color: _color),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _choose,
              child: const Text('Choose colour'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a colour')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final c in [Colors.red, Colors.green, Colors.blue]) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: c,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 48),
                ),
                onPressed: () => Navigator.pop(context, c), // result back
                child: const Text('Select'),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}
