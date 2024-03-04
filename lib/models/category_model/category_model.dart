import '../product_model/product_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final int? position;
  final List<ProductModel> products;

  CategoryModel({
    required this.id,
    required this.name,
    this.position = 0,
    this.products = const <ProductModel>[],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    final position = data['position'] as int?;

    return CategoryModel(
      id: id,
      name: name,
      position: position,
    );
  }

  CategoryModel copyWith({
    int? id,
    String? name,
    int? position,
    List<ProductModel>? products,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      products: products ?? this.products,
    );
  }
}
