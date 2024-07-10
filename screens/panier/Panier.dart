import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazivoire/models/product_model/product_model.dart';
import 'package:gazivoire/widgets/primary_button/primary_button.dart';
import 'package:uuid/uuid.dart';
import '../../models/order_model/orders_model.dart';
import '../livraison/Livraison.dart';

class CartPage extends StatefulWidget {
  final List<ProductModel> selectedProducts;

  const CartPage({Key? key, required this.selectedProducts}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> quantities = [];

  @override
  void initState() {
    quantities = List.generate(widget.selectedProducts.length, (index) => 1);
    super.initState();
  }

  void _navigateToDeliveryPage() {
    String orderId = generateRandomID();

    final orderDetails = OrderModel(
      userId: FirebaseAuth.instance.currentUser!.uid,
      products: widget.selectedProducts,
      quantities: quantities,
      deliveryAddress: "Adresse de livraison",
      totalAmount: calculateTotalAmount(),
      orderDate: DateTime.now(),
      status: 'En cours',
      orderId: orderId,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryPage(orderDetails: orderDetails),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = calculateTotalAmount(); // Calcul du montant total

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.selectedProducts.length,
              itemBuilder: (context, index) {
                ProductModel product = widget.selectedProducts[index];
                int quantity = quantities[index];

                return Card(
                  margin: const EdgeInsets.all(16.0),
                  color: Colors.blue.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.network(
                            product.image,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text('prix: ${product.price}'),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantities[index]--;
                                  }
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: Colors.blue.shade900,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text('$quantity'),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  quantities[index]++;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                primary: Colors.white70,
                                backgroundColor: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sous-total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${calculateTotalAmount()} FCFA', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              width: 400,
              child: PrimaryButton(
                onpressed: _navigateToDeliveryPage,
                title: "Suivant",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;

    for (int i = 0; i < widget.selectedProducts.length; i++) {
      ProductModel product = widget.selectedProducts[i];
      int occurrences = quantities[i];

      // Mettez à jour le prix total pour chaque article
      totalAmount += (product.price * occurrences);

      // Mettez à jour le prix total dans le modèle de produit (facultatif, mais utile pour afficher le prix total sur la page)
      widget.selectedProducts[i].totalPrice = product.price * occurrences;
      widget.selectedProducts[i].quantity = occurrences;

    }

    return totalAmount;
  }

  String generateRandomID() {
    return Uuid().v4();  // Utilisez Uuid pour générer un ID unique
  }
}
