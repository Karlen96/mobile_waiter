class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int categoryId;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    final description = data['description'] as String;
    final price = data['price'] as double;
    final categoryId = data['category_id'] as int;

    return ProductModel(
      id: id,
      name: name,
      price: price,
      description: description,
      categoryId: categoryId,
    );
  }
}
