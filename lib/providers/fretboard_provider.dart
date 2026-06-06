// lib/providers/fretboard_provider.dart
import 'package:flutter/material.dart';
import '../models/tuning_scheme.dart';
import '../utils/note_utils.dart';
import '../utils/constants.dart';

class FretboardProvider extends ChangeNotifier {
  List<List<String>> _notes = [];
  int _maxFrets = 21;
  String? _currentTuningId;

  List<List<String>> get notes => _notes;
  int get maxFrets => _maxFrets;
  String? get currentTuningId => _currentTuningId;

  void updateForTuning(TuningScheme? tuning) {
    _currentTuningId = tuning?.id ?? 'standard';
    if (tuning == null) {
      _notes = NoteUtils.getFretboardNotes(
        AppConstants.standardTuning,
        maxFrets: _maxFrets,
      );
    } else {
      final openNotes = tuning.strings.map((s) {
        return NoteUtils.getOpenNoteForTuning(
          capoFret: s.capoFret,
          referenceString: s.referenceString,
        );
      }).toList();

      _notes = NoteUtils.getFretboardNotes(openNotes, maxFrets: _maxFrets);
    }
    notifyListeners();
  }

  void setMaxFrets(int frets) {
    _maxFrets = frets.clamp(5, 24);
    notifyListeners();
  }
}
