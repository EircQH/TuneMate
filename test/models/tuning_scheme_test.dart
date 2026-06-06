import 'package:flutter_test/flutter_test.dart';
import 'package:tunemate/models/string_tuning.dart';
import 'package:tunemate/models/tuning_scheme.dart';

void main() {
  group('StringTuning', () {
    test('standard string tuning creates correctly', () {
      final tuning = StringTuning(
        stringNumber: 1,
        capoFret: 0,
        referenceString: 1,
      );

      expect(tuning.stringNumber, 1);
      expect(tuning.capoFret, 0);
      expect(tuning.referenceString, 1);
      expect(tuning.isStandard, true);
    });

    test('capo tuning creates correctly', () {
      final tuning = StringTuning(
        stringNumber: 6,
        capoFret: 4,
        referenceString: 6,
      );

      expect(tuning.stringNumber, 6);
      expect(tuning.capoFret, 4);
      expect(tuning.referenceString, 6);
      expect(tuning.isStandard, false);
    });

    test('toMap and fromMap roundtrip', () {
      final tuning = StringTuning(
        stringNumber: 3,
        capoFret: 2,
        referenceString: 5,
      );

      final map = tuning.toMap();
      final restored = StringTuning.fromMap(map);

      expect(restored.stringNumber, tuning.stringNumber);
      expect(restored.capoFret, tuning.capoFret);
      expect(restored.referenceString, tuning.referenceString);
    });
  });

  group('TuningScheme', () {
    test('creates with all fields', () {
      final scheme = TuningScheme(
        id: 'low-c',
        nameZh: 'Low C',
        nameEn: 'Low C',
        isBuiltIn: true,
        isFavorite: false,
        strings: [
          const StringTuning(stringNumber: 1, capoFret: 2, referenceString: 1),
          const StringTuning(stringNumber: 2, capoFret: 2, referenceString: 2),
          const StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
          const StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
          const StringTuning(stringNumber: 5, capoFret: 2, referenceString: 5),
          const StringTuning(stringNumber: 6, capoFret: 4, referenceString: 6),
        ],
      );

      expect(scheme.id, 'low-c');
      expect(scheme.strings.length, 6);
      expect(scheme.isBuiltIn, true);
    });

    test('copyWith updates fields', () {
      final scheme = TuningScheme(
        id: 'test',
        nameZh: '测试',
        nameEn: 'Test',
        isBuiltIn: false,
        isFavorite: false,
        strings: [],
      );

      final updated = scheme.copyWith(isFavorite: true);
      expect(updated.isFavorite, true);
      expect(updated.id, 'test');
    });

    test('toMap and fromMap roundtrip', () {
      final scheme = TuningScheme(
        id: 'drop-d',
        nameZh: 'Drop D',
        nameEn: 'Drop D',
        isBuiltIn: true,
        isFavorite: true,
        strings: [
          const StringTuning(stringNumber: 1, capoFret: 0, referenceString: 1),
          const StringTuning(stringNumber: 2, capoFret: 0, referenceString: 2),
          const StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
          const StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
          const StringTuning(stringNumber: 5, capoFret: 0, referenceString: 5),
          const StringTuning(stringNumber: 6, capoFret: 0, referenceString: 6),
        ],
      );

      final map = scheme.toMap();
      final restored = TuningScheme.fromMap(map);

      expect(restored.id, scheme.id);
      expect(restored.nameZh, scheme.nameZh);
      expect(restored.isFavorite, scheme.isFavorite);
      expect(restored.strings.length, 6);
    });
  });
}
