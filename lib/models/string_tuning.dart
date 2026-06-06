class StringTuning {
  final int stringNumber; // 1-6
  final int capoFret;     // 0=不用变调夹
  final int referenceString; // 对应哪根标准弦

  const StringTuning({
    required this.stringNumber,
    required this.capoFret,
    required this.referenceString,
  });

  bool get isStandard => capoFret == 0 && stringNumber == referenceString;

  Map<String, dynamic> toMap() {
    return {
      'stringNumber': stringNumber,
      'capoFret': capoFret,
      'referenceString': referenceString,
    };
  }

  factory StringTuning.fromMap(Map<String, dynamic> map) {
    return StringTuning(
      stringNumber: map['stringNumber'] as int,
      capoFret: map['capoFret'] as int,
      referenceString: map['referenceString'] as int,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringTuning &&
          runtimeType == other.runtimeType &&
          stringNumber == other.stringNumber &&
          capoFret == other.capoFret &&
          referenceString == other.referenceString;

  @override
  int get hashCode => stringNumber.hashCode ^ capoFret.hashCode ^ referenceString.hashCode;
}
