// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Ứng dụng ghi chú';

  @override
  String get homeTitle => 'NHIỆM VỤ';

  @override
  String get infoTitle => 'THÔNG TIN NHÓM';

  @override
  String get emptyList => 'Chưa có công việc nào, lên lịch hôm nay thôi nào!';

  @override
  String get tabHome => 'Trang chủ';

  @override
  String get tabInfo => 'Thông tin nhóm';

  @override
  String get addTaskTitle => 'Thêm nhiệm vụ mới';

  @override
  String get addTaskHint => 'Thêm nhiệm vụ...';

  @override
  String get cancel => 'Huỷ';

  @override
  String get save => 'Lưu';
}
