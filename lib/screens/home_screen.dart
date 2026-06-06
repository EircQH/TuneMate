import 'package:flutter/material.dart';
import 'tuning_screen.dart';
import 'fretboard_screen.dart';
import 'chord_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ChordScreen(),
    FretboardScreen(),
    TuningScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('TuneMate'),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                ' | EircZ',
                style: TextStyle(
                  fontSize: 9,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: '和弦',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: '指板',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tune),
            label: '特调',
          ),
        ],
      ),
    );
  }
}
