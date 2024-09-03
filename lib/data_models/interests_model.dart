import 'package:flutter/foundation.dart';

@immutable
class Interest {
  final String id;
  final String name;
  final Category category;

  const Interest({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json['interest_id'],
        name: json['interest_name'],
        category: Category(
          id: json['category_id'],
          name: json['category_name'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'interest_id': id,
        'interest_name': name,
        'category_id': category.id,
        'category_name': category.name,
      };

  Interest copyWith({
    String? id,
    String? name,
    Category? category,
  }) =>
      Interest(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
      );
}

@immutable
class Category {
  final String id;
  final String name;

  const Category({required this.id, required this.name});

  Category copyWith({String? id, String? name}) =>
      Category(id: id ?? this.id, name: name ?? this.name);
}
