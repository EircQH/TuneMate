import '../models/tuning_scheme.dart';
import '../models/string_tuning.dart';

class BuiltInTunings {
  static const List<TuningScheme> tunings = [
    // Standard
    const TuningScheme(
      id: 'standard',
      nameZh: '标准调弦',
      nameEn: 'Standard',
      descriptionZh: '代表曲：Romance de Amor',
      descriptionEn: '代表曲：Romance de Amor',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 0, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 0, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 0, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 0, referenceString: 6),
      ],
    ),
    // Drop D
    const TuningScheme(
      id: 'drop-d',
      nameZh: 'Drop D',
      nameEn: 'Drop D',
      descriptionZh: '代表曲：Everlong',
      descriptionEn: '代表曲：Everlong',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 0, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 0, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 0, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 0, referenceString: 4),
      ],
    ),
    // DADGAD
    const TuningScheme(
      id: 'dadgad',
      nameZh: 'DADGAD',
      nameEn: 'DADGAD',
      descriptionZh: '代表曲：Kashmir',
      descriptionEn: '代表曲：Kashmir',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 2, capoFret: 0, referenceString: 5),
        StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 0, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 0, referenceString: 4),
      ],
    ),
    // CGDGAD → Low C
    const TuningScheme(
      id: 'cgdgad',
      nameZh: 'Low C',
      nameEn: 'Low C',
      descriptionZh: '代表曲：Like a Star',
      descriptionEn: '代表曲：Like a Star',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 2, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 2, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 2, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 4, referenceString: 6),
      ],
    ),
    // Open D
    const TuningScheme(
      id: 'open-d',
      nameZh: 'Open D',
      nameEn: 'Open D',
      descriptionZh: '代表曲：Big Yellow Taxi',
      descriptionEn: '代表曲：Big Yellow Taxi',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 2, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 2, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 1, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 0, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 2, referenceString: 6),
      ],
    ),
    // Open G
    const TuningScheme(
      id: 'open-g',
      nameZh: 'Open G',
      nameEn: 'Open G',
      descriptionZh: '代表曲：Jumpin\' Jack Flash',
      descriptionEn: '代表曲：Jumpin\' Jack Flash',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 2, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 0, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 0, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 0, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 2, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 2, referenceString: 6),
      ],
    ),
    // Drop C
    const TuningScheme(
      id: 'drop-c',
      nameZh: 'Drop C',
      nameEn: 'Drop C',
      descriptionZh: '代表曲：Toxicity',
      descriptionEn: '代表曲：Toxicity',
      isBuiltIn: true,
      isFavorite: false,
      strings: [
        StringTuning(stringNumber: 1, capoFret: 2, referenceString: 1),
        StringTuning(stringNumber: 2, capoFret: 2, referenceString: 2),
        StringTuning(stringNumber: 3, capoFret: 2, referenceString: 3),
        StringTuning(stringNumber: 4, capoFret: 2, referenceString: 4),
        StringTuning(stringNumber: 5, capoFret: 2, referenceString: 5),
        StringTuning(stringNumber: 6, capoFret: 4, referenceString: 6),
      ],
    ),
  ];
}
