import 'package:flutter/material.dart';
import 'package:gazivoire/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../models/order_model/orders_model.dart';

class CommandePage extends StatefulWidget {
  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  @override
  Widget build(BuildContext context) {
    double bottomNavBarHeight = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Commandes', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: Colors.blue.shade900,
        height: 100,
        backgroundColor: Colors.orange.shade100,
        child: FutureBuilder<List<OrderModel>>(
          future: FirebaseFirestoreHelper.instance.getOrdersByUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('Aucune commande trouvée.'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Tri de la liste par orderDate (du plus récent au plus ancien)
                List<OrderModel> sortedOrders = snapshot.data!;
                sortedOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));

                OrderModel order = sortedOrders[index];
                return CommandeCard(order: order);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.transparent, // Ajustez la couleur en fonction de votre conception
      ),
    );
  }

  Future<void> _handleRefresh() async {
    List<OrderModel> refreshedOrders = await FirebaseFirestoreHelper.instance.getOrdersByUserId();

    setState(() {
    });

    await Future.delayed(Duration(milliseconds: 1));
  }
}
class CommandeCard extends StatelessWidget {
  final OrderModel order;

  const CommandeCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    if (order.status == 'acceptee') {
      statusColor = Colors.green;
    } else if (order.status == 'rejetee') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.black;
    }

    return Card(
      color: Colors.orange.shade100,
      margin: EdgeInsets.all(16),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Date de commande: ${_formatOrderDate(order.orderDate)}'),
            subtitle: Text(
              'Statut: ${order.status}',
              style: TextStyle(color: statusColor),
            ),
          ),
          Divider(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.products.map((product) {
                return ListTile(
                  title: Text('${product.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prix unitaire : ${product.price} FCFA'),
                    ],
                  ),
                  leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                );
              }).toList(),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Montant total:${_formatAmount(order.totalAmount)}FCFA (Livraison incluse)'),
            subtitle: Text('Lieu de livraison: ${order.deliveryAddress}'),
          ),
        ],
      ),
    );
  }

  String _formatOrderDate(DateTime orderDate) {
    return DateFormat('yyyy-MM-dd HH:mm').format(orderDate);
  }

  String _formatAmount(double amount) {
    final numberFormat = NumberFormat('#,###', 'fr');
    return '${numberFormat.format(amount)} ';
  }

}