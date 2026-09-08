class StatsModel {
  final String value;
  final String label;

  StatsModel({
    required this.value,
    required this.label,
  });

  factory StatsModel.demo(int index) {
    final statsList = [
      StatsModel(value: '50+', label: 'Projects Completed'),
      StatsModel(value: '8+', label: 'Years Experience'),
      StatsModel(value: '100%', label: 'Client Satisfaction'),
      StatsModel(value: '15+', label: 'Technologies'),
    ];
    return statsList[index % statsList.length];
  }
}
