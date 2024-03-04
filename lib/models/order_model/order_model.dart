class OrderModel {
  final String id;
  final int productId;
  final String productName;
  final int tableId;
  final double productPrice;
  final int productCount;
  final String categoryName;
  final int categoryId;
  final int isFinished;

  OrderModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.tableId,
    required this.productCount,
    required this.categoryName,
    required this.categoryId,
    required this.isFinished,
  });

  factory OrderModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as String;
    final productId = data['product_id'] as int;
    final productName = data['product_name'] as String;
    final categoryName = data['category_name'] as String;
    final productPrice = data['product_price'] as double;
    final productCount = data['product_count'] as int;
    final tableId = data['table_id'] as int;
    final categoryId = data['category_id'] as int;
    final isFinished = data['isFinished'] as int;

    return OrderModel(
      id: id,
      productId: productId,
      productName: productName,
      categoryName: categoryName,
      productPrice: productPrice,
      productCount: productCount,
      tableId: tableId,
      categoryId: categoryId,
      isFinished: isFinished,
    );
  }

  OrderModel copyWith({
    String? id,
    int? productId,
    String? productName,
    double? productPrice,
    int? productCount,
    int? tableId,
    String? categoryName,
    int? categoryId,
    int? isFinished,
  }) {
    return OrderModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      tableId: tableId ?? this.tableId,
      productCount: productCount ?? this.productCount,
      categoryName: categoryName ?? this.categoryName,
      categoryId: categoryId ?? this.categoryId,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
