class DaysRange {
  final int before, after;

  DaysRange({required this.before, required this.after});
}

class DiarySettings {
  final DaysRange? downloadDays;

  DiarySettings({required this.downloadDays});
}