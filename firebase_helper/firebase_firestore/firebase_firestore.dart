import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gazivoire/constants/constants.dart';
import 'package:gazivoire/models/category_model/category_model.dart';
import 'package:gazivoire/models/product_model/product_model.dart';
import '../../models/order_model/orders_model.dart';
import '../../models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCaterories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("Products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
/////////////////////////recharge/////////////////////////////////////////////////
  Future<List<ProductModel>> getCategoryViewProducts(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
/////////////////////////achat/////////////////////////////////////////////////
  Future<List<ProductModel>> getCategoryViewProducts2(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firebaseFirestore
          .collection("categories")
          .doc(id)
          .collection("products2")
          .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }


  Future<UserModel> getUserInformation() async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    return UserModel.fromJson(querySnapshot.data()!);
  }

//////////////////////////////////////////////////////////////////

  Future<void> createOrder(OrderModel orderDetails) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderDetails.orderId)
          .set(orderDetails.toJson());
    } catch (e) {
      print('Erreur lors de la création de la commande : $e');
      // Gérez l'erreur comme vous le souhaitez
    }
  }

  Future<void> updateOrderStatusAndAddress(
      String orderId, String newStatus, String newDeliveryAddress) async {
    try {
      await _firebaseFirestore.collection('orders').doc(orderId).update({
        'status': newStatus,
        'deliveryAddress': newDeliveryAddress,
      });
    } catch (e) {
      print('Erreur lors de la mise à jour du statut de la commande : $e');
      // Gérez l'erreur comme vous le souhaitez
    }
  }

  Future<List<OrderModel>> getOrdersByUserId() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await _firebaseFirestore
                .collection('orders')
                .where('userId', isEqualTo: user.uid)
                .get();

        List<OrderModel> ordersList = querySnapshot.docs
            .map((e) => OrderModel.fromJson(e.data()))
            .toList();

        return ordersList;
      } else {
        // L'utilisateur n'est pas connecté, renvoyer une liste vide ou gérer d'une autre manière
        return [];
      }
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }



// ... Autres fonctions existantes ...
}
