// lib/utils/note_utils.dart
import 'constants.dart';

class NoteUtils {
  /// 根据空弦音和品位计算该位置的音名
  static String getNoteAtFret(String openNote, int fret) {
    final openIndex = AppConstants.allNotes.indexOf(openNote);
    if (openIndex == -1) return '?';
    final noteIndex = (openIndex + fret) % 12;
    return AppConstants.allNotes[noteIndex];
  }

  /// 判断是否为自然音（无升降号）
  static bool isNaturalNote(String note) {
    return AppConstants.naturalNotes.contains(note);
  }

  /// 获取整个指板的音名网格
  /// 返回 List<List<String>>，外层6根弦（1弦到6弦），内层各品位
  static List<List<String>> getFretboardNotes(
    List<String> openNotes, {
    int maxFrets = AppConstants.maxFrets,
  }) {
    return openNotes.map((openNote) {
      return List.generate(maxFrets + 1, (fret) => getNoteAtFret(openNote, fret));
    }).toList();
  }

  /// 根据特调方案计算6根弦的空弦音
  /// capoFret: 变调夹夹几品
  /// referenceString: 对应哪根标准弦（1-6）
  static String getOpenNoteForTuning({
    required int capoFret,
    required int referenceString,
  }) {
    if (referenceString < 1 || referenceString > 6) {
      throw ArgumentError('referenceString must be 1-6, got $referenceString');
    }
    if (capoFret < 0) {
      throw ArgumentError('capoFret must be >= 0, got $capoFret');
    }
    final standardNote = AppConstants.standardTuning[referenceString - 1];
    return getNoteAtFret(standardNote, capoFret);
  }
}
