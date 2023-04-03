class Category {
  late int id;
  late String name;

  Category();

  factory Category.fromJson(Map<String, dynamic> json) {
    Category category = Category();
    category.id = json['id'];
    category.name = json['name'];

    return category;
  }
}
