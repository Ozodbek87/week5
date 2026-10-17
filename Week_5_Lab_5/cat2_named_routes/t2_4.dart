import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const messages = '/messages';
  static const about = '/about';
}

void main() {
  runApp(MaterialApp(
    initialRoute: AppRoutes.home,
    routes: {
      AppRoutes.home: (_) => const SectionScreen(title: 'Home', route: AppRoutes.home),
      AppRoutes.profile: (_) => const SectionScreen(title: 'Profile', route: AppRoutes.profile),
      AppRoutes.messages: (_) => const SectionScreen(title: 'Messages', route: AppRoutes.messages),
      AppRoutes.about: (_) => const SectionScreen(title: 'About', route: AppRoutes.about),
    },
  ));
}

class SectionScreen extends StatelessWidget {
  final String title;
  final String route;
  const SectionScreen({super.key, required this.title, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: AppDrawer(current: route),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 28))),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String current;
  const AppDrawer({super.key, required this.current});

  static const _items = [
    ('Home', AppRoutes.home, Icons.home),
    ('Profile', AppRoutes.profile, Icons.person),
    ('Messages', AppRoutes.messages, Icons.message),
    ('About', AppRoutes.about, Icons.info),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Menu', style: TextStyle(fontSize: 24)),
            ),
          ),
          for (final (label, route, icon) in _items)
            ListTile(
              leading: Icon(icon),
              title: Text(label),
              selected: route == current,
              onTap: () {
                Navigator.pop(context); // close the drawer first
                if (route != current) {
                  // replace -> the stack never grows
                  Navigator.pushReplacementNamed(context, route);
                }
              },
            ),
        ],
      ),
    );
  }
}
