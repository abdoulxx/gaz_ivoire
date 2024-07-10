import 'package:flutter/material.dart';

import '../../widgets/primary_button/primary_button.dart';

class FelicitationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gaz'Ivoire",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "https://www.sitepoint.com/wp-content/uploads/2015/07/1436013803checkbox-1024x1024.jpg"),
            // Remplacez 'assets/validation_image.png' par le chemin de votre image
            const Text(
              'Félicitations ! Votre commande a été passée avec succès.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            Container(
              width: 300,
              child: PrimaryButton(
                onpressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                title: "Retour à l'accueil",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
