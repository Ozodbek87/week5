import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum TransitionKind { fade, slide, scale }

/// Reusable helper: every route can use it.
CustomTransitionPage<void> buildPage(
  GoRouterState state,
  Widget child, {
  TransitionKind kind = TransitionKind.slide,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      switch (kind) {
        case TransitionKind.fade:
          return FadeTransition(opacity: curved, child: child);
        case TransitionKind.slide:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          );
        case TransitionKind.scale:
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(curved),
              child: child,
            ),
          );
      }
    },
  );
}

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (c, s) => const HomeScreen()),
    GoRoute(
      path: '/details',
      pageBuilder: (c, s) => buildPage(s, const DemoScreen('Slide')),
    ),
    GoRoute(
      path: '/scale',
      pageBuilder: (c, s) =>
          buildPage(s, const DemoScreen('Scale + fade'), kind: TransitionKind.scale),
    ),
    GoRoute(
      path: '/fade',
      pageBuilder: (c, s) =>
          buildPage(s, const DemoScreen('Fade'), kind: TransitionKind.fade),
    ),
  ],
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
              onPressed: () => context.push('/details'),
              child: const Text('Slide'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/scale'),
              child: const Text('Scale + fade'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/fade'),
              child: const Text('Fade'),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoScreen extends StatelessWidget {
  final String label;
  const DemoScreen(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(child: Text(label, style: const TextStyle(fontSize: 28))),
    );
  }
}
