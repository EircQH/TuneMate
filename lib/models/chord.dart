class Chord {
  final String id;
  final String key;   // C/D/E/F/G/A/B
  final String type;  // major/minor/7/maj7/min7/dim/aug
  final String name;  // 如 "Cm", "G7"
  final List<int> frets;   // 6根弦的品位，0=空弦，-1=不弹
  final List<int> fingers; // 6根弦的手指编号，0=不按
  final int baseFret;      // 起始品位

  Chord({
    required this.id,
    required this.key,
    required this.type,
    required this.name,
    required this.frets,
    required this.fingers,
    required this.baseFret,
  }) : assert(frets.length == 6, 'frets must have exactly 6 elements'),
       assert(fingers.length == 6, 'fingers must have exactly 6 elements'),
       assert(baseFret >= 1, 'baseFret must be >= 1');

  String get displayName => name;

  String get typeDisplayName {
    switch (type) {
      case 'major': return '';
      case 'minor': return 'm';
      case '7': return '7';
      case 'maj7': return 'maj7';
      case 'min7': return 'm7';
      case 'dim': return 'dim';
      case 'aug': return 'aug';
      default: return type;
    }
  }

  String get typeDisplayNameCN {
    switch (type) {
      case 'major': return '大三和弦';
      case 'minor': return '小三和弦';
      case '7': return '属七和弦';
      case 'maj7': return '大七和弦';
      case 'min7': return '小七和弦';
      case 'dim': return '减和弦';
      case 'aug': return '增和弦';
      default: return type;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Chord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          key == other.key &&
          type == other.type &&
          name == other.name &&
          _listEquals(frets, other.frets) &&
          _listEquals(fingers, other.fingers) &&
          baseFret == other.baseFret;

  @override
  int get hashCode => Object.hash(id, key, type, name, baseFret);

  static bool _listEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
