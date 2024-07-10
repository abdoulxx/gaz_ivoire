import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos de Gaz'Ivoire"),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bienvenue sur Gaz'Ivoire",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "À propos de l'application",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Gaz'Ivoire est une application dédiée à la gestion et à la livraison de gaz domestique en Côte d'Ivoire. Nous simplifions le processus de commande et de livraison pour rendre l'accès au gaz plus facile et plus pratique.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Notre mission",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Faciliter l'accès au gaz domestique en fournissant une plateforme conviviale pour la commande en ligne, la gestion des livraisons et l'interaction avec nos clients. Nous nous engageons à fournir un service fiable et sûr.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Contactez-nous",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Si vous avez des questions, des commentaires ou des préoccupations, n'hésitez pas à nous contacter à gazivoire@gmail.com. Nous sommes là pour vous aider et améliorer constamment notre service.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
