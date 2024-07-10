class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber = '',
    this.deliveryAddress, // Nouveau champ pour l'adresse de livraison
  });

  String? image;
  String id;
  String name;
  String email;
  String phoneNumber;
  String? deliveryAddress; // Nouveau champ pour l'adresse de livraison

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    phoneNumber: json["phoneNumber"] ?? '',
    deliveryAddress: json["deliveryAddress"], // Assurez-vous de traiter la valeur nulle
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "phoneNumber": phoneNumber,
    "deliveryAddress": deliveryAddress, // Ajoutez l'adresse de livraison lors de la conversion en JSON
  };

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? image,
    String? deliveryAddress,
    String? email, // Ajoutez le champ deliveryAddress ici
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        image: image ?? this.image,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress, // Assurez-vous de fournir la valeur actuelle si elle est nulle
      );
}
