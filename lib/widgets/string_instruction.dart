import 'package:flutter/material.dart';
import '../models/string_tuning.dart';
import '../utils/note_utils.dart';
import '../utils/constants.dart';

class StringInstruction extends StatelessWidget {
  final StringTuning stringTuning;
  final int index;

  const StringInstruction({
    super.key,
    required this.stringTuning,
    required this.index,
  });

  @override
  String _getInstructionText(String locale) {
    final capo = stringTuning.capoFret;
    final ref = stringTuning.referenceString;
    if (locale == 'zh') {
      if (capo == 0) {
        return '不用变调夹 → 调到${ref}弦标准音';
      } else {
        return '变调夹夹${capo}品 → 调到${ref}弦标准音';
      }
    } else {
      if (capo == 0) {
        return 'No capo → tune to string $ref standard';
      } else {
        return 'Capo fret $capo → tune to string $ref standard';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStandard = stringTuning.isStandard;
    final openNote = AppConstants.standardTuning[stringTuning.stringNumber - 1];
    final targetNote = isStandard
        ? openNote
        : NoteUtils.getNoteAtFret(
            AppConstants.standardTuning[stringTuning.referenceString - 1],
            stringTuning.capoFret,
          );
    final locale = Localizations.localeOf(context).languageCode;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + index * 100),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isStandard
                      ? Colors.green.withOpacity(0.2)
                      : Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${stringTuning.stringNumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isStandard ? Colors.green : Colors.amber,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                locale == 'zh'
                    ? '${stringTuning.stringNumber}弦'
                    : 'String ${stringTuning.stringNumber}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: isStandard
                    ? Text(
                        locale == 'zh'
                            ? '标准音 ($openNote)，不动'
                            : 'Standard ($openNote), no change',
                        style: TextStyle(color: Colors.green.shade300),
                      )
                    : Text(
                        _getInstructionText(locale),
                        style: const TextStyle(color: Colors.amber),
                      ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  targetNote,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
