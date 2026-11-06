import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final storeController = TextEditingController(text: 'My GAMIRO Store');
  List<Map<String, dynamic>> packages = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadStore();
  }

  Future<void> loadStore() async {
    final prefs = await SharedPreferences.getInstance();
    storeController.text = prefs.getString('store_name') ?? 'My GAMIRO Store';
    final data = prefs.getString('store_packages');
    if (data != null) {
      packages = List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> saveStore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('store_name', storeController.text);
    await prefs.setString('store_packages', jsonEncode(packages));
  }

  Future<void> addPackage({int? editIndex}) async {
    final existing = editIndex == null ? <String, dynamic>{} : packages[editIndex];
    final title = TextEditingController(text: existing['title'] ?? '');
    final titleId = TextEditingController(text: existing['titleId'] ?? '');
    final version = TextEditingController(text: existing['version'] ?? '1.0');
    final size = TextEditingController(text: existing['size'] ?? '');
    final url = TextEditingController(text: existing['url'] ?? '');

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editIndex == null ? 'Add package' : 'Edit package'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(title, 'Package title'),
              _field(titleId, 'Title ID'),
              _field(version, 'Version'),
              _field(size, 'Size (e.g. 500 MB)'),
              _field(url, 'Authorized package URL'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (title.text.trim().isEmpty || url.text.trim().isEmpty) return;
              Navigator.pop(context, {
                'title': title.text.trim(),
                'titleId': titleId.text.trim(),
                'version': version.text.trim(),
                'size': size.text.trim(),
                'url': url.text.trim(),
              });
            },
            child: Text(editIndex == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        if (editIndex == null) {
          packages.add(result);
        } else {
          packages[editIndex] = result;
        }
      });
      await saveStore();
    }

    title.dispose();
    titleId.dispose();
    version.dispose();
    size.dispose();
    url.dispose();
  }

  Widget _field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> exportJson() async {
    final catalog = {
      'format': 'GAMIRO Store',
      'version': 1,
      'storeName': storeController.text,
      'packages': packages,
    };
    await Clipboard.setData(
      ClipboardData(text: const JsonEncoder.withIndent('  ').convert(catalog)),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Store JSON copied to clipboard')),
      );
    }
  }

  @override
  void dispose() {
    storeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('STORE BUILDER',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Create and manage your own package catalog',
            style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 20),
        TextField(
          controller: storeController,
          onChanged: (_) => saveStore(),
          decoration: const InputDecoration(
            labelText: 'Store name',
            prefixIcon: Icon(Icons.storefront),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Expanded(
              child: Text('PACKAGE ENTRIES',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('${packages.length} items',
                style: const TextStyle(color: Colors.white60)),
          ],
        ),
        const SizedBox(height: 10),
        if (packages.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('No packages yet. Add your first entry.',
                    style: TextStyle(color: Colors.white60)),
              ),
            ),
          ),
        ...packages.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Card(
            child: ListTile(
              leading: const Icon(Icons.inventory_2, color: blue),
              title: Text(item['title'] ?? 'Untitled'),
              subtitle: Text(
                '${item['titleId']} • v${item['version']} • ${item['size']}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: blue),
                    onPressed: () => addPackage(editIndex: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () async {
                      setState(() => packages.removeAt(index));
                      await saveStore();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: addPackage,
          icon: const Icon(Icons.add),
          label: const Text('Add package'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: exportJson,
          icon: const Icon(Icons.code),
          label: const Text('Export store JSON'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Only add packages you own or are authorized to distribute.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white38, fontSize: 11),
        ),
      ],
    );
  }
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
