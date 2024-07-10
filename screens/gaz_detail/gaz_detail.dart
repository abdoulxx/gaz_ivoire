import 'package:flutter/material.dart';
import '../../models/category_model/category_model.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../category_view/category_view.dart';
import '../category_view/category_view2.dart';

class GazDetailPage extends StatelessWidget {
  final CategoryModel categoryModel;

  GazDetailPage({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: GazDetailContent(categoryModel: categoryModel),
    );
  }
}

class GazDetailContent extends StatefulWidget {
  final CategoryModel categoryModel;

  GazDetailContent({required this.categoryModel});

  @override
  _GazDetailContentState createState() => _GazDetailContentState();
}

class _GazDetailContentState extends State<GazDetailContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Que Désirez-vous?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: 500,
            child: PrimaryButton(
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryView(categoryModel: widget.categoryModel),
                  ),
                );
              },
              title: "Recharger ma bouteille",
              textColor: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 500,
            child: PrimaryButton(
              onpressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryView2(categoryModel: widget.categoryModel),
                  ),
                );
              },
              title: "Acheter une bouteille",
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
