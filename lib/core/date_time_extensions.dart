extension DateTimeExtensions on DateTime {
  static const List<String> _weekdays = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  ];

  String toRusString() {
    return '$day ${_weekdays[month - 1]} $year';
  }

  String toEljurDate() {
    return '$year${month.toString().padLeft(2, '0')}${day.toString().padLeft(2, '0')}';
  }
}
