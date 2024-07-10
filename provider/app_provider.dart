import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gazivoire/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:gazivoire/models/user_model/user_model.dart';

import '../constants/constants.dart';
import '../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../models/order_model/orders_model.dart';
import '../models/order_model/orders_model.dart'; // Ajoutez l'import du modèle OrdersModel

class AppProvider with ChangeNotifier {
  UserModel? _userModel;
  List<OrderModel> _userOrders = [];

  UserModel get getUserInformation => _userModel!;
  List<OrderModel> get getUserOrders => _userOrders;

  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  Future<void> getUserOrdersFirebase() async {
    _userOrders = await FirebaseFirestoreHelper.instance.getOrdersByUserId();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
      await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("success");

    notifyListeners();
  }
}
