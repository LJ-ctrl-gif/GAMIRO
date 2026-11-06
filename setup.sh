#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "=== GAMIRO SETUP ==="

mkdir -p lib .github/workflows docs

cat > pubspec.yaml <<'YAML'
name: gamiro
description: A multi-platform gaming library and store builder.
publish_to: none
version: 1.0.0+1

environment:
  sdk: '>=3.4.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
YAML

cat > analysis_options.yaml <<'YAML'
include: package:flutter_lints/flutter.yaml
YAML

cat > lib/main.dart <<'DART'
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
DART

cat > README.md <<'MD'
# GAMIRO

**One gaming world.**

GAMIRO is an independent multi-platform gaming library and store-building project.

## Planned platforms
- Android
- iOS
- Windows
- macOS
- Linux
- Web

## Planned features
- Game library and catalog
- Cover art and metadata
- Store and theme designer
- Package organization for supported, legally obtained files
- Console catalog filters
- Local network features
- Compatible homebrew package-building tools

Platform support depends on each operating system's development tools and package formats. GAMIRO does not make packages interchangeable between consoles.

## Technology
Flutter and Dart. GitHub Actions provides cloud build environments.

## Development
The initial interface is a starter prototype. Features will be added incrementally.
MD

cat > docs/ROADMAP.md <<'MD'
# GAMIRO Roadmap

1. Project foundation and responsive dashboard
2. Game library: add, edit, search, filter
3. Game artwork and metadata
4. Console and platform selection
5. Store branding and layout designer
6. Legal package import and organization
7. Local network integration
8. Platform-specific builds and testing
9. Release and documentation
MD

cat > .github/workflows/build.yml <<'YAML'
name: GAMIRO Multi-platform Builds

on:
  workflow_dispatch:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter create --project-name gamiro --org com.gamiro --platforms=android,ios,web,windows,macos,linux .
      - run: flutter pub get
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v4
        with:
          name: gamiro-android-apk
          path: build/app/outputs/flutter-apk/app-release.apk

  web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter create --project-name gamiro --org com.gamiro --platforms=android,ios,web,windows,macos,linux .
      - run: flutter pub get
      - run: flutter build web --release
      - uses: actions/upload-artifact@v4
        with:
          name: gamiro-web
          path: build/web

  linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: sudo apt-get update && sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter create --project-name gamiro --org com.gamiro --platforms=android,ios,web,windows,macos,linux .
      - run: flutter pub get
      - run: flutter build linux --release
      - uses: actions/upload-artifact@v4
        with:
          name: gamiro-linux
          path: build/linux/x64/release/bundle

  windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter create --project-name gamiro --org com.gamiro --platforms=android,ios,web,windows,macos,linux .
      - run: flutter pub get
      - run: flutter build windows --release
      - uses: actions/upload-artifact@v4
        with:
          name: gamiro-windows
          path: build/windows/x64/runner/Release

  macos-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter create --project-name gamiro --org com.gamiro --platforms=android,ios,web,windows,macos,linux .
      - run: flutter pub get
      - run: flutter build macos --release
      - run: flutter build ios --release --no-codesign
      - uses: actions/upload-artifact@v4
        with:
          name: gamiro-macos-app
          path: build/macos/Build/Products/Release
YAML

git branch -M main
git config user.name "LJ-ctrl-gif"
GH_ID=$(gh api user --jq '.id')
GH_LOGIN=$(gh api user --jq '.login')
git config user.email "${GH_ID}+${GH_LOGIN}@users.noreply.github.com"

git add .
git commit -m "Create GAMIRO multi-platform starter"

if gh repo view LJ-ctrl-gif/GAMIRO >/dev/null 2>&1; then
  if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin https://github.com/LJ-ctrl-gif/GAMIRO.git
  fi
else
  gh repo create GAMIRO --public --source=. --remote=origin
fi

git push -u origin main

echo
echo "=== GAMIRO STARTER UPLOADED ==="
echo "https://github.com/LJ-ctrl-gif/GAMIRO"
