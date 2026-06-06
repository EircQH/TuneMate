// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'TuneMate';

  @override
  String get tuningTab => '特调';

  @override
  String get fretboardTab => '指板';

  @override
  String get chordTab => '和弦';

  @override
  String get settings => '设置';

  @override
  String get darkMode => '深色模式';

  @override
  String get language => '语言';

  @override
  String get about => '关于';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get favorite => '收藏';

  @override
  String get customTuning => '自定义特调';

  @override
  String get standardTuning => '标准调弦';

  @override
  String get capoFret => '变调夹';

  @override
  String get referenceString => '调到弦';

  @override
  String get fret => '品';

  @override
  String get none => '不用';

  @override
  String get currentTuning => '当前调弦';

  @override
  String get fingerstyleHelper => '专为指弹玩家设计';

  @override
  String get version => '版本';
}
