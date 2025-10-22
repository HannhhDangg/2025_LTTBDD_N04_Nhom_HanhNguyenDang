// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Todo App';

  @override
  String get homeTitle => 'TASKS';

  @override
  String get infoTitle => 'GROUP INFO';

  @override
  String get emptyList => 'No tasks yet, start planning your day!';

  @override
  String get tabHome => 'Home';

  @override
  String get tabInfo => 'Team Info';

  @override
  String get addTaskTitle => 'Add New Task';

  @override
  String get addTaskHint => 'Enter a task...';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';
}
