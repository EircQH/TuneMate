import 'package:flutter/material.dart';
import '../models/chord.dart';
import '../widgets/chord_diagram.dart';

class ChordDetailScreen extends StatelessWidget {
  final Chord chord;

  const ChordDetailScreen({super.key, required this.chord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chord.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChordDiagram(chord: chord, size: 250),
            const SizedBox(height: 24),
            Text(
              chord.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${chord.key}调 · ${chord.typeDisplayNameCN}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
