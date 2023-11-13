class Statistic_Daily {
  final DateTime date;
  final int duration;

  Statistic_Daily(this.date, this.duration);
}

class Statistic_Monthly {
  final DateTime month;
  final int duration;

  Statistic_Monthly(this.month, this.duration);
}

List<Statistic_Daily> listDaily = [
  Statistic_Daily(DateTime(2023, 10, 1), 4),
  Statistic_Daily(DateTime(2023, 10, 2), 5),
  Statistic_Daily(DateTime(2023, 10, 3), 9),
  Statistic_Daily(DateTime(2023, 10, 4), 2),
  Statistic_Daily(DateTime(2023, 10, 5), 3),
  Statistic_Daily(DateTime(2023, 10, 6), 1),
  Statistic_Daily(DateTime(2023, 10, 7), 8),
  Statistic_Daily(DateTime(2023, 10, 8), 7),
  Statistic_Daily(DateTime(2023, 10, 9), 5),
  Statistic_Daily(DateTime(2023, 10, 10), 3),
  Statistic_Daily(DateTime(2023, 10, 11), 3),
  Statistic_Daily(DateTime(2023, 10, 12), 3),
  Statistic_Daily(DateTime(2023, 10, 13), 3),
  Statistic_Daily(DateTime(2023, 10, 14), 3),
];

List<Statistic_Monthly> listMonthly = [
  Statistic_Monthly(DateTime(2023, 1), 26),
  Statistic_Monthly(DateTime(2023, 2), 20),
  Statistic_Monthly(DateTime(2023, 3), 11),
  Statistic_Monthly(DateTime(2023, 4), 50),
  Statistic_Monthly(DateTime(2023, 5), 30),
  Statistic_Monthly(DateTime(2023, 6), 24),
  Statistic_Monthly(DateTime(2023, 7), 26),
  Statistic_Monthly(DateTime(2023, 8), 27),
  Statistic_Monthly(DateTime(2023, 9), 29),
];
