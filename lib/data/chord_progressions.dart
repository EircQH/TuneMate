import '../models/chord.dart';

/// 和弦走向
class ChordProgression {
  final String name;       // 如 "1-6-4-5"
  final String nameZh;     // 如 "经典流行"
  final List<int> degrees; // 如 [1, 6, 4, 5]
  final List<String> exampleSongs; // 代表曲目
  final Map<String, List<String>> chordNamesByKey; // 各调式对应的和弦名

  const ChordProgression({
    required this.name,
    required this.nameZh,
    required this.degrees,
    this.exampleSongs = const [],
    this.chordNamesByKey = const {},
  });

  /// 根据调式获取实际和弦名称
  List<String> getChordNames(String key) {
    return chordNamesByKey[key] ?? [];
  }

  /// 根据调式获取实际和弦（从已有数据中查找）
  List<Chord?> getChords(String key, List<Chord> allChords) {
    final names = getChordNames(key);
    return names.map((name) {
      try {
        return allChords.firstWhere((c) => c.name == name);
      } catch (_) {
        return null;
      }
    }).toList();
  }
}

class ChordProgressions {
  // 1-6-4-5 经典流行
  static const _prog1645 = ChordProgression(
    name: '1-6-4-5',
    nameZh: '经典流行',
    degrees: [1, 6, 4, 5],
    exampleSongs: ['Let It Be', '童话', '好久不见'],
    chordNamesByKey: {
      'C': ['C', 'Am', 'F', 'G'],
      'D': ['D', 'Bm', 'G', 'A'],
      'E': ['E', 'C#m', 'A', 'B'],
      'F': ['F', 'Dm', 'Bb', 'C'],
      'G': ['G', 'Em', 'C', 'D'],
      'A': ['A', 'F#m', 'D', 'E'],
      'B': ['B', 'G#m', 'E', 'F#'],
    },
  );

  // 1-5-6-4 万能走向
  static const _prog1564 = ChordProgression(
    name: '1-5-6-4',
    nameZh: '万能走向',
    degrees: [1, 5, 6, 4],
    exampleSongs: ['Someone Like You', '平凡之路', '小幸运'],
    chordNamesByKey: {
      'C': ['C', 'G', 'Am', 'F'],
      'D': ['D', 'A', 'Bm', 'G'],
      'E': ['E', 'B', 'C#m', 'A'],
      'F': ['F', 'C', 'Dm', 'Bb'],
      'G': ['G', 'D', 'Em', 'C'],
      'A': ['A', 'E', 'F#m', 'D'],
      'B': ['B', 'F#', 'G#m', 'E'],
    },
  );

  // 4-5-3-6 卡农变体
  static const _prog4536 = ChordProgression(
    name: '4-5-3-6',
    nameZh: '卡农变体',
    degrees: [4, 5, 3, 6],
    exampleSongs: ['Canon in D', '征服', '匆匆那年'],
    chordNamesByKey: {
      'C': ['F', 'G', 'Em', 'Am'],
      'D': ['G', 'A', 'F#m', 'Bm'],
      'E': ['A', 'B', 'G#m', 'C#m'],
      'F': ['Bb', 'C', 'Dm', 'Dm'],
      'G': ['C', 'D', 'Em', 'Em'],
      'A': ['D', 'E', 'C#m', 'F#m'],
      'B': ['E', 'F#', 'D#m', 'G#m'],
    },
  );

  // 1-4-5-1 基础摇滚
  static const _prog1451 = ChordProgression(
    name: '1-4-5-1',
    nameZh: '基础摇滚',
    degrees: [1, 4, 5, 1],
    exampleSongs: ['Twist and Shout', 'Rock Around the Clock'],
    chordNamesByKey: {
      'C': ['C', 'F', 'G', 'C'],
      'D': ['D', 'G', 'A', 'D'],
      'E': ['E', 'A', 'B', 'E'],
      'F': ['F', 'Bb', 'C', 'F'],
      'G': ['G', 'C', 'D', 'G'],
      'A': ['A', 'D', 'E', 'A'],
      'B': ['B', 'E', 'F#', 'B'],
    },
  );

  // 6-4-1-5 抒情走向
  static const _prog6415 = ChordProgression(
    name: '6-4-1-5',
    nameZh: '抒情走向',
    degrees: [6, 4, 1, 5],
    exampleSongs: ['夜曲', '说好的幸福', '蒲公英的约定'],
    chordNamesByKey: {
      'C': ['Am', 'F', 'C', 'G'],
      'D': ['Bm', 'G', 'D', 'A'],
      'E': ['C#m', 'A', 'E', 'B'],
      'F': ['Dm', 'Bb', 'F', 'C'],
      'G': ['Em', 'C', 'G', 'D'],
      'A': ['F#m', 'D', 'A', 'E'],
      'B': ['G#m', 'E', 'B', 'F#'],
    },
  );

  // 1-6-2-5 爵士经典
  static const _prog1625 = ChordProgression(
    name: '1-6-2-5',
    nameZh: '爵士经典',
    degrees: [1, 6, 2, 5],
    exampleSongs: ['Fly Me to the Moon', 'Autumn Leaves'],
    chordNamesByKey: {
      'C': ['C', 'Am', 'Dm', 'G'],
      'D': ['D', 'Bm', 'Em', 'A'],
      'E': ['E', 'C#m', 'F#m', 'B'],
      'F': ['F', 'Dm', 'Gm', 'C'],
      'G': ['G', 'Em', 'Am', 'D'],
      'A': ['A', 'F#m', 'Bm', 'E'],
      'B': ['B', 'G#m', 'C#m', 'F#'],
    },
  );

  static const List<ChordProgression> progressions = [
    _prog1645,
    _prog1564,
    _prog4536,
    _prog1451,
    _prog6415,
    _prog1625,
  ];
}
