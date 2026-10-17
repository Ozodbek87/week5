import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;
  const User({required this.name, required this.age, required this.city});
}

const users = [
  User(name: 'Aziz', age: 21, city: 'Tashkent'),
  User(name: 'Malika', age: 19, city: 'Samarkand'),
  User(name: 'Timur', age: 23, city: 'Bukhara'),
];

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    // No `routes` table: everything goes through onGenerateRoute.
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          return MaterialPageRoute(builder: (_) => const UserListScreen());
        case '/profile':
          final args = settings.arguments;
          if (args is User) {
            // arguments are unpacked here, the screen uses a typed constructor
            return MaterialPageRoute(
              builder: (_) => ProfileScreen(user: args),
              settings: settings,
            );
          }
          // wrong or missing argument -> error screen instead of a crash
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Invalid arguments for /profile')),
            ),
          );
      }
      return null; // unknown route
    },
  ));
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView(
        children: [
          for (final u in users)
            ListTile(
              title: Text(u.name),
              onTap: () =>
                  Navigator.pushNamed(context, '/profile', arguments: u),
            ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Center(
        child: Text('${user.name}, ${user.age}, ${user.city}',
            style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
