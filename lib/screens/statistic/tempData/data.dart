class Statistic_Daily {
  final String date;
  final int duration;

  Statistic_Daily(this.date, this.duration);
}

class Statistic_Monthly {
  final String month;
  final int duration;

  Statistic_Monthly(this.month, this.duration);
}

List<Statistic_Daily> listDaily = [
  Statistic_Daily("10/1", 4),
  Statistic_Daily("10/2", 5),
  Statistic_Daily("10/3", 6),
  Statistic_Daily("10/4", 2),
  Statistic_Daily("10/4", 1),
  Statistic_Daily("10/4", 5),
];

List<Statistic_Monthly> listMonthly = [
  Statistic_Monthly("Jan", 23),
  Statistic_Monthly("Feb", 20),
  Statistic_Monthly("Mar", 16),
];
