class Pizza {
  final int id;
  final String pizzaName;
  final String description;
  final double price;
  final String imageUrl;

  Pizza.fromJson(Map<String, dynamic> json):
      id = int.tryParse(json['id'].toString()) ?? 0,
      pizzaName = json['pizzaName'].toString() ?? 'These was no name given for this Pizza',
      description = json['description'].toString() ?? 'Empty description',
      price = double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl = json['imageUrl'] ?? '';

  
}