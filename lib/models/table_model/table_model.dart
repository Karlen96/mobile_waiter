class TableModel {
  final int id;
  final String name;
  final int size;
  final int position;

  TableModel({
    required this.id,
    required this.name,
    required this.size,
    this.position = 0,
  });

  factory TableModel.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    final position = data['position'] as int;
    final size = data['size'] as int;

    return TableModel(
      id: id,
      name: name,
      position: position,
      size: size,
    );
  }
}
