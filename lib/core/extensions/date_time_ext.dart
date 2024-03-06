extension DateTimeExt on DateTime {
  String toFormattedTime() {
    final List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];

    final String monthName = monthNames[month - 1];

    return '$day $monthName ${year.toString()}, ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
