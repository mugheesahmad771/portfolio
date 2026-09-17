class TechStackItem {
  final String name;
  final String category;

  TechStackItem({required this.name, required this.category});
}

class TechStack {
  static final List<String> coreStack = [
    'Flutter',
    'Dart',
    'GetX',
    'React Native',
    'Angular',
    'C# / ASP.NET Web API',
    'Firebase',
    'SQL Server',
    'SQLite',
    'REST APIs',
    'Git',
    'Postman',
  ];

  static final List<TechStackItem> fullStack = [
    TechStackItem(name: 'Flutter', category: 'Mobile'),
    TechStackItem(name: 'Dart', category: 'Mobile'),
    TechStackItem(name: 'GetX', category: 'Mobile'),
    TechStackItem(name: 'React Native', category: 'Mobile'),
    TechStackItem(name: 'Angular', category: 'Frontend'),
    TechStackItem(name: 'C# / ASP.NET Web API', category: 'Backend'),
    TechStackItem(name: 'Firebase', category: 'Cloud'),
    TechStackItem(name: 'SQL Server', category: 'Database'),
    TechStackItem(name: 'SQLite', category: 'Database'),
    TechStackItem(name: 'REST APIs', category: 'Architecture'),
    TechStackItem(name: 'Git', category: 'Tools'),
    TechStackItem(name: 'Postman', category: 'Tools'),
  ];
}
