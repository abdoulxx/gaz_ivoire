import 'package:flutter/material.dart';
import '../../models/order_model/orders_model.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../recapitulation/Recapitulation.dart';

class DeliveryPage extends StatefulWidget {
  final OrderModel orderDetails;

  const DeliveryPage({Key? key, required this.orderDetails}) : super(key: key);

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int? selectedDeliveryOption;
  TextEditingController deliveryAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livraison',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 3,
                color: Colors.blue.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioListTile<int>(
                  title: Text('Livraison à domicile'),
                  value: 1,
                  groupValue: selectedDeliveryOption,
                  onChanged: (value) {
                    setState(() {
                      selectedDeliveryOption = value;
                    });
                  },
                ),
              ),
              if (selectedDeliveryOption == 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: deliveryAddressController,
                    decoration: const InputDecoration(
                      labelText: 'Votre adresse de livraison',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Card(
                elevation: 3,
                color: Colors.blue.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioListTile<int>(
                  title: Text('Récupérer en magasin'),
                  value: 2,
                  groupValue: selectedDeliveryOption,
                  onChanged: (value) {
                    setState(() {
                      selectedDeliveryOption = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 300),
              Container(
                width: 400,
                child: PrimaryButton(
                  onpressed: () {
                    _navigateToRecapPage(widget.orderDetails.orderId, selectedDeliveryOption == 1 ? deliveryAddressController.text : "récupération en magasin");
                  },
                  title: "Suivant",
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRecapPage(String orderId, String deliveryAddress) {
    if (selectedDeliveryOption != null) {
      // Mise à jour des détails de la commande avec les options de livraison
      widget.orderDetails.deliveryAddress = deliveryAddress;
      widget.orderDetails.status = 'En attente';

      // Naviguer vers la page de récapitulation en passant les détails de la commande
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecapPage(orderDetails: widget.orderDetails),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Veuillez sélectionner une option de livraison.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
