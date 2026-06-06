import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fretboard_provider.dart';
import '../providers/tuning_provider.dart';
import '../widgets/fretboard_grid.dart';

class FretboardScreen extends StatelessWidget {
  const FretboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TuningProvider, FretboardProvider>(
      builder: (context, tuningProvider, fretboardProvider, child) {
        final tuning = tuningProvider.selectedTuning;
        final tuningId = tuning?.id ?? 'standard';
        if (fretboardProvider.currentTuningId != tuningId || fretboardProvider.notes.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            fretboardProvider.updateForTuning(tuning);
          });
        }

        final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
        final tuningName = tuningProvider.selectedTuning?.getName(
          Localizations.localeOf(context).languageCode,
        ) ?? 'Standard';

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 竖屏：完整顶栏 | 横屏：仅品数选择器
              if (!isLandscape) ...[
                SizedBox(
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          Localizations.localeOf(context).languageCode == 'zh'
                              ? '当前调弦：'
                              : 'Current tuning: ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          tuningName,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        _buildFretSelector(context, fretboardProvider, tuningProvider),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1),
                // 竖屏提示
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.screen_rotation, size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        Localizations.localeOf(context).languageCode == 'zh'
                            ? '横屏可查看完整指板'
                            : 'Rotate for full fretboard view',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // 横屏：紧凑顶栏，节省纵向空间
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        tuningName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      _buildFretSelector(context, fretboardProvider, tuningProvider),
                    ],
                  ),
                ),
              ],
              // 指板区域
              Expanded(
                child: FretboardGrid(
                  notes: fretboardProvider.notes,
                  compact: isLandscape,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFretSelector(
    BuildContext context,
    FretboardProvider fretboardProvider,
    TuningProvider tuningProvider,
  ) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        fretboardProvider.setMaxFrets(value);
        fretboardProvider.updateForTuning(tuningProvider.selectedTuning);
      },
      itemBuilder: (context) => [12, 15, 18, 21].map((f) {
        return PopupMenuItem<int>(
          value: f,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$f 品'),
              if (f == fretboardProvider.maxFrets) ...[
                const SizedBox(width: 8),
                Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary),
              ],
            ],
          ),
        );
      }).toList(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${fretboardProvider.maxFrets} 品',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }
}
