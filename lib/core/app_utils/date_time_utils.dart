import 'package:easy_localization/easy_localization.dart';

class DateTimeUtils {
  static String fromIso8601(String? isoDate,
      {String targetFormat = 'dd/MM/yyyy'}) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      final newFormat = DateFormat(targetFormat);
      return newFormat.format(dateTime);
    } catch (_) {
      return '';
    }
  }

  static String fromDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    try {
      final newFormat = DateFormat('dd/MM/yyyy');
      return newFormat.format(dateTime);
    } catch (_) {
      return '';
    }
  }
}