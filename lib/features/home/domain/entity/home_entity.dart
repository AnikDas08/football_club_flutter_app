class HomeEntity {
  final int sessionsCount;
  final int goalsCount;
  final int assistsCount;
  final int potmCount;
  final String playerName;
  final String playerLevel;

  const HomeEntity({
    this.sessionsCount = 42,
    this.goalsCount = 18,
    this.assistsCount = 11,
    this.potmCount = 4,
    this.playerName = 'James Thornton',
    this.playerLevel = 'Advanced',
  });
}
