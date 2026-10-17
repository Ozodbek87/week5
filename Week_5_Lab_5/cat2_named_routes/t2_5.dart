import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (_) => const LoginScreen(),
      '/home': (_) => const HomeScreen(),
      '/profile': (_) => const ProfileScreen(),
    },
  ));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign in'),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Profile'),
          onPressed: () => Navigator.pushNamed(context, '/profile'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Log out'),
          // (route) => false removes EVERY route below -> clean stack.
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false),
        ),
      ),
    );
  }
}
