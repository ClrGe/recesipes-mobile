class Category {
  int id;
  String type;
  String subtype1;
  String subtype2;

  Category({
    required this.id,
    required this.type,
    required this.subtype1,
    required this.subtype2,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      type: json['type'],
      subtype1: json['subtype1'],
      subtype2: json['subtype2'],
    );
  }
}
