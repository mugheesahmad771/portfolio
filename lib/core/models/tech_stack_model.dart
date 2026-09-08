class TechStackItem {
  final String name;
  final String category;

  TechStackItem({
    required this.name,
    required this.category,
  });
}

class TechStack {
  static final List<String> coreStack = [
    'Flutter',
    'React',
    'TypeScript',
    'Node.js',
    'Firebase',
    'PostgreSQL',
    'REST APIs',
    'GraphQL',
  ];

  static final List<TechStackItem> fullStack = [
    TechStackItem(name: 'Flutter', category: 'Mobile'),
    TechStackItem(name: 'React', category: 'Frontend'),
    TechStackItem(name: 'TypeScript', category: 'Language'),
    TechStackItem(name: 'Node.js', category: 'Backend'),
    TechStackItem(name: 'Firebase', category: 'Backend'),
    TechStackItem(name: 'PostgreSQL', category: 'Database'),
    TechStackItem(name: 'REST APIs', category: 'Architecture'),
    TechStackItem(name: 'GraphQL', category: 'Architecture'),
  ];
}
