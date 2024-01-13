class DaysRange {
  final int before, after;

  DaysRange({required this.before, required this.after});
}

class DiaryRepositorySettings {
  final DaysRange? downloadDays;

  DiaryRepositorySettings({required this.downloadDays});
}