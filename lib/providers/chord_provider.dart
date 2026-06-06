// lib/providers/chord_provider.dart
import 'package:flutter/material.dart';
import '../models/chord.dart';
import '../data/built_in_chords.dart';

class ChordProvider extends ChangeNotifier {
  List<Chord> _chords = [];
  String _selectedKey = 'C';
  Chord? _selectedChord;

  List<Chord> get chords => _chords;
  String get selectedKey => _selectedKey;
  Chord? get selectedChord => _selectedChord;

  List<String> get availableKeys => BuiltInChords.availableKeys;

  List<Chord> get filteredChords =>
      _chords.where((c) => c.key == _selectedKey).toList();

  void loadChords() {
    _chords = BuiltInChords.chords;
    notifyListeners();
  }

  void selectKey(String key) {
    _selectedKey = key;
    _selectedChord = null;
    notifyListeners();
  }

  void selectChord(Chord chord) {
    _selectedChord = chord;
    notifyListeners();
  }
}
