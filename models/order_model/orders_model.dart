import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';  // Importez la bibliothèque uuid
import '../product_model/product_model.dart';

class OrderModel {
  String userId;
  List<ProductModel> products;
  List<int> quantities;
  String deliveryAddress;
  double totalAmount;
  DateTime orderDate;
  String status;
  String orderId;
  int? deliveryOption; // Nouveau champ pour stocker l'option de livraison


  OrderModel({
    required this.userId,
    required this.products,
    required this.quantities,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required String orderId,  // Utilisez un ID fourni lors de la création
    this.deliveryOption, // Nouveau champ
  }) : orderId = orderId;  // Utilisez l'ID fourni lors de la création

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'],
      products: (json['products'] as List<dynamic>).map((product) => ProductModel.fromJson(product)).toList(),
      quantities: (json['quantities'] as List<dynamic>).map((e) => e as int).toList(),
      deliveryAddress: json['deliveryAddress'],
      totalAmount: json['totalAmount'].toDouble(),
      orderDate: (json['orderDate'] as Timestamp).toDate(),
      status: json['status'],
      orderId: json['orderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((e) => e.toJson()).toList(),
      'quantities': quantities,
      'deliveryAddress': deliveryAddress,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': status,
      'orderId': orderId,
    };
  }

  static String generateRandomID() {
    return Uuid().v4();  // Utilisez Uuid pour générer un ID unique
  }
}