import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: NameScreen()));

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your name')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Greet'),
              onPressed: () {
                final name = _controller.text.trim();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GreetingScreen(
                      name: name.isEmpty ? 'stranger' : name,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GreetingScreen extends StatelessWidget {
  final String name;
  const GreetingScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Greeting')),
      body: Center(
        child: Text('Hello, $name!', style: const TextStyle(fontSize: 32)),
      ),
    );
  }
}
