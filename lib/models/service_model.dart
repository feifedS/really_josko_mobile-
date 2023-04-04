import 'dart:ffi';

import 'package:last/models/category_model.dart';
import 'package:last/models/tag_model.dart';

import 'api_models.dart';

class TypeOfService {
  late int id;
  late String name;
  late double price;
  late Category category;
  late String description;
  late List<Tag> tags;
  late Token? token;

  TypeOfService();
  factory TypeOfService.fromJson(Map<String, dynamic> json) {
    // print("VVVVVVVVVVVVVVVVVVVVVVVVVV ${json}");
    Category category = Category.fromJson(json['category']);

    List<Tag> tags = [];

    List<dynamic> tagsJson = json['tags'];

    tagsJson.forEach((element) {
      // print('RRRRRRRRRRRRRRRRRRRRRRR $element');
      Tag tag = Tag.fromJson(element);
      tags.add(tag);
    });

    TypeOfService typeOfService = TypeOfService();

    typeOfService.id = json['id'];
    typeOfService.name = json["name"];
    typeOfService.price = json["price"];
    typeOfService.description = json["description"];
    // typeOfService.tag
    typeOfService.tags = tags;
    typeOfService.category = category;

    return typeOfService;
  }
}
