import 'package:flutter/material.dart';
import '../models/tuning_scheme.dart';

class TuningCard extends StatelessWidget {
  final TuningScheme tuning;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const TuningCard({
    super.key,
    required this.tuning,
    required this.isSelected,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tuning.getName(Localizations.localeOf(context).languageCode),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tuning.getDescription(Localizations.localeOf(context).languageCode),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  tuning.isFavorite ? Icons.star : Icons.star_border,
                  color: tuning.isFavorite ? Colors.amber : Colors.grey,
                ),
                onPressed: onFavoriteToggle,
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  String _getDescription(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final capoStrings = tuning.strings.where((s) => s.capoFret > 0).toList();
    if (capoStrings.isEmpty) {
      return locale == 'zh' ? '标准调弦' : 'Standard tuning';
    }
    final maxCapo = capoStrings.map((s) => s.capoFret).reduce((a, b) => a > b ? a : b);
    return locale == 'zh' ? '变调夹最高${maxCapo}品' : 'Capo up to fret $maxCapo';
  }
}
