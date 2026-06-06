import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tuning_scheme.dart';
import '../providers/tuning_provider.dart';
import '../widgets/string_instruction.dart';

class TuningDetailScreen extends StatelessWidget {
  final TuningScheme tuning;

  const TuningDetailScreen({super.key, required this.tuning});

  void _confirmDelete(BuildContext context) {
    final isZh = Localizations.localeOf(context).languageCode == 'zh';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isZh ? '确认删除' : 'Confirm Delete'),
        content: Text(
          isZh
              ? '确定要删除方案 "${tuning.nameEn}" 吗？此操作不可撤销。'
              : 'Delete tuning "${tuning.nameEn}"? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(isZh ? '取消' : 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // 关闭弹窗
              context.read<TuningProvider>().deleteCustomTuning(tuning.id);
              Navigator.of(context).pop(); // 返回列表
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(isZh ? '删除' : 'Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final isZh = langCode == 'zh';

    return Scaffold(
      appBar: AppBar(
        title: Text(tuning.getName(langCode)),
        actions: [
          // 收藏按钮
          Consumer<TuningProvider>(
            builder: (context, provider, child) {
              final currentTuning = provider.tunings.firstWhere(
                (t) => t.id == tuning.id,
                orElse: () => tuning,
              );
              return IconButton(
                icon: Icon(
                  currentTuning.isFavorite ? Icons.star : Icons.star_border,
                  color: currentTuning.isFavorite ? Colors.amber : null,
                ),
                onPressed: () => provider.toggleFavorite(currentTuning),
              );
            },
          ),
          // 删除按钮（仅自定义特调显示）
          if (!tuning.isBuiltIn)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              tooltip: isZh ? '删除方案' : 'Delete',
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                children: [
                  Text(
                    tuning.getName(langCode),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tuning.getDescription(langCode),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isZh ? '使用变调夹 + 标准音调弦'
                        : 'Tune using capo + standard pitch',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => StringInstruction(
                stringTuning: tuning.strings[index],
                index: index,
              ),
              childCount: tuning.strings.length,
            ),
          ),
        ],
      ),
    );
  }
}
