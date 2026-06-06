// test/utils/note_utils_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tunemate/utils/note_utils.dart';

void main() {
  group('NoteUtils', () {
    test('getNoteAtFret returns correct note for standard tuning', () {
      // 6弦空弦是E，0品=E
      expect(NoteUtils.getNoteAtFret('E', 0), 'E');
      // 6弦1品=F
      expect(NoteUtils.getNoteAtFret('E', 1), 'F');
      // 6弦3品=G
      expect(NoteUtils.getNoteAtFret('E', 3), 'G');
      // 1弦空弦是E，12品=E（高八度）
      expect(NoteUtils.getNoteAtFret('E', 12), 'E');
    });

    test('getNoteAtFret handles sharps', () {
      // 6弦2品=F#
      expect(NoteUtils.getNoteAtFret('E', 2), 'F#');
      // 5弦空弦A，4品=C#
      expect(NoteUtils.getNoteAtFret('A', 4), 'C#');
    });

    test('isNaturalNote returns true for natural notes', () {
      expect(NoteUtils.isNaturalNote('C'), true);
      expect(NoteUtils.isNaturalNote('D'), true);
      expect(NoteUtils.isNaturalNote('F#'), false);
      expect(NoteUtils.isNaturalNote('A#'), false);
    });

    test('getFretboardNotes returns 6xN grid', () {
      final notes = NoteUtils.getFretboardNotes(
        ['E', 'B', 'G', 'D', 'A', 'E'],
        maxFrets: 12,
      );

      expect(notes.length, 6);
      expect(notes[0].length, 13); // 0-12品 = 13个
      expect(notes[0][0], 'E');    // 1弦空弦
      expect(notes[5][0], 'E');    // 6弦空弦
    });
  });
}
