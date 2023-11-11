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
  Statistic_Daily("10/1", 40),
  Statistic_Daily("10/2", 50),
  Statistic_Daily("10/3", 60),
  Statistic_Daily("10/4", 20),
  Statistic_Daily("10/4", 10),
  Statistic_Daily("10/4", 50),
];

List<Statistic_Monthly> listMonthly = [
  Statistic_Monthly("Jan", 260),
  Statistic_Monthly("Feb", 200),
  Statistic_Monthly("Mar", 160),
];
