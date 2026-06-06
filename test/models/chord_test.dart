import 'package:flutter_test/flutter_test.dart';
import 'package:tunemate/models/chord.dart';

void main() {
  group('Chord', () {
    test('creates correctly', () {
      final chord = Chord(
        id: 'C_major',
        key: 'C',
        type: 'major',
        name: 'C',
        frets: [0, 1, 0, 2, 3, 0],
        fingers: [0, 1, 0, 2, 3, 0],
        baseFret: 1,
      );

      expect(chord.key, 'C');
      expect(chord.type, 'major');
      expect(chord.name, 'C');
      expect(chord.frets.length, 6);
    });

    test('displayName returns correct format', () {
      final major = Chord(
        id: 'C_major', key: 'C', type: 'major', name: 'C',
        frets: [], fingers: [], baseFret: 1,
      );
      expect(major.displayName, 'C');

      final minor = Chord(
        id: 'D_minor', key: 'D', type: 'minor', name: 'Dm',
        frets: [], fingers: [], baseFret: 1,
      );
      expect(minor.displayName, 'Dm');

      final seventh = Chord(
        id: 'G_7', key: 'G', type: '7', name: 'G7',
        frets: [], fingers: [], baseFret: 1,
      );
      expect(seventh.displayName, 'G7');
    });
  });
}
