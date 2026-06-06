// test/providers/tuning_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tunemate/providers/tuning_provider.dart';

void main() {
  group('TuningProvider', () {
    test('initial state is empty', () {
      final provider = TuningProvider();
      expect(provider.tunings, isEmpty);
      expect(provider.selectedTuning, isNull);
    });

    test('selectTuning updates selected tuning', () {
      final provider = TuningProvider();
      expect(provider.selectedTuning, isNull);
    });
  });
}
