import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gazivoire/models/order_model/orders_model.dart';
import 'package:gazivoire/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:intl/intl.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../felicitation/FelicitationPage.dart';

class RecapPage extends StatefulWidget {
  final OrderModel orderDetails;

  const RecapPage({Key? key, required this.orderDetails}) : super(key: key);

  @override
  RecapPageState createState() => RecapPageState();
}

class RecapPageState extends State<RecapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recapitulation',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Merci d\'avoir choisi Gazivoire',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Vérifiez et validez votre commande',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ListTile(
                title: const Text('Adresse de livraison'),
                subtitle: Text(widget.orderDetails.deliveryAddress),
              ),
              const Divider(),
              Column(
                children: widget.orderDetails.products.map((product) {
                  return ListTile(
                    title: Row(
                      children: [
                        // Image à gauche
                        Image.network(
                          product.image,
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(width: 16), // Espace entre l'image et le texte
                        // Column avec le reste des informations à droite de l'image
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type : ${product.name}'),
                            Text('Prix unitaire : ${_formatAmount(product.price)}FCFA'),
                            Text('Quantité : ${product.quantity}',style: TextStyle(color: Colors.red),),
                            Text('Prix total : ${_formatAmount(product.totalPrice)}FCFA'),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              ListTile(
                title: const Text('Montant de la livraison'),
                trailing: Text('1000 FCFA',
                    style: TextStyle(fontSize: 20, color: Colors.blue.shade900)),
              ),
              ListTile(
                title: const Text('Montant total a payer '),
                trailing: Text('${widget.orderDetails.totalAmount + 1000} FCFA',
                    style: TextStyle(fontSize: 20, color: Colors.blue.shade900)),
              ),
              const SizedBox(height: 5),
              Container(
                width: 400,
                child: PrimaryButton(
                  onpressed: () async {
                    await createOrder();
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => FelicitationPage()),
                    );
                  },
                  title: 'Valider',
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.transparent, // Ajustez la couleur en fonction de votre conception
      ),
    );
  }

  Future<void> createOrder() async {
    try {
      // Obtenez l'ID de l'utilisateur actuel (remplacez ceci par votre propre logique d'authentification si nécessaire)
      String userId = widget.orderDetails.userId;

      // Créez la commande avec tous les détails nécessaires
      final orderDetails = OrderModel(
        userId: userId,
        products: widget.orderDetails.products,
        quantities: widget.orderDetails.quantities,
        deliveryAddress: widget.orderDetails.deliveryAddress,
        totalAmount: widget.orderDetails.totalAmount+1000,
        orderDate: DateTime.now(),
        status: 'En cours',
        orderId: widget.orderDetails.orderId,
      );

      // Créez la commande dans Firestore
      await FirebaseFirestoreHelper.instance.createOrder(orderDetails);
    } catch (e) {
      print('Erreur lors de la création de la commande : $e');
      // Gérez l'erreur comme vous le souhaitez
    }
  }
  String _formatAmount(double amount) {
    final numberFormat = NumberFormat('#,###', 'fr');
    return '${numberFormat.format(amount)} ';
  }
}
