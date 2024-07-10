import 'package:flutter/material.dart';
import 'package:gazivoire/models/category_model/category_model.dart';

import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../models/product_model/product_model.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../panier/Panier.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryView({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  // Ajoutez cet ensemble pour suivre les indices des produits sélectionnés
  Set<int> selectedProductIndices = Set<int>();

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProducts(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void _navigateToCartPage() {
    List<ProductModel> selectedProducts =
    selectedProductIndices.map((index) => productModelList[index]).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(selectedProducts: selectedProducts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryModel.name,
          style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
      )
          : ListView(
             padding: EdgeInsets.all(16.0),
             children: [
             Padding(
              padding: EdgeInsets.all(12.0),
                child: Text(
                 "Quel type de bouteille voulez-vous ?",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
              ),
            ),
          ),
          productModelList.isEmpty
              ? const Center(
                 child: Text("Détails vides!!"),
          )
              : GridView.builder(
                padding: EdgeInsets.zero,
                    shrinkWrap: true,
                itemCount: productModelList.length,
                 gridDelegate:
                 const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                  mainAxisSpacing: 20,
                 crossAxisSpacing: 20,
                  childAspectRatio: 0.8,
            ),
                itemBuilder: (ctx, index) {
                ProductModel singleProduct = productModelList[index];
                bool isSelected =
                selectedProductIndices.contains(index);

                return Container(
                color: isSelected
                    ? Colors.blue.shade900.withOpacity(0.6)
                    : Colors.blue.shade900.withOpacity(0.3),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Image.network(
                      singleProduct.image,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      singleProduct.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("prix: ${singleProduct.price}"),
                    const SizedBox(height: 6.0),
                    // Utilisez un IconButton à la place d'un OutlinedButton
                    IconButton(
                      icon: Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isSelected
                            ? Colors.white
                            : Colors.blue.shade900,
                      ),
                      onPressed: () {
                        setState(() {
                          // Mettez à jour l'ensemble des indices des produits sélectionnés
                          if (isSelected) {
                            selectedProductIndices.remove(index);
                          } else {
                            selectedProductIndices.add(index);
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
            Container(
              width: 400,
              child: PrimaryButton(
              onpressed: _navigateToCartPage,
              title: "Suivant",
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
