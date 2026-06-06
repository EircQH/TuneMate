import 'string_tuning.dart';

class TuningScheme {
  final String id;
  final String nameZh;
  final String nameEn;
  final String descriptionZh;
  final String descriptionEn;
  final bool isBuiltIn;
  final bool isFavorite;
  final List<StringTuning> strings;

  const TuningScheme({
    required this.id,
    required this.nameZh,
    required this.nameEn,
    this.descriptionZh = '',
    this.descriptionEn = '',
    required this.isBuiltIn,
    required this.isFavorite,
    required this.strings,
  });

  String getName(String locale) => locale.startsWith('zh') ? nameZh : nameEn;
  String getDescription(String locale) => locale.startsWith('zh') ? descriptionZh : descriptionEn;

  TuningScheme copyWith({
    String? id,
    String? nameZh,
    String? nameEn,
    String? descriptionZh,
    String? descriptionEn,
    bool? isBuiltIn,
    bool? isFavorite,
    List<StringTuning>? strings,
  }) {
    return TuningScheme(
      id: id ?? this.id,
      nameZh: nameZh ?? this.nameZh,
      nameEn: nameEn ?? this.nameEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isFavorite: isFavorite ?? this.isFavorite,
      strings: strings ?? this.strings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameZh': nameZh,
      'nameEn': nameEn,
      'descriptionZh': descriptionZh,
      'descriptionEn': descriptionEn,
      'isBuiltIn': isBuiltIn ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
      'strings': strings.map((s) => s.toMap()).toList(),
    };
  }

  factory TuningScheme.fromMap(Map<String, dynamic> map) {
    return TuningScheme(
      id: map['id'] as String,
      nameZh: map['nameZh'] as String,
      nameEn: map['nameEn'] as String,
      descriptionZh: (map['descriptionZh'] as String?) ?? '',
      descriptionEn: (map['descriptionEn'] as String?) ?? '',
      isBuiltIn: (map['isBuiltIn'] as int) == 1,
      isFavorite: (map['isFavorite'] as int) == 1,
      strings: (map['strings'] as List)
          .map((s) => StringTuning.fromMap(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
