import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../firebase_helper/firebase_firestore/firebase_firestore.dart';
import '../../models/category_model/category_model.dart';
import '../../models/order_model/orders_model.dart';
import '../../models/product_model/product_model.dart';
import '../../provider/app_provider.dart';
import '../gaz_detail/gaz_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCaterories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _handleRefresh() async {
      List<OrderModel> refreshedOrders = await FirebaseFirestoreHelper.instance.getOrdersByUserId();

      setState(() {
      });

      await Future.delayed(Duration(milliseconds: 1));
    }
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Gaz'Ivoire",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold,fontSize: 32),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: isLoading
          ? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      )
          :  LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: Colors.white,
        height: 100,
        backgroundColor: Colors.deepOrangeAccent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: RichText(
                  text: TextSpan(
                    text:
                    "Bienvenue ${appProvider.getUserInformation.name} ",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: const [
                      TextSpan(
                        text: "😄!",
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 6,
                ),
                items: categoriesList.map((category) {
                  return Container(
                    color: Colors.white70,
                    child: Image.network(category.image),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              Text(
                "Choisissez votre opérateur",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              categoriesList.isEmpty
                  ? const Center(
                child: Text("categorie vide!!"),
              )
                  : Center(
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: categoriesList.map((e) {
                    return InkWell(
                      onTap: () {

                        //Routes.instance.push(widget : CategoryView(categoryModel: e),context: context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GazDetailPage(categoryModel: e), // Fournissez un objet CategoryModel ici
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.blue,
                        elevation: 13.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(e.image),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 55,
        color: Colors.transparent, // Ajustez la couleur en fonction de votre conception
      ),
    );

  }
}