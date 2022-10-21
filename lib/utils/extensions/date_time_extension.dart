import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  static DateTime nowUtc() => DateTime.now().toUtc();

  String formatDDMM({String? locale, bool convertToTimezone = true}) {
    return DateFormat('dd.MM', locale).format(this);
  }

  String formatDMMMM({String? locale, bool convertToTimezone = true}) {
    return DateFormat('d MMMM', locale).format(this);
  }

  String formatDMMYY({String? locale, bool convertToTimezone = true}) {
    return DateFormat('d.MM.yy', locale).format(this);
  }

  String formatDMMYYYY({String? locale, bool convertToTimezone = true}) {
    return DateFormat('d.MM.yyyy', locale).format(this);
  }

  String formatDDMMYYYYHHMM({String? locale, bool convertToTimezone = true}) {
    return DateFormat('d.MM.yyyy, HH:mm', locale).format(this);
  }

  String formatHHMM({String? locale, bool convertToTimezone = true}) {
    return DateFormat('HH:mm', locale).format(this);
  }

  String formatHHMMssSSS({String? locale, bool convertToTimezone = true}) {
    return DateFormat('HH:mm:ss.SSS', locale).format(this);
  }

  String formatWeekdayShort({String? locale, bool convertToTimezone = true}) {
    final weekdayShort = DateFormat('E', locale).format(this);

    return weekdayShort.replaceAll('.', '');
  }

  bool get isToday {
    final now = DateTime.now();

    return _isSameDate(now, this);
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return _isSameDate(tomorrow, this);
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    return _isSameDate(yesterday, this);
  }
}

bool _isSameDate(DateTime firstDate, DateTime secondDate) {
  return firstDate.day == secondDate.day &&
      firstDate.month == secondDate.month &&
      firstDate.year == secondDate.year;
}
