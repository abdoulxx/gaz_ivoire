class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.price,
    this.quantity = 0,  // Ajoutez cette ligne pour initialiser la propriété quantity à 0 par défaut
    this.totalPrice = 0.0, // Ajoutez cette ligne pour initialiser la propriété totalPrice à 0.0 par défaut
  });

  String image;
  String id;
  String name;
  String description;
  String status;
  double price;
  int quantity;  // Ajoutez cette ligne pour définir la propriété quantity
  double totalPrice;  // Ajoutez cette ligne pour définir la propriété totalPrice

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    price: double.parse(json["price"].toString()),
    image: json["image"],
  );



  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
    "price": price,
    "image": image,
  };
}
