import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gazivoire/models/user_model/user_model.dart';
import '../../constants/constants.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(String email, String password, BuildContext context) async {
    try {
      print('Before validation - Email: $email, Password: $password');
      if (!loginValidation(email, password)) {
        return false;
      }

      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password,
      String phoneNumber, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        image: null,
      );
      await _firestore
          .collection("users")
          .doc(userModel.id)
          .set(userModel.toJson());
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
    print("Utilisateur déconnecté");

  }

  Future<bool> changePassword(String password
      , BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      Navigator.of(context).pop();
      showMessage("mot de passe changer avec success");
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 15),
              Text("Chargement..."),
            ],
          ),
        );
      },
    );
  }

  void showMessage(String message) {
    // Implement the logic to display the error message, for example, using a SnackBar.
    print("Error: $message");
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({'status': newStatus});
    } catch (e) {
      print('Erreur lors de la mise à jour du statut de la commande : $e');
      // Gérez l'erreur comme vous le souhaitez
    }
  }

}



