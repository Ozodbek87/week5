import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (_) => const HomeScreen(),
      '/rate': (_) => const RateScreen(),
    },
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _movie = 'Inception';
  int? _rating;

  Future<void> _rate() async {
    final rating =
        await Navigator.pushNamed<int>(context, '/rate', arguments: _movie);
    if (!mounted) return;
    // Back arrow -> rating == null -> the old value stays.
    if (rating != null) setState(() => _rating = rating);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _rating == null ? 'Not rated yet' : '$_movie: $_rating/5',
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _rate, child: const Text('Rate')),
          ],
        ),
      ),
    );
  }
}

class RateScreen extends StatelessWidget {
  const RateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Rate $title')),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 1; i <= 5; i++)
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.star, color: Colors.amber),
                tooltip: '$i',
                onPressed: () => Navigator.pop(context, i),
              ),
          ],
        ),
      ),
    );
  }
}
