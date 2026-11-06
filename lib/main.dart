import 'package:flutter/material.dart';

void main() => runApp(const GamiroApp());

const blue = Color(0xFF38A9FF);
const background = Color(0xFF080B10);
const panel = Color(0xFF121923);

class GamiroApp extends StatelessWidget {
  const GamiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAMIRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          color: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;

  final pages = const [
    DashboardPage(),
    LibraryPage(),
    PlatformsPage(),
    ToolsPage(),
  ];

  final labels = ['Home', 'Library', 'Platforms', 'Tools'];
  final icons = [
    Icons.dashboard_rounded,
    Icons.video_library_rounded,
    Icons.devices_rounded,
    Icons.build_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GAMIRO',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Icon(Icons.account_circle_outlined, color: blue),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: pages[selected],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (value) => setState(() => selected = value),
        destinations: List.generate(
          labels.length,
          (i) => NavigationDestination(
            icon: Icon(icons[i]),
            label: labels[i],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF172C42), Color(0xFF10141C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: blue.withValues(alpha: .35)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('WELCOME TO', style: TextStyle(color: blue, letterSpacing: 3)),
              SizedBox(height: 8),
              Text('GAMIRO', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
              SizedBox(height: 8),
              Text('One gaming world. Your entire library.'),
              SizedBox(height: 18),
              Text('DISCOVER  •  BUILD  •  MANAGE  •  PLAY',
                  style: TextStyle(fontSize: 10, letterSpacing: 1.2)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('YOUR GAMING HUB',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FeatureCard(Icons.games, 'Game Library', 'Organize your collection'),
            FeatureCard(Icons.storefront, 'Store Designer', 'Create your own store'),
            FeatureCard(Icons.inventory_2, 'Package Manager', 'Manage supported files'),
            FeatureCard(Icons.devices, 'Multi-platform', 'Your games, organized'),
          ],
        ),
        const SizedBox(height: 24),
        const Text('COMING NEXT',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text(
          'Game importing, cover art, console filters, local network features, '
          'and compatible package-building tools.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard(this.icon, this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: blue, size: 28),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.white60)),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) => const EmptyPage(
    icon: Icons.video_library_outlined,
    title: 'Your Library',
    message: 'Your game collection will appear here. Game importing is coming next.',
  );
}

class PlatformsPage extends StatelessWidget {
  const PlatformsPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: const [
      Text('SUPPORTED PLATFORM TARGETS',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
      SizedBox(height: 14),
      PlatformTile(Icons.android, 'Android', 'Mobile app'),
      PlatformTile(Icons.phone_iphone, 'iOS', 'Mobile app'),
      PlatformTile(Icons.window, 'Windows', 'Desktop app'),
      PlatformTile(Icons.laptop_mac, 'macOS', 'Desktop app'),
      PlatformTile(Icons.terminal, 'Linux', 'Desktop app'),
      PlatformTile(Icons.language, 'Web', 'Browser app'),
    ],
  );
}

class PlatformTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String description;

  const PlatformTile(this.icon, this.name, this.description, {super.key});

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon, color: blue),
      title: Text(name),
      subtitle: Text(description),
      trailing: const Icon(Icons.check_circle_outline, color: blue),
    ),
  );
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) => const EmptyPage(
    icon: Icons.build_circle_outlined,
    title: 'GAMIRO Tools',
    message: 'Store designer, package manager, and build tools are planned here.',
  );
}

class EmptyPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const EmptyPage({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: blue),
          const SizedBox(height: 18),
          Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(message, textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60, height: 1.5)),
        ],
      ),
    ),
  );
}
