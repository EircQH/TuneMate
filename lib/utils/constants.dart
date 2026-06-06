// lib/utils/constants.dart
class AppConstants {
  static const String appName = 'TuneMate';
  static const int maxFrets = 15;
  static const int stringCount = 6;

  // 标准调弦音名（从1弦到6弦）
  static const List<String> standardTuning = ['E', 'B', 'G', 'D', 'A', 'E'];

  // 所有音名（半音阶）
  static const List<String> allNotes = [
    'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
  ];

  // 自然音（无升降号）
  static const List<String> naturalNotes = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
}
