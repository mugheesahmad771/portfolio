class StatsModel {
  final String value;
  final String label;

  StatsModel({required this.value, required this.label});

  factory StatsModel.demo(int index) {
    return all[index % all.length];
  }

  static final List<StatsModel> all = [
    StatsModel(value: '3+', label: 'Years Experience'),
    StatsModel(value: 'iOS & Android', label: 'Published to Stores'),
    StatsModel(value: 'Full-Stack', label: 'Mobile + Web + API'),
    StatsModel(value: 'AI/ML', label: 'AI-Enabled Solutions'),
  ];
}
