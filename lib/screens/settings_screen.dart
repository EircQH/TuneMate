import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Localizations.localeOf(context).languageCode == 'zh' ? '设置' : 'Settings',
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              _buildSection(
                context,
                title: Localizations.localeOf(context).languageCode == 'zh' ? '外观' : 'Appearance',
                children: [
                  SwitchListTile(
                    title: Text(
                      Localizations.localeOf(context).languageCode == 'zh' ? '深色模式' : 'Dark Mode',
                    ),
                    subtitle: Text(
                      settings.themeMode == ThemeMode.dark
                          ? (Localizations.localeOf(context).languageCode == 'zh' ? '已开启' : 'On')
                          : (Localizations.localeOf(context).languageCode == 'zh' ? '已关闭' : 'Off'),
                    ),
                    value: settings.themeMode == ThemeMode.dark,
                    onChanged: (_) => settings.toggleTheme(),
                    secondary: Icon(
                      settings.themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                  ),
                ],
              ),
              _buildSection(
                context,
                title: Localizations.localeOf(context).languageCode == 'zh' ? '语言' : 'Language',
                children: [
                  RadioListTile<Locale>(
                    title: const Text('中文'),
                    value: const Locale('zh', 'CN'),
                    groupValue: settings.locale,
                    onChanged: (locale) {
                      if (locale != null) settings.setLocale(locale);
                    },
                  ),
                  RadioListTile<Locale>(
                    title: const Text('English'),
                    value: const Locale('en', 'US'),
                    groupValue: settings.locale,
                    onChanged: (locale) {
                      if (locale != null) settings.setLocale(locale);
                    },
                  ),
                ],
              ),
              _buildSection(
                context,
                title: Localizations.localeOf(context).languageCode == 'zh' ? '关于' : 'About',
                children: [
                  const ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('@EircZ'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('TuneMate'),
                    subtitle: Text(
                      Localizations.localeOf(context).languageCode == 'zh'
                          ? '吉他特调助手 v1.0.0'
                          : 'Guitar Tuning Helper v1.0.0',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_outline),
                    title: Text(
                      Localizations.localeOf(context).languageCode == 'zh'
                          ? '专为指弹玩家设计'
                          : 'Designed for fingerstyle players',
                    ),
                  ),
                ],
              ),
              _buildSection(
                context,
                title: Localizations.localeOf(context).languageCode == 'zh'
                    ? '开发者鸣谢 | 使用协议'
                    : 'Credits | Terms of Use',
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Text(
                      'Copyright©2026 6/6-6/7 All Rights Reserved',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    child: Text(
                      '特别感谢：@EircZ  @Claude Code  @Xiaomi MiMo-V2.5-Pro  @CC Switch  @豆包',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
