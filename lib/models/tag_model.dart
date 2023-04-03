class Tag {
  late int id;
  late String name;

  Tag();

  factory Tag.fromJson(Map<String, dynamic> json) {
    Tag tag = Tag();
    tag.id = json['id'];
    tag.name = json['name'];

    return tag;
  }
}
