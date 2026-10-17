import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (c, s) => const HomeScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (c, s) => const SimpleScreen(title: 'Settings'),
    ),
    GoRoute(
      name: 'item',
      path: '/item/:id',
      builder: (c, s) =>
          SimpleScreen(title: 'Item #${s.pathParameters['id']}'),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('404')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Page not found', style: TextStyle(fontSize: 24)),
          Text('${state.uri}'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.goNamed('home'),
            child: const Text('Home'),
          ),
        ],
      ),
    ),
  ),
);

void main() => runApp(MaterialApp.router(routerConfig: router));

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
              onPressed: () => context.goNamed('settings'),
              child: const Text('Settings'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  context.goNamed('item', pathParameters: {'id': '42'}),
              child: const Text('Item 42'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/nope'), // triggers errorBuilder
              child: const Text('Broken link'),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleScreen extends StatelessWidget {
  final String title;
  const SimpleScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.goNamed('home'),
          child: Text('$title - back to Home'),
        ),
      ),
    );
  }
}
