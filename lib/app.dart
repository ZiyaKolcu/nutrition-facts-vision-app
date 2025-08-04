import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_extensions.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Example',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(onThemeToggle: _toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Example'),
        actions: [
          IconButton(
            icon: Icon(context.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onThemeToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text styles showcase
            Text('H1 Heading', style: context.h1),
            const SizedBox(height: 8),
            Text('H2 Heading', style: context.h2),
            const SizedBox(height: 8),
            Text('H3 Heading', style: context.h3),
            const SizedBox(height: 8),
            Text('H4 Heading', style: context.h4),
            const SizedBox(height: 16),

            // Subtitle and body text
            Text('Subtitle 1', style: context.subtitle1),
            const SizedBox(height: 4),
            Text('Subtitle 2', style: context.subtitle2),
            const SizedBox(height: 8),
            Text(
              'This is body1 text. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: context.body1,
            ),
            const SizedBox(height: 8),
            Text(
              'This is body2 text. Sed do eiusmod tempor incididunt ut labore.',
              style: context.body2,
            ),
            const SizedBox(height: 8),
            Text('This is caption text', style: context.caption),
            const SizedBox(height: 24),

            // Buttons
            const Text(
              'Button Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated Button'),
                ),
                const SizedBox(width: 8),
                TextButton(onPressed: () {}, child: const Text('Text Button')),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Cards
            const Text(
              'Card Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Title', style: context.h4),
                    const SizedBox(height: 8),
                    Text(
                      'This is card content. It is styled according to Material 3 design system.',
                      style: context.body2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form examples
            const Text(
              'Form Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
              ),
            ),
            const SizedBox(height: 24),

            // Status colors
            const Text(
              'Status Colors:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const StatusColorWidget(),
            const SizedBox(height: 24),

            // Blue color palette
            const Text(
              'Blue Color Palette:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const BluePaletteWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FloatingActionButton pressed!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StatusColorWidget extends StatelessWidget {
  const StatusColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Warning',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Success',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BluePaletteWidget extends StatelessWidget {
  const BluePaletteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final blueColors = [
      const Color(0xFFE3F2FD), // blue50
      const Color(0xFFBBDEFB), // blue100
      const Color(0xFF90CAF9), // blue200
      const Color(0xFF64B5F6), // blue300
      const Color(0xFF42A5F5), // blue400
      const Color(0xFF2196F3), // blue500
      const Color(0xFF1E88E5), // blue600
      const Color(0xFF1976D2), // blue700
      const Color(0xFF1565C0), // blue800
      const Color(0xFF0D47A1), // blue900
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: blueColors.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: blueColors[index],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${(index + 1) * 100}',
              style: TextStyle(
                color: index > 4 ? Colors.white : Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
