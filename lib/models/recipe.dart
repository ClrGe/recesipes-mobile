class Recipe {
  int id;
  int userId;
  int guestsNumber;
  String description;
  String name;
  String pricing;
  String categoryId;
  String difficulty;
  int cookDuration;
  int preparationDuration;
  int restingDuration;
  String publishedTime;

  Recipe({
    required this.id,
    required this.name,
    required this.guestsNumber,
    required this.description,
    required this.difficulty,
    required this.pricing,
    required this.categoryId,
    required this.cookDuration,
    required this.preparationDuration,
    required this.restingDuration,
    required this.publishedTime,
    required this.userId,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      guestsNumber: json['guest_number'],
      description: json['description'],
      difficulty: json['difficulty'],
      pricing: json['price_range'],
      categoryId: '${json['category_id']}',
      cookDuration: json['cook_duration'],
      preparationDuration: json['preparation_duration'],
      restingDuration: json['resting_duration'],
      publishedTime: '${json['published_time']}',
      userId: json['user_id'],
    );
  }
}
