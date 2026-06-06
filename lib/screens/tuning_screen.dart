import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tuning_provider.dart';
import '../widgets/tuning_card.dart';
import 'tuning_detail_screen.dart';
import 'tuning_form_screen.dart';

class TuningScreen extends StatelessWidget {
  const TuningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isZh = Localizations.localeOf(context).languageCode == 'zh';

    return Consumer<TuningProvider>(
      builder: (context, provider, child) {
        final tunings = provider.tunings;

        if (tunings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: tunings.length,
          itemBuilder: (context, index) {
            final tuning = tunings[index];
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 300 + index * 50),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: TuningCard(
                tuning: tuning,
                isSelected: provider.selectedTuning?.id == tuning.id,
                onTap: () {
                  provider.selectTuning(tuning);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TuningDetailScreen(tuning: tuning),
                    ),
                  );
                },
                onFavoriteToggle: () => provider.toggleFavorite(tuning),
              ),
            );
          },
        ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TuningFormScreen(),
                    ),
                  );
                },
                tooltip: isZh ? '添加自定义特调' : 'Add Custom Tuning',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}
